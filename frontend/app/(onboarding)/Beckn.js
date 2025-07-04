import { View, Text, TouchableOpacity } from "react-native";
import React, { use } from "react";
import { useRouter } from "expo-router";

const Beckn = () => {
  const router = useRouter();
  return (
    <View className="flex-1 items-center justify-center">
      <TouchableOpacity
        className="bg-[-6CC51D] px-4 py-2 rounded-lg mb-4"
        onPress={() => router.push("/bap")}
      >
        <Text>Go to BAP</Text>
      </TouchableOpacity>
      <TouchableOpacity
        className="bg-[-6CC51D] px-4 py-2 rounded-lg mb-4"
        onPress={() => router.push("/bpp")}
      >
        <Text>Go to BPP</Text>
      </TouchableOpacity>
    </View>
  );
};

export default Beckn;
