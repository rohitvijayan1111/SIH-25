// HeaderComponent.js
import { View, Text, Image } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import { Bell } from "lucide-react-native";
import SearchBar from "./SearchBar";

export default function Headert() {
  return (
    <LinearGradient
      colors={["#A2E27E", "#ffffff"]}
      className="px-2 pt-10 pb-4 rounded-b-4xl shadow-md"
    >
      <View className="flex-row justify-between items-center mb-2">
        <Text className="text-lg font-extrabold text-green-800">
          FarmNFresh
        </Text>
        <View className="flex-row items-center space-x-2">
          <View className="bg-white px-2 py-1 rounded-full">
            <Text className="text-[#2B9846] font-semibold text-sm">₹20000</Text>
          </View>
          <Bell size={20} color="green" />
        </View>
      </View>
      <SearchBar />
    </LinearGradient>
  );
}
