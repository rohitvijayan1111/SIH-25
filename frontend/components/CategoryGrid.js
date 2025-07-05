import { View, Text, FlatList, TouchableOpacity, Image } from "react-native";
import { images } from "@/constants/images";

const categories = [
  { id: 1, name: "Seeds", icon: images.seeds },
  { id: 2, name: "Micro Nutrients", icon: images.micronutrients },
  { id: 3, name: "Fertilizer", icon: images.fertilizer },
  { id: 4, name: "Fungicide", icon: images.fungicide },
  { id: 5, name: "Growth promoter", icon: images.growthpromoters },
  { id: 6, name: "Growth Regulators", icon: images.growthregulators },
  { id: 7, name: "Herbicide", icon: images.herbicide },
  { id: 8, name: "Land Lease & Sale", icon: images.landlease },
];

const CategoryGrid = () => {
  return (
    <FlatList
      data={categories}
      numColumns={4}
      keyExtractor={(item) => item.id}
      columnWrapperStyle={{ justifyContent: "space-between" }}
      contentContainerStyle={{ paddingHorizontal: 12, paddingTop: 12 }}
      renderItem={({ item }) => (
        <TouchableOpacity className="flex-1 items-center p-3 m-1 bg-white rounded-xl shadow-md">
          <Image
            source={item.icon}
            className="w-10 h-10"
            resizeMode="contain"
          />
          <Text className="text-center text-xs mt-2">{item.name}</Text>
        </TouchableOpacity>
      )}
    />
  );
};

export default CategoryGrid;
