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
import { SERVER_URL,mobile_url } from '@env';
import tw from 'tailwind-react-native-classnames';
import SimilarProducts from '../components/SimilarProducts'; // adjust if path is different


export default function ProductDetailsScreen({ route, navigation }) {
 const mobile="http://10.98.198.249:5000";
  const { item_id } = route.params;
  // console.log(item_id);
  const [productData, setProductData] = useState(null);
  const [quantity, setQuantity] = useState(1);
  const [loading, setLoading] = useState(true);
  const [relatedItems, setRelatedItems] = useState([]);
   const [selectedBatchIndex, setSelectedBatchIndex] = useState(null);
  const [selectedPrice, setSelectedPrice] = useState(null);
  const [productInfo, setProductInfo] = useState({
  price: "N/A",
  currency: "INR",
  weightPerUnit: null,
  unit: "unit",
  availableCount: 0,
});



  // ✅ Use your backend BAP IP here
  const API_URL = `${mobile}/bap/select`;
  const SEARCH_URL = `${mobile}/bap/search`;
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
        // Set productInfo here based on first batch
        if (mainItem?.batches?.length > 0) {
          const firstBatch = mainItem.batches[0];
          setProductInfo({
            price: firstBatch.price?.value || "N/A",
            currency: firstBatch.price?.currency || "INR",
            weightPerUnit: firstBatch.quantity?.unitized?.measure?.weight_per_unit || null,
            unit: firstBatch.quantity?.unitized?.measure?.unit || "unit",
            availableCount: firstBatch.quantity?.available?.count || 0,
          });
        }
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
      const response = await fetch(`${mobile}/cart/add`, {
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
  <ScrollView
    style={tw`flex-1 bg-green-50`}
    contentContainerStyle={tw`p-5 pb-16`}
    showsVerticalScrollIndicator={false}
  >
    {/* Product Image Card */}
    <View
      style={[
        tw`mb-6 rounded-3xl bg-white p-4`,
        {
          shadowColor: '#000',
          shadowOpacity: 0.08,
          shadowRadius: 12,
          shadowOffset: { width: 0, height: 6 },
          elevation: 6,
          alignItems: 'center',
          position: 'relative',
        },
      ]}
    >
      {/* Organic Tag */}
      {item?.tags?.some(tag => tag.code === 'organic' && tag.value === 'true') && (
        <View
          style={[
            tw`absolute top-4 right-4 px-3 py-1 rounded-full bg-green-600`,
            {
              shadowColor: '#155724',
              shadowOpacity: 0.3,
              shadowRadius: 6,
              elevation: 3,
            },
          ]}
        >
          <Text style={tw`text-white text-xs font-bold`}>🌱 Organic</Text>
        </View>
      )}

      <Image
        source={{ uri: item?.descriptor?.image || 'https://via.placeholder.com/150' }}
        style={[tw`w-44 h-60 rounded-2xl`, { resizeMode: 'contain' }]}
      />
    </View>

    {/* Provider & Product Name */}
    <Text style={tw`text-xs text-green-700 mb-1`}>
      Fulfilled by {provider?.descriptor?.name || 'Unknown Provider'}
    </Text>
    <Text style={tw`text-2xl font-extrabold text-gray-900 mb-3`}>
      {item?.descriptor?.name || 'Unnamed Product'}
    </Text>
    {/* 🆕 Shop Distance */}
<View style={tw`flex-row items-center mb-2`}>
  <Text style={tw`text-sm text-gray-600 mr-1`}>📍 Distance:</Text>
  <Text style={tw`text-sm font-semibold text-gray-900`}>3.2 km away</Text>
</View>


    {/* Price & Stock */}
    <View
      style={[
        tw`p-5 rounded-2xl bg-green-100 mb-6`,
        { shadowColor: '#000', shadowOpacity: 0.06, shadowRadius: 10, elevation: 4 },
      ]}
    >
      <Text style={tw`text-green-900 text-xl font-extrabold mb-1`}>
        ₹{productInfo.price}{' '}
        {productInfo.weightPerUnit
          ? `per pack of ${productInfo.weightPerUnit} ${productInfo.unit}`
          : `per ${productInfo.unit}`}
      </Text>
      <Text style={tw`text-gray-600 text-sm`}>
        {productInfo.availableCount}{' '}
        {productInfo.weightPerUnit
          ? `packs available (${productInfo.weightPerUnit} ${productInfo.unit} each)`
          : `${productInfo.unit} available`}
      </Text>
    </View>

    {/* Quantity Selector */}
    <View style={tw`flex-row items-center mb-8`}>
      <Text style={tw`text-base font-semibold mr-4`}>Quantity</Text>
      <TouchableOpacity
        onPress={() => setQuantity(Math.max(1, quantity - 1))}
        style={tw`w-12 h-12 rounded-full bg-green-200 justify-center items-center shadow`}
        activeOpacity={0.7}
      >
        <Text style={tw`text-xl font-bold text-green-900`}>−</Text>
      </TouchableOpacity>
      <Text style={tw`mx-5 text-lg font-semibold text-gray-900`}>{quantity}</Text>
      <TouchableOpacity
        onPress={() => setQuantity(quantity + 1)}
        style={tw`w-12 h-12 rounded-full bg-green-200 justify-center items-center shadow`}
        activeOpacity={0.7}
      >
        <Text style={tw`text-xl font-bold text-green-900`}>+</Text>
      </TouchableOpacity>
    </View>

    {/* Product Overview */}
    <View style={tw`mb-6`}>
      <Text style={tw`text-lg font-semibold text-gray-900 mb-2`}>Product Overview</Text>
      <Text style={tw`text-sm text-gray-700 leading-relaxed`}>
        {item?.descriptor?.description || 'No description available.'}
      </Text>
    </View>

    {/* Tags
    {item?.tags?.length > 0 && (
      <View style={tw`mb-6`}>
        <Text style={tw`text-base font-semibold text-gray-900 mb-2`}>Tags:</Text>
        <View style={tw`flex-row flex-wrap`}>
          {item.tags.map((tag, idx) => (
            <View key={idx} style={tw`mr-2 mb-2 px-3 py-1 rounded-full bg-green-200`}>
              <Text style={tw`text-green-900 text-sm font-medium`}>{tag.value}</Text>
            </View>
          ))}
        </View>
      </View>
    )} */}

    {/* Available Batches */}
    {item?.batches?.length > 0 && (
      <View style={tw`mb-6`}>
        <Text style={tw`text-lg font-semibold text-gray-900 mb-4`}>Available Batches</Text>
        {item.batches.map((batch, index) => {
          const isSelected = selectedBatchIndex === index;
          const batchQuantity = batch?.quantity?.available?.count ?? 0;
          const batchUnit = batch?.quantity?.unitized?.measure?.unit || '';
          const weightPerUnit = batch?.quantity?.unitized?.measure?.weight_per_unit || null;
          const unitDisplay = weightPerUnit
            ? `${batchQuantity} packs (${weightPerUnit} ${batchUnit} each)`
            : `${batchQuantity} ${batchUnit}`;

          return (
            <TouchableOpacity
              key={index}
              onPress={() => handleBatchSelect(index)}
              style={tw.style(
                'p-4 mb-4 rounded-2xl border',
                isSelected ? 'border-green-500 bg-green-50' : 'border-gray-200 bg-white'
              )}
              activeOpacity={0.8}
            >
              <Text style={tw`text-lg font-bold text-green-700 mb-1`}>
                ₹{batch.price?.value ?? 'N/A'}
              </Text>
              <Text style={tw`text-sm text-gray-600`}>Stock: {unitDisplay}</Text>
              <Text style={tw`text-sm text-gray-500`}>
                Expiry Date:{' '}
                {batch.expiry_date
                  ? new Date(batch.expiry_date).toLocaleDateString()
                  : 'N/A'}
              </Text>
              {isSelected && <Text style={tw`text-green-600 font-medium mt-2`}>✔ Selected</Text>}
            </TouchableOpacity>
          );
        })}
      </View>
    )}

    {/* Pickup Location */}
    {fulfillment && (
      <View style={tw`mb-6`}>
        <Text style={tw`text-base font-semibold text-gray-900`}>Pickup Location</Text>
        <Text style={tw`text-sm text-gray-700`}>{fulfillment?.location?.address}</Text>
        <Text style={tw`text-xs text-gray-500`}>GPS: {fulfillment?.location?.gps}</Text>
      </View>
    )}

    {/* Add to Cart Button */}
    <TouchableOpacity
      style={tw`bg-green-600 py-4 rounded-3xl items-center shadow-lg`}
      onPress={() =>
        handleAddToCart({
          user_id: 'a985baac-9028-4dc1-bbd9-a6f3aae49ef5',
          bpp_id: productData?.bpp_id || 'agri.bpp',
          bpp_product_id: item?.id,
          provider_id: provider?.id,
          provider_name: provider?.descriptor?.name,
          provider_address: fulfillment?.location?.address || '',
          fulfillment_id: fulfillment?.id || '',
          item_name: item?.descriptor?.name,
          quantity: quantity,
          unit_price: selectedPrice || 0,
          image_url: item?.descriptor?.image || '',
          category: item?.category_id,
        })
      }
      activeOpacity={0.85}
    >
      <Text style={tw`text-white text-lg font-bold`}>🛒 Add to Cart</Text>
    </TouchableOpacity>

    {/* Similar Products */}
    <SimilarProducts relatedItems={relatedItems} navigation={navigation} />
  </ScrollView>
);



}