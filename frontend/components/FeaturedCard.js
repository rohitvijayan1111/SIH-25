import { View, Text, Image, TouchableOpacity } from "react-native";
import React from "react";

const FeaturedCard = ({ title, image, price, category }) => {
  return (
    <TouchableOpacity className="bg-white rounded-lg m-1 w-40 p-2">
      <Image
        source={image.uri}
        className="w-full h-48 rounded-lg"
        resizeMode="cover"
      />
      <Text className="text-xs text-gray-500">{category}</Text>
      <Text className="text-sm font-bold">{title}</Text>
      <Text>{price}</Text>
    </TouchableOpacity>
  );
};

export default FeaturedCard;
