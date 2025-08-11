import React, { useState } from "react";
import axios from 'axios';
import {
  View,
  Text,
  Image,
  TouchableOpacity,
  ScrollView,
  KeyboardAvoidingView,
  Platform,
  Alert,
} from "react-native";
import tw from "tailwind-react-native-classnames";

export default function ProviderItemsScreen({ navigation, route }) {
  const [provider, setProvider] = useState(route.params?.provider);
  const isOrganic=true;
  console.log(provider);
 const handleInit = async () => {
  try {
    const response = await axios.post(
      'http://localhost:5000/bap/init',
      {
        provider_id: provider.provider_id, // ✅ Fix: use provider_id instead of provider.id
        items: provider.items.map(item => ({
          id: item.bpp_product_id, // ✅ Use correct key
          quantity: item.quantity,
          fulfillment_id: item.fulfillment_id
        })),
        delivery_address: {
          gps: "23.0225,72.5714",
          address: "Plot 12, SG Road, Ahmedabad, Gujarat"
        }
      },
      {
        headers: {
          'x-transaction-id': 'txn-' + Date.now()
        }
      }
    );

    const bpp_response = response.data.bpp_response;
    console.log("✅ BPP Response:", bpp_response);
    
    navigation.navigate("VerifyProductsScreen", { bpp_response });

  } catch (error) {
    console.error("❌ Init API failed:", error.message);
    Alert.alert("Failed to verify products. Please try again.");
  }
};



  
  const updateCartQuantity = async (item, newQty) => {
  try {
    const response = await fetch("http://localhost:5000/cart/update", {
      method: "PUT", // ✅ Use PUT
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        user_id: "a985baac-9028-4dc1-bbd9-a6f3aae49ef5",
        bpp_product_id: item.bpp_product_id,
        provider_id: provider.provider_id,
        quantity: newQty,
      }),
    });

    // Check for proper content type
    const contentType = response.headers.get("content-type");
    if (!response.ok) {
      throw new Error(`HTTP ${response.status} - ${response.statusText}`);
    }

    if (contentType && contentType.includes("application/json")) {
      const data = await response.json();
      console.log("✅ Quantity updated", data);

      let updatedItems;

      if (newQty === 0) {
        // ❌ Remove item from list if quantity is 0
        updatedItems = provider.items.filter(
          (i) => i.bpp_product_id !== item.bpp_product_id
        );
      } else {
        // ✅ Update item's quantity and total_price
        updatedItems = provider.items.map((i) =>
          i.bpp_product_id === item.bpp_product_id
            ? {
                ...i,
                quantity: newQty,
                total_price: parseFloat((newQty * (i.unit_price || 0)).toFixed(2)),
              }
            : i
        );
      }
      setProvider({ ...provider, items: updatedItems });
    } else {
      const html = await response.text(); // catch HTML error responses
      console.error("❌ Server returned HTML instead of JSON:", html);
    }
  } catch (err) {
    console.error("⚠️ Error updating quantity", err.message || err);
  }
};


  if (!provider) {
    return (
      <View style={tw`flex-1 justify-center items-center`}>
        <Text style={tw`text-red-600 text-lg font-semibold`}>
          ⚠️ No provider data available
        </Text>
      </View>
    );
  }

  const totalMRP = (provider.items || []).reduce(
    (sum, item) => sum + (item.total_price || 0),
    0
  );

 return (
  <KeyboardAvoidingView
    style={tw`flex-1 bg-green-50`}
    behavior={Platform.OS === "ios" ? "padding" : "height"}
    keyboardVerticalOffset={Platform.OS === "ios" ? 100 : 0}
  >
    <ScrollView style={tw`p-4`} contentContainerStyle={{ paddingBottom: 140 }}>
      {/* Header */}
      <View style={tw`bg-green-100 p-5 rounded-2xl mb-6 shadow-sm`}>
        <Text style={tw`text-xl font-bold text-green-800 mb-1`}>
          {provider.provider_name}
        </Text>
        <Text style={tw`text-sm text-green-700`}>
          {provider.provider_address}
        </Text>
      </View>

      {/* Product List */}
      {(provider.items || []).map((item, index) => (
        <TouchableOpacity
          key={index}
          activeOpacity={0.85}
          style={[
            tw`bg-white p-4 mb-4 rounded-2xl border border-green-100 shadow-sm`,
          ]}
          onPress={() =>
            navigation.navigate("ProductDetails", {
              item_id: item.bpp_product_id,
            })
          }
        >
          <View style={tw`flex-row items-center`}>
            {/* Thumbnail */}
           <View style={tw`relative mr-4`}>
  <Image
    source={{ uri: item.image_url || "https://via.placeholder.com/60" }}
    style={tw`w-16 h-16 rounded-xl`}
  />
  {isOrganic && (
    <View
      style={[
        tw`absolute bg-green-200`,
        {
          top: -8,           // move up outside image
          right: -10,        // move right outside image
          paddingHorizontal: 10,
          paddingVertical: 4,
          borderRadius: 20,  // pill shape
          shadowColor: '#000',
          shadowOpacity: 0.1,
          shadowRadius: 4,
          elevation: 3,
        },
      ]}
    >
      <Text style={tw`text-green-800 text-xs font-semibold`}>Organic</Text>
    </View>
  )}
</View>


            {/* Product Info and Controls */}
            <View style={tw`flex-1`}>
              <Text style={tw`font-semibold text-gray-800 text-lg`}>
                {item.item_name}
              </Text>

              {/* Quantity Controls */}
              <View style={tw`flex-row items-center mt-3`}>
                <TouchableOpacity
                  onPress={() => updateCartQuantity(item,item.quantity - 1)}
                  style={tw`w-10 h-10 rounded-full bg-gray-200 justify-center items-center shadow mr-4`}
                  activeOpacity={0.7}
                >
                  <Text style={tw`text-2xl font-semibold text-gray-700`}>−</Text>
                </TouchableOpacity>

                <Text style={tw`text-lg font-bold text-gray-800 mx-2`}>
                  {item.quantity}
                </Text>

                <TouchableOpacity
                  onPress={() => updateCartQuantity(item, item.quantity + 1)}
                  style={tw`w-10 h-10 rounded-full bg-gray-200 justify-center items-center shadow ml-4`}
                  activeOpacity={0.7}
                >
                  <Text style={tw`text-2xl font-semibold text-gray-700`}>+</Text>
                </TouchableOpacity>
              </View>

              <View style={tw`flex-row justify-between mt-2 items-center`}>
                <Text style={tw`text-sm text-green-700`}>
                  Unit Price: ₹{item.unit_price}
                </Text>
                <Text style={tw`text-green-800 font-bold text-lg`}>
                  ₹{item.total_price}
                </Text>
              </View>
            </View>
          </View>
        </TouchableOpacity>
      ))}
    </ScrollView>

    {/* Sticky Footer */}
    <View
      style={[
        tw`absolute bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-5 py-4`,
        { shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 8, elevation: 10 }
      ]}
    >
      <View style={tw`bg-gray-100 p-4 rounded-xl shadow-sm mb-4`}>
        <Text style={tw`font-semibold text-gray-800 text-lg`}>
          Total Amount: ₹{totalMRP + 10}
        </Text>
        <Text style={tw`text-xs text-gray-500`}>
          Includes ₹40 shipping
        </Text>
      </View>

      <TouchableOpacity
        onPress={handleInit}
        activeOpacity={0.9}
        style={tw`bg-green-600 p-4 rounded-full shadow-lg`}
      >
        <Text style={tw`text-white font-bold text-center text-lg`}>
          Verify Products & Continue
        </Text>
      </TouchableOpacity>
    </View>
  </KeyboardAvoidingView>
);

}
