import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  Image,
  TouchableOpacity,
  ScrollView,
  Alert,
  ActivityIndicator,
} from "react-native";
import tw from 'tailwind-react-native-classnames';
import SimilarProducts from '../components/SimilarProducts'; // adjust if path is different


export default function ProductDetailsScreen({ route, navigation }) {
 
  const { item_id } = route.params;
  // console.log(item_id);
  const [productData, setProductData] = useState(null);
  const [quantity, setQuantity] = useState(1);
  const [loading, setLoading] = useState(true);
  const [relatedItems, setRelatedItems] = useState([]);
   const [selectedBatchIndex, setSelectedBatchIndex] = useState(null);
  const [selectedPrice, setSelectedPrice] = useState(null);


  // ✅ Use your backend BAP IP here
  const API_URL = "http://localhost:5000/bap/select";
  const SEARCH_URL = "http://localhost:5000/bap/search";
 const fetchSimilarProducts = async (categoryName) => {
  try {
    const res = await fetch(SEARCH_URL, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        productName: "",
        category: categoryName,
        lat:23.2599,
        lon:79.0882,
        radius:1000,
      }),
    });

    const json = await res.json();

    const catalog = json.catalog?.message?.catalog || {};
    const items = catalog.items || [];
    console.log("items",items);
    const providers = catalog.providers || [];
    const fulfillments = catalog.fulfillments || [];

    const enrichedItems = items.map((item) => {
      const provider = providers.find((p) => p.id === item.provider?.id);
      const fulfillment = fulfillments.find((f) => f.id === item.fulfillment_id);
      const location = provider?.locations?.find((loc) => loc.id === item.location_id);

      return {
        ...item,
        price: item.batches?.[0]?.price || { value: "0", currency: "INR" },
        image: item.descriptor?.images?.[0] || null,
        providerName: provider?.descriptor?.name || "Unknown Provider",
        providerAddress: location?.address || "Unknown Address",
        gps: location?.gps || "",
        fulfillmentAddress: fulfillment?.start?.location?.address || "",
        fulfillmentGps: fulfillment?.start?.location?.gps || "",
      };
    });

    // console.log("✅ Enriched Similar Products:", enrichedItems);
    setRelatedItems(enrichedItems);
  } catch (error) {
    console.error("❌ Error fetching similar products:", error);
  }
};

  const fetchProductDetails = async () => {
    try {
      const payload = {
        items: [{ id: item_id }],
      };


      const res = await fetch(API_URL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(payload),
      });

      const json = await res.json();
    //  console.log(json);
      // ✅ Safe access to nested response
      if (json?.bpp_response?.message?.catalog) {
        setProductData(json.bpp_response.message.catalog);
        const mainItem =json.bpp_response.message.catalog.providers[0].items[0];
        // console.log("mainItem",mainItem);
        await fetchSimilarProducts(mainItem.category_id);
      } else {
        throw new Error("Invalid response format from BAP");
      }
    } catch (error) {
      console.error("Error fetching product:", error);
      Alert.alert("Error", "Failed to load product details");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    setQuantity(1);
    fetchProductDetails();
  }, [item_id]); // 🔁 refetch when item_id changes

  if (loading) {
    return (
      <View className="flex-1 justify-center items-center bg-white">
        <ActivityIndicator size="large" color="#00cc66" />
        <Text className="mt-2">Loading product...</Text>
      </View>
    );
  }

  if (!productData || !productData.providers?.length) {
    return (
      <View className="flex-1 justify-center items-center bg-white p-4">
        <Text className="text-red-500 font-semibold text-lg">
          ⚠️ No product data available.
        </Text>
      </View>
    );
  }

  const provider = productData.providers[0];
  const item = provider.items[0];
  
  console.log("items select",item.batches);
  const fulfillment = productData.fulfillments.find(
    (f) => f.id === item.fulfillment_id
  );

  const handleAddToCart = async (item) => {
    try {
       if (item.unit_price == 0) {
    console.log("Missing Price", "This item has no price. Please select a batch or try another product.");
    return;
  }
      const response = await fetch("http://localhost:5000/cart/add", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(item),
      });
      
      const data = await response.json();
      console.log("cart",item);
      if (response.ok) {
        console.log("cart",item);
        console.log("✅ Cart added successfully:", data);
      } else {
        console.error("❌ Failed to add to cart:", data.message || data);
      }
    } catch (error) {
      console.error("⚠️ Error in API call:", error);
    }
  };

   const handleBatchSelect = (index) => {
    setSelectedBatchIndex(index);

    const priceValue = parseFloat(item?.batches?.[index]?.price?.value || 0);
    // console.log("price value",priceValue);
    setSelectedPrice(priceValue);
  };

 return (
  <ScrollView style={tw`p-4 bg-green-50`} showsVerticalScrollIndicator={false}>
    <View
  style={[
    tw`mb-8 rounded-2xl p-4 bg-green-50`,
    {
      shadowColor: '#3a6a35',
      shadowOffset: { width: 0, height: 6 },
      shadowOpacity: 0.15,
      shadowRadius: 12,
      elevation: 5,
      position: 'relative', // enable absolute positioning of children
      alignItems: 'center',
    },
  ]}
  accessible={true}
  accessibilityLabel={`Product image of ${item?.descriptor?.name || 'product'}`}
>
  {/* Organic Tag */}
  {item?.tags?.some(tag => tag.code === 'organic' && tag.value === 'true') && (
    <View
      style={[
        tw`absolute top-3 right-3 px-3 py-1 rounded-full bg-green-600`,
        { shadowColor: '#155724', shadowOpacity: 0.3, shadowRadius: 4, elevation: 3 },
      ]}
      accessible={true}
      accessibilityLabel="Organic product"
    >
      <Text style={tw`text-white text-xs font-semibold`}>Organic</Text>
    </View>
  )}

  <Image
    source={{ uri: item?.descriptor?.image || 'https://via.placeholder.com/150' }}
    style={[tw`w-40 h-56 rounded-2xl`, { resizeMode: 'contain' }]}
  />
</View>



    {/* Provider & Product Name */}
    <Text style={tw`text-xs text-green-600 mb-1`}>
      Fulfilled by: {provider?.descriptor?.name || 'Unknown Provider'}
    </Text>
    <Text style={tw`text-2xl font-bold text-gray-800`}>
      {item?.descriptor?.name || 'Unnamed Product'}
    </Text>

    {/* Price & Stock */}
    <View style={tw`mt-3 p-3 bg-green-100 rounded-lg shadow-sm`}>
  <Text style={tw`text-green-700 text-xl font-extrabold`}>
    ₹{item?.batches?.[0]?.price?.value ?? 'N/A'} 
    {` ${item?.batches?.[0]?.price?.currency || 'INR'} / ${item?.quantity?.unitized?.measure?.unit || 'unit'}`}
  </Text>
  <Text style={tw`text-sm text-gray-600 mt-1`}>
    Available: {item?.quantity?.available?.count ?? 0} {item?.quantity?.unitized?.measure?.unit || ''}
  </Text>
</View>

    {/* Quantity Selector */}
    <View style={tw`flex-row items-center mt-5`}>
      <Text style={tw`text-base font-semibold mr-4`}>Quantity</Text>
      <TouchableOpacity
        onPress={() => setQuantity(Math.max(1, quantity - 1))}
        style={tw`w-10 h-10 rounded-full bg-green-200 justify-center items-center shadow-sm`}
        activeOpacity={0.7}
        accessibilityRole="button"
        accessibilityLabel="Decrease quantity"
      >
        <Text style={tw`text-xl font-bold text-green-800`}>−</Text>
      </TouchableOpacity>
      <Text style={tw`mx-4 text-lg font-semibold text-gray-800`}>{quantity}</Text>
      <TouchableOpacity
        onPress={() => setQuantity(quantity + 1)}
        style={tw`w-10 h-10 rounded-full bg-green-200 justify-center items-center shadow-sm`}
        activeOpacity={0.7}
        accessibilityRole="button"
        accessibilityLabel="Increase quantity"
      >
        <Text style={tw`text-xl font-bold text-green-800`}>+</Text>
      </TouchableOpacity>
    </View>

    {/* Product Overview */}
    <View style={tw`mt-6`}>
      <Text style={tw`text-lg font-semibold mb-2 text-gray-800`}>Product Overview</Text>
      <Text style={tw`text-sm text-gray-700 leading-relaxed`}>
        {item?.descriptor?.description || 'No description available.'}
      </Text>
    </View>

    {/* Tags */}
    {item?.tags?.length > 0 && (
      <View style={tw`mt-4`}>
        <Text style={tw`text-base font-semibold text-gray-800 mb-1`}>Tags:</Text>
        <View style={tw`flex-row flex-wrap`}>
          {item.tags.map((tag, idx) => (
            <View
              key={idx}
              style={tw`mr-2 mb-2 px-3 py-1 bg-green-100 rounded-full`}
              accessible
              accessibilityLabel={`Tag: ${tag.value}`}
            >
              <Text style={tw`text-sm text-green-800`}>{tag.value}</Text>
            </View>
          ))}
        </View>
      </View>
    )}

 {/* Available Batches */}
{item?.batches?.length > 0 && (
  <View style={tw`mt-6`}>
    <Text style={tw`text-lg font-semibold text-gray-900 mb-4`}>
      Available Batches
    </Text>

    {item.batches.map((batch, index) => {
      const isSelected = selectedBatchIndex === index;

      const batchQuantity = batch?.quantity?.available?.count ?? 0;
      const batchUnit = batch?.quantity?.unitized?.measure?.unit || '';

      return (
        <TouchableOpacity
          key={index}
          onPress={() => handleBatchSelect(index)}
          style={tw.style(
            'p-4 rounded-2xl mb-4 shadow-sm border',
            isSelected
              ? 'border-blue-500 bg-blue-50'
              : 'border-gray-200 bg-white'
          )}
        >
          {/* Price */}
          <Text style={tw`text-lg font-bold text-green-700 mb-1`}>
            ₹{batch.price?.value ?? 'N/A'}
          </Text>

          {/* Quantity */}
          <Text style={tw`text-sm text-gray-600`}>
            Quantity: {batchQuantity} {batchUnit}
          </Text>

          {/* Expiry */}
          <Text style={tw`text-sm text-gray-500`}>
            Expiry: {batch.expiry_date
              ? new Date(batch.expiry_date).toLocaleDateString()
              : 'N/A'}
          </Text>

          {/* Selected Indicator */}
          {isSelected && (
            <Text style={tw`text-blue-600 font-medium mt-2`}>
              ✔ Selected
            </Text>
          )}
        </TouchableOpacity>
      );
    })}
  </View>
)}



    {/* Pickup Location */}
    {fulfillment && (
      <View style={tw`mt-5`}>
        <Text style={tw`text-base font-semibold text-gray-800`}>Pickup Location</Text>
        <Text style={tw`text-sm text-gray-700`}>{fulfillment?.location?.address}</Text>
        <Text style={tw`text-xs text-gray-500`}>GPS: {fulfillment?.location?.gps}</Text>
      </View>
    )}

    {/* Add to Cart Button */}
    <TouchableOpacity
      style={tw`bg-green-600 py-4 rounded-2xl mt-8 items-center shadow-md`}
      onPress={() =>
        handleAddToCart({
          user_id: "a985baac-9028-4dc1-bbd9-a6f3aae49ef5", // Replace dynamically
          bpp_id: productData?.bpp_id || "agri.bpp",
          bpp_product_id: item?.id,
          provider_id: provider?.id,
          provider_name: provider?.descriptor?.name,
          provider_address: fulfillment?.location?.address || "",
          fulfillment_id: fulfillment?.id || "",
          item_name: item?.descriptor?.name,
          quantity: quantity,
          unit_price: selectedPrice || 0,
          image_url: item?.descriptor?.image || "",
          category: item?.category_id,
        })
      }
      activeOpacity={0.85}
      accessibilityRole="button"
      accessibilityLabel="Add to cart"
    >
      <Text style={tw`text-white text-base font-bold`}>🛒 Add to Cart</Text>
    </TouchableOpacity>

    {/* Similar Products */}
    <SimilarProducts relatedItems={relatedItems} navigation={navigation} />
  </ScrollView>
);


}
