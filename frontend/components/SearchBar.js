import { View, Text, TextInput, Image } from "react-native";
import icons from "@/constants/icons";
import search from "@/assets/icons/search.png";
const SearchBar = () => {
  return (
    <View className="flex-row items-center border-2 bg-white border-gray-300 rounded-lg p-2 m-2">
      <Image source={search} resizeMode="contain" className="w-5 h-5 m-1" />
      <TextInput
        placeholder="Search"
        className="flex-1"
        placeholderTextColor="#676767"
      />
    </View>
  );
};

export default SearchBar;
