import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  ActivityIndicator,
  Alert,
} from "react-native";
import tw from "tailwind-react-native-classnames";

export default function ViewCartScreen({ navigation }) {
  const [cartData, setCartData] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchCartData = async () => {
    try {
      const response = await fetch(
        `${SERVER_URL}/cart/view/d7c6b53e-9472-4c23-bc76-e8c29718383e`
      );
      const json = await response.json();
      setCartData(json.cart || []);
    } catch (err) {
      console.error("❌ Failed to fetch cart:", err);
      Alert.alert("Error", "Failed to load cart data.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchCartData();
  }, []);

  if (loading) {
    return (
      <View style={tw`flex-1 justify-center items-center`}>
        <ActivityIndicator size="large" color="green" />
        <Text style={tw`mt-2`}>Loading your cart...</Text>
      </View>
    );
  }

 if (!cartData || cartData.length === 0) {
  return (
    <View style={tw`flex-1 justify-center items-center p-6 bg-green-50`}>
      <View style={tw`bg-green-100 p-5 rounded-full mb-4`}>
        <Text style={tw`text-3xl text-green-600`}>🛒</Text>
      </View>
      <Text style={tw`text-xl font-semibold text-gray-800 mb-2`}>
        Your Cart Feels Light
      </Text>
      <Text style={tw`text-gray-500 text-center mb-6 w-4/5`}>
        Add some fresh products to get started
      </Text>
      <TouchableOpacity
        style={tw`bg-green-500 py-3 px-6 rounded-xl shadow-md`}
        onPress={() => navigation.navigate('Home')}
      >
        <Text style={tw`text-white font-semibold text-base`}>
          Browse Products
        </Text>
      </TouchableOpacity>
    </View>
  );
}

return (
  <View style={tw`flex-1 bg-green-50`}>
    {/* 🟢 Header */}
    <View style={tw`bg-green-500 px-5 pt-6 pb-4 shadow-md rounded-b-2xl`}>
      <View style={tw`flex-row justify-between items-center`}>
        <Text style={tw`text-2xl font-bold text-white`}>My Cart</Text>
        <View style={tw`bg-green-400 px-3 py-1 rounded-full`}>
          <Text style={tw`text-white text-sm font-semibold`}>
            {cartData.reduce((acc, curr) => acc + (curr.items?.length || 0), 0)} items
          </Text>
        </View>
      </View>
    </View>

    {/* 📦 Cart Items */}
    <ScrollView
      style={tw`px-4 pt-4`}
      contentContainerStyle={tw`pb-28`} // extra space for bottom CTA
    >
      {cartData.map((provider, index) => (
        <TouchableOpacity
          key={index}
          style={tw`
            bg-white p-4 mb-4 rounded-2xl
            shadow-sm border border-green-100
            active:bg-green-50
          `}
          onPress={() => navigation.navigate("ProviderItems", { provider })}
        >
          <View style={tw`flex-row items-center`}>
            <View style={tw`bg-green-100 p-3 rounded-xl mr-4`}>
              <Text style={tw`text-green-600 text-xl`}>🧑‍🌾</Text>
            </View>

            <View style={tw`flex-1`}>
              <Text style={tw`text-lg font-semibold text-gray-800`}>
                {provider.provider_name}
              </Text>
              <View style={tw`flex-row items-center mt-1`}>
                <Text style={tw`text-sm text-gray-500 mr-1`}>📍</Text>
                <Text style={tw`text-sm text-gray-600`}>
                  {provider.provider_address}
                </Text>
              </View>
            </View>

            <View style={tw`flex-row items-center`}>
              <Text style={tw`text-green-600 font-semibold mr-1`}>
                {provider.items?.length || 0}
              </Text>
              <Text style={tw`text-gray-400 text-base`}>→</Text>
            </View>
          </View>
        </TouchableOpacity>
      ))}
    </ScrollView>
  </View>
);

}
