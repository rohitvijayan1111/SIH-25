import { View, Text, FlatList } from "react-native";
import React, { useState } from "react";
import { SafeAreaView } from "react-native";
import SearchBar from "../../components/SearchBar";
import FeaturedCard from "../../components/FeaturedCard";
import { images } from "@/constants/images";
const browse = () => {
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
      image: { uri: images.applefeatured },
      category: "Fruits",
    },
  ];
  const [featured, setfeatured] = useState(products);
  return (
    <SafeAreaView>
      <View>
        <SearchBar />
      </View>
      <View>
        <Text className="font-bold text-lg">Featured</Text>
        <FlatList
          data={featured}
          renderItem={({ item }) => (
            <FeaturedCard
              title={item.name}
              image={item.image}
              price={item.price}
            />
          )}
          keyExtractor={(item) => item.id}
          horizontal
          showsHorizontalScrollIndicator={false}
        />
      </View>
    </SafeAreaView>
  );
};

export default browse;
