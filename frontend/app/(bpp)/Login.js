import { View, Text, Image, TouchableOpacity } from "react-native";
import { Link, useRouter } from "expo-router";
import bpplog1o from "@/assets/images/bpplog1.png";

const Login = () => {
  const router = useRouter();
  return (
    <View>
      <View>
        <Image source={bpplog1o} resizeMode="cover" />
      </View>
      <View className="m-4 p-4">
        <Text>Welcome</Text>
        <View>
          <TouchableOpacity onPress={() => router.push("/(bppapp)/browse")}>
            <Text>Continue with Google</Text>
          </TouchableOpacity>

          <Text>Already have an account?</Text>
          <TouchableOpacity onPress={() => router.push("/(bpp)/Signup")}>
            <Text>Register</Text>
          </TouchableOpacity>
        </View>
      </View>
    </View>
  );
};

export default Login;
