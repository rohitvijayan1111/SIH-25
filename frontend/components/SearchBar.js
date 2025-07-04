import { View, Text, TextInput, Image } from "react-native";
import icons from "@/constants/icons";
import search from "@/assets/icons/search.png";
const SearchBar = () => {
  return (
    <View>
      <Image source={search} resizeMode="contain" />
      {/* <TextInput
        placeholder="Search"
        className="border-2 border-gray-300 rounded-md p-2"
      /> */}
    </View>
  );
};

export default SearchBar;
