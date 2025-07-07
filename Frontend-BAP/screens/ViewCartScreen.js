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
        "http://localhost:5000/cart/view/d7c6b53e-9472-4c23-bc76-e8c29718383e"
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
      <View style={tw`flex-1 justify-center items-center p-6`}>
        <Text style={tw`text-lg text-gray-600`}>
          🛒 Your cart is empty.
        </Text>
      </View>
    );
  }

  return (
    <ScrollView style={tw`p-4`}>
      <Text style={tw`text-xl font-bold mb-4`}>My Cart</Text>

      {cartData.map((provider, index) => (
        <TouchableOpacity
          key={index}
          style={tw`bg-white p-4 mb-3 border rounded`}
          onPress={() =>
            navigation.navigate("ProviderItems", { provider })
          }
        >
          <Text style={tw`text-lg font-semibold text-green-700`}>
            🧑‍🌾 {provider.provider_name}
          </Text>
          <Text style={tw`text-sm text-gray-600`}>
            📍 {provider.provider_address}
          </Text>
          <Text style={tw`text-sm text-gray-500 mt-1`}>
            Items: {provider.items?.length || 0}
          </Text>
        </TouchableOpacity>
      ))}
    </ScrollView>
  );
}
