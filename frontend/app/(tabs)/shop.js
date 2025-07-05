import { View, Text, FlatList, TouchableOpacity } from "react-native";
import React, { useState } from "react";
import { SafeAreaView } from "react-native";
import SearchBar from "../../components/SearchBar";
import FeaturedCard from "../../components/FeaturedCard";
import { images } from "@/constants/images";
import Header from "../../components/Header";
import CategoryGrid from "../../components/CategoryGrid";
const shop = () => {
  const categories = [
    { id: 1, name: "Seeds", icon: images.seeds },
    { id: 2, name: "Micro Nutrients", icon: images.micronutrients },
    { id: 3, name: "Fertilizer", icon: images.fertilizer },
    { id: 4, name: "Fungicide", icon: images.fungicide },
    { id: 5, name: "Growth promoter", icon: images.growthpromoters },
    { id: 6, name: "Growth Regulators", icon: images.growthregulators },
    { id: 7, name: "Herbicide", icon: images.herbicides },
    { id: 8, name: "Land Lease & Sale", icon: images.landlease },
  ];
  const products = [
    {
      id: "1",
      name: "Broccoli",
      price: "$1.99",
      image: "https://via.placeholder.com/150",
      category: "Vegetables",
    },
    {
      id: "2",
      name: "Fresh Carrots",
      price: "$2.49",
      image: "https://via.placeholder.com/150",
      category: "Vegetables",
    },
    {
      id: "3",
      name: "Tomatoes",
      price: "$3.99",
      image: "https://via.placeholder.com/150",
      category: "Vegetables",
    },
    {
      id: "4",
      name: "Bananas",
      price: "$1.89",
      image: "https://via.placeholder.com/150",
      category: "Fruits",
    },
    {
      id: "5",
      name: "Apples",
      price: "$2.89",
      image: "{ uri: images.applefeatured }",
      category: "Fruits",
    },
  ];
  const [featured, setfeatured] = useState(products);
  return (
    <SafeAreaView>
      <View className="bg-white">
        <View>
          <Header />
        </View>
        <CategoryGrid />
        <View className="bg-green-100 p-4 rounded-xl mb-4">
          <Text className="text-lg font-bold text-green-800 mb-2">
            Discount
          </Text>
          <Text className="text-xs text-green-700">25% Pesticide Product</Text>
          <TouchableOpacity className="mt-2 px-3 py-1 bg-green-700 rounded-full self-start">
            <Text className="text-white text-xs">See Detail</Text>
          </TouchableOpacity>
        </View>
        <View className="">
          <Text className="font-bold text-lg">Featured</Text>
          <FlatList
            data={featured}
            renderItem={({ item }) => (
              <FeaturedCard
                title={item.name}
                image={item.image}
                price={item.price}
                category={item.category}
              />
            )}
            keyExtractor={(item) => item.id}
            horizontal
            showsHorizontalScrollIndicator={false}
          />
        </View>
      </View>
    </SafeAreaView>
  );
};

export default shop;
