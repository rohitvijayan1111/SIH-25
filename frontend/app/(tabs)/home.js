import { View, Text, TouchableOpacity } from "react-native";
import React from "react";
import { useRouter } from "expo-router";
const home = () => {
  const router = useRouter();
  return (
    <View className="flex-1 items-center justify-center bg-white">
      <Text className="text-lg font-bold mb-4">Welcome to the Shop</Text>
      <TouchableOpacity
        className="bg-green-600 px-4 py-2 rounded"
        onPress={() =>
          router.push("/screens/ProductDetailsScreen", {
            item_id: "01f2f512-ad91-41d2-91c1-57a26ab3b14d",
          })
        }
      >
        <Text className="text-white font-semibold">View Product</Text>
      </TouchableOpacity>
    </View>
  );
};

export default home;
