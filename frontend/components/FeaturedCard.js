import { View, Text, Image } from "react-native";
import React from "react";

const FeaturedCard = ({ title, image, price }) => {
  return (
    <View className="m-2 p-2 bg-white w-36 rounded-lg shadow-md">
      <Image source={image.uri} className="w-24 h-24" resizeMode="contain" />
      <Text>{title}</Text>
      <Text>{price}</Text>
    </View>
  );
};

export default FeaturedCard;
