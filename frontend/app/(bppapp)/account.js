import { View, Text, Image, TouchableOpacity } from "react-native";
import React from "react";
import { icons } from "@/constants/icons";
import { images } from "@/constants/images";
const account = () => {
  return (
    <View>
      <View className="flex-row items-center justify-between p-4 bg-white">
        <View className="">
          <Image
            source={images.farmerprofilepic}
            resizeMode="cover"
            className=""
          />
        </View>
      </View>

      <View className="flex-1 space-between p-4">
        <Text>Account</Text>
        <Image source={icons.arrow} />
      </View>
    </View>
  );
};

export default account;
