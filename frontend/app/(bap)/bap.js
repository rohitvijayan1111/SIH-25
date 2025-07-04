import { View, Text, Image, TouchableOpacity } from "react-native";
import React from "react";
import { useRouter } from "expo-router";

const bap = () => {
  const router = useRouter();
  return (
    <View>
      <Text className="text-2xl font-bold text-center">
        Welcome to FarmNFresh
      </Text>
      {/* <Image
        source={require("../../assets/images/bap.png")}
        style={{ width: 100, height: 100 }}
      /> */}
      <TouchableOpacity
        className="bg-green-500 p-2 rounded-md mb-2 mx-3"
        onPress={() => router.push("(bapapp)/browse")}
      >
        <Text className="text-white text-center">Get Started</Text>
      </TouchableOpacity>
    </View>
  );
};

export default bap;
