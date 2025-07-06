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

  // ✅ Use your backend BAP IP here
  const API_URL = "http://192.168.199.249:5000/bap/select";
  const SEARCH_URL = "http://192.168.199.249:5000/bap/search";
  // ✅ Define inside component so you can access state
  const fetchSimilarProducts = async (categoryName) => {
     try {
         
      const res = await fetch(SEARCH_URL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
         },
         body: JSON.stringify({
           productName: "",
           category:categoryName,
           lat: 10.7867,
           lon: 79.1378,
           radius: 300,
         }),
       });

       const json = await res.json();
       const items = json.catalog?.message?.catalog?.items || [];
       const providers = json.catalog?.message?.catalog?.providers || [];
       const fulfillments = json.catalog?.message?.catalog?.fulfillments || [];

       const enrichedItems = items.map((it) => {
         return {
           ...it,
           provider: providers.find((p) => p.id === it.provider?.id),
           fulfillment: fulfillments.find((f) => f.id === it.fulfillment_id),
         };
       });

       setRelatedItems(enrichedItems); // ✅ Now safe to use
     } catch (error) {
       console.error("Error fetching similar products:", error);
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
  const fulfillment = productData.fulfillments.find(
    (f) => f.id === item.fulfillment_id
  );

  const handleAddToCart = () => {
    Alert.alert("Added to Cart", `${item.descriptor.name} x ${quantity}`);
  };

  return (
    <ScrollView style={tw`p-4`}>
      <View style={tw`items-center`}>
        <Image
          source={{ uri: item.descriptor.image }}
          style={[tw`w-36 h-48 rounded-lg`, { resizeMode: 'contain' }]}
        />
      </View>

      {/* Provider & Item Info */}
      <Text style={tw`text-xs text-gray-400 mt-4`}>
        Fulfilled by: {provider.descriptor.name}
      </Text>
      <Text style={tw`text-xl font-semibold mt-1`}>{item.descriptor.name}</Text>

      {/* Price & Quantity */}
      <View style={tw`mt-3`}>
        <Text style={tw`text-green-700 text-xl font-bold`}>
          ₹{item.price.value} {item.price.currency} /{' '}
          {item.quantity.unitized.measure.unit}
        </Text>
        <Text style={tw`text-sm text-gray-500`}>
          Available: {item.quantity.available.count}{' '}
          {item.quantity.unitized?.measure?.unit || ''}
        </Text>
      </View>

      {/* Quantity Selector */}
      <View style={tw`flex-row items-center mt-4`}>
        <Text style={tw`text-base font-medium mr-3`}>Quantity</Text>
        <TouchableOpacity
          style={tw`border px-3 py-1 rounded`}
          onPress={() => setQuantity(Math.max(1, quantity - 1))}
        >
          <Text>-</Text>
        </TouchableOpacity>
        <Text style={tw`mx-3`}>{quantity}</Text>
        <TouchableOpacity
          style={tw`border px-3 py-1 rounded`}
          onPress={() => setQuantity(quantity + 1)}
        >
          <Text>+</Text>
        </TouchableOpacity>
      </View>

      {/* Description */}
      <View style={tw`mt-6`}>
        <Text style={tw`text-lg font-semibold mb-2`}>Product Overview</Text>
        <Text style={tw`text-sm text-gray-700`}>
          {item.descriptor.description}
        </Text>
      </View>

      {/* Tags */}
      {item.tags?.length > 0 && (
        <View style={tw`mt-4`}>
          <Text style={tw`text-base font-medium mb-1`}>Tags:</Text>
          {item.tags.map((tag, idx) => (
            <Text key={idx} style={tw`text-sm text-gray-600`}>
              {tag.code}: {tag.value}
            </Text>
          ))}
        </View>
      )}

      {/* Fulfillment Details */}
      {fulfillment && (
        <View style={tw`mt-4`}>
          <Text style={tw`text-base font-medium`}>Pickup Location</Text>
          <Text style={tw`text-sm text-gray-600`}>
            {fulfillment.location.address}
          </Text>
          <Text style={tw`text-sm text-gray-500`}>
            GPS: {fulfillment.location.gps}
          </Text>
        </View>
      )}

      {/* Add to Cart */}
      <TouchableOpacity
        style={tw`bg-green-600 py-3 rounded mt-6 items-center`}
        onPress={handleAddToCart}
      >
        <Text style={tw`text-white font-semibold`}>Add to Cart</Text>
      </TouchableOpacity>

      {/* SIMILAR PRODUCTS*/}
       <SimilarProducts relatedItems={relatedItems} navigation={navigation} />
    </ScrollView>
  );
}
