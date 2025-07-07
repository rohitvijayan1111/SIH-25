import React from "react";
import {
  View,
  Text,
  Image,
  TouchableOpacity,
  ScrollView,
  Alert,
} from "react-native";
import tw from "tailwind-react-native-classnames";

export default function ProviderItemsScreen({ route }) {
  const { provider } = route.params || {};

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
    <ScrollView style={tw`p-4`}>
      <Text style={tw`text-xl font-bold mb-2`}>{provider.provider_name}</Text>
      <Text style={tw`text-sm text-gray-500 mb-4`}>
        {provider.provider_address}
      </Text>

      {(provider.items || []).map((item, index) => (
        <View key={index} style={tw`bg-white p-3 mb-3 rounded border`}>
          <View style={tw`flex-row`}>
            <Image
              source={{
                uri: item.image_url || "https://via.placeholder.com/60",
              }}
              style={tw`w-16 h-16 rounded mr-3`}
            />
            <View style={tw`flex-1`}>
              <Text style={tw`font-semibold`}>{item.item_name}</Text>
              <Text style={tw`text-sm text-gray-500`}>
                Quantity: {item.quantity}
              </Text>
              <Text style={tw`text-sm text-gray-500`}>
                Unit Price: ₹{item.unit_price}
              </Text>
              <Text style={tw`text-green-700 font-bold mt-1`}>
                ₹{item.total_price}
              </Text>
            </View>
          </View>
        </View>
      ))}

      <View style={tw`bg-gray-100 p-3 rounded`}>
        <Text style={tw`font-semibold`}>
          Total Amount: ₹{totalMRP + 10}
        </Text>
        <Text style={tw`text-xs text-gray-500`}>
          Includes ₹10 shipping
        </Text>
      </View>

      <TouchableOpacity
        style={tw`bg-green-600 py-3 mt-4 rounded items-center`}
        onPress={() => Alert.alert("✅ Order Placed", "Thank you for ordering!")}
      >
        <Text style={tw`text-white font-bold`}>Place Order</Text>
      </TouchableOpacity>
    </ScrollView>
  );
}
