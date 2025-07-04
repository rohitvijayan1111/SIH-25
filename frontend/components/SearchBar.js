import { View, Text, TextInput, Image } from "react-native";
import icons from "@/constants/icons";
import search from "@/assets/icons/search.png";
const SearchBar = () => {
  return (
    <View className="flex-row items-center border-2 border-gray-300 rounded-md p-2">
      <Image source={search} resizeMode="contain" className="w-5 h-5 mr-2" />
    </View>
  );
};

export default SearchBar;
