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
        lat: 10.7867,
        lon: 79.1378,
        radius: 300,
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

    console.log("✅ Enriched Similar Products:", enrichedItems);
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
     console.log(json);
      // ✅ Safe access to nested response
      if (json?.bpp_response?.message?.catalog) {
        setProductData(json.bpp_response.message.catalog);
        const mainItem =json.bpp_response.message.catalog.providers[0].items[0];
      
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
  // console.log("items",item);
  const fulfillment = productData.fulfillments.find(
    (f) => f.id === item.fulfillment_id
  );

  const handleAddToCart = async (item) => {
    try {
      const response = await fetch("http://localhost:5000/cart/add", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(item),
      });
      
      const data = await response.json();
      
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
  <ScrollView style={tw`p-4 bg-green-50`}>
    {/* Image Section */}
    <View style={tw`items-center mb-5`}>
      <Image
        source={{ uri: item?.descriptor?.image || 'https://via.placeholder.com/150' }}
        style={[tw`w-36 h-48 rounded-2xl shadow-md`, { resizeMode: 'contain' }]}
      />
    </View>

    {/* Provider & Item Info */}
    <Text style={tw`text-xs text-green-600`}>Fulfilled by: {provider?.descriptor?.name}</Text>
    <Text style={tw`text-2xl font-bold text-gray-800 mt-1`}>{item?.descriptor?.name}</Text>

    {/* Price & Stock */}
    <View style={tw`mt-3 p-3 bg-green-100 rounded-lg shadow-sm`}>
      <Text style={tw`text-green-700 text-xl font-extrabold`}>
        ₹{item?.batches?.[0]?.price?.value || 'N/A'} {item?.batches?.[0]?.price?.currency || 'INR'} / {item?.quantity?.unitized?.measure?.unit || 'unit'}
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
      >
        <Text style={tw`text-xl font-bold text-green-800`}>−</Text>
      </TouchableOpacity>
      <Text style={tw`mx-4 text-lg font-semibold text-gray-800`}>{quantity}</Text>
      <TouchableOpacity
        onPress={() => setQuantity(quantity + 1)}
        style={tw`w-10 h-10 rounded-full bg-green-200 justify-center items-center shadow-sm`}
        activeOpacity={0.7}
      >
        <Text style={tw`text-xl font-bold text-green-800`}>+</Text>
      </TouchableOpacity>
    </View>

    {/* Description */}
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
        {item.tags.map((tag, idx) => (
          <Text key={idx} style={tw`text-sm text-gray-600`}>
            {tag.code}: {tag.value}
          </Text>
        ))}
      </View>
    )}

     {/* Batches Info */}
      {item?.batches?.length > 0 && (
        <View style={tw`mt-6`}>
          <Text style={tw`text-base font-semibold text-gray-800 mb-2`}>
            Available Batches:
          </Text>

          {item.batches.map((batch, index) => {
            const isSelected = selectedBatchIndex === index;

            return (
              <TouchableOpacity
                key={index}
                onPress={() => handleBatchSelect(index)}
                style={tw.style(
                  'p-3 rounded-lg mb-2 shadow-sm border',
                  isSelected ? 'border-blue-500 bg-blue-50' : 'border-gray-300 bg-white'
                )}
              >
                <Text style={tw`text-green-800 font-semibold`}>
                  ₹{batch.price?.value || 'N/A'}
                </Text>
                <Text style={tw`text-gray-600 text-sm`}>
                  Expiry:{' '}
                  {batch.expiry_date
                    ? new Date(batch.expiry_date).toLocaleDateString()
                    : 'N/A'}
                </Text>
                {isSelected && (
                  <Text style={tw`text-blue-600 mt-1`}>✔ Selected</Text>
                )}
              </TouchableOpacity>
            );
          })}
        </View>
      )}

    {/* Fulfillment Info */}
    {fulfillment && (
      <View style={tw`mt-5`}>
        <Text style={tw`text-base font-semibold text-gray-800`}>Pickup Location</Text>
        <Text style={tw`text-sm text-gray-700`}>
          {fulfillment?.location?.address}
        </Text>
        <Text style={tw`text-xs text-gray-500`}>
          GPS: {fulfillment?.location?.gps}
        </Text>
      </View>
    )}

    {/* Add to Cart Button */}
    <TouchableOpacity
      style={tw`bg-green-600 py-4 rounded-2xl mt-8 items-center shadow-md`}
      onPress={() =>
        handleAddToCart({
          user_id: "d7c6b53e-9472-4c23-bc76-e8c29718383e", // Replace dynamically
          bpp_id: productData?.bpp_id || "agri.bpp",
          bpp_product_id: item?.id,
          provider_id: provider?.id,
          provider_name: provider?.descriptor?.name,
          provider_address: fulfillment?.location?.address || "",
          fulfillment_id: fulfillment?.id || "",
          item_name: item?.descriptor?.name,
          quantity: quantity,
          unit_price: selectedPrice|| 0,
          image_url: item?.descriptor?.image|| "" ,
        })
      }
      activeOpacity={0.85}
    >
      <Text style={tw`text-white text-base font-bold`}>🛒 Add to Cart</Text>
    </TouchableOpacity>

    {/* SIMILAR PRODUCTS */}
    <SimilarProducts relatedItems={relatedItems} navigation={navigation} />
  </ScrollView>
);

}
