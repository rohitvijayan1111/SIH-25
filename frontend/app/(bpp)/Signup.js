import { View, Text, Image, TouchableOpacity, TextInput } from "react-native";
import { Link, useRouter } from "expo-router";
import loginfarmer from "@/assets/images/loginfarmer.png";

export default function Signup() {
  const router = useRouter();
  return (
    <View className="flex-1 bg-[#F4F5F9]">
      <View className="h-3/5">
        <Image
          source={loginfarmer}
          resizeMode="contain"
          className="h-full w-full"
        />
      </View>
      <View className="h-2/5 flex-1 p-6 m-4">
        <Text className="text-lg font-semibold">Create an Account</Text>
        <View>
          <TextInput
            placeholder="Continue with Google"
            className="border w-8/10 p-2 m-4"
          />
          <TextInput placeholder="Email" className="border w-8/10 p-2 m-4" />
          <TouchableOpacity onPress={() => router.push("/(bpp)/Login")}>
            <Text>Already have an account?</Text>
            <Text className="bold">Login</Text>
          </TouchableOpacity>
        </View>
      </View>
    </View>
  );
}
