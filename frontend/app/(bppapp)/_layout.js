import { Tabs } from "expo-router";
import SearchBar from "../../components/SearchBar";
import { View, Image, Text } from "react-native";
import { icons } from "@/constants/icons";
import { images } from "@/constants/images";

function TabIcon({ focused, icon, title }) {
  if (focused) {
    return (
      // <ImageBackground
      //   source={images.highlight}
      //   className="flex flex-row w-full flex-1 min-w-[112px] min-h-16 mt-4 justify-center items-center rounded-full overflow-hidden"
      // >
      <View>
        <Image source={icon} tintColor="#151312" className="size-5" />
        <Text className="font-semibold ml-2">{title}</Text>
      </View>
      // </ImageBackground>
    );
  }

  return (
    <View className="size-full justify-center items-center mt-4 rounded-full">
      <Image source={icon} tintColor="#A8B5DB" className="size-5" />
    </View>
  );
}

const bapappLayout = () => {
  return (
    <View className="flex-1 bg-white">
      <Tabs ScreenOptions={{ tabBarShowLabel: false }}>
        <Tabs.Screen
          name="Login"
          options={{
            title: "Login",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon focused={focused} icon={icons.home} title="Login" />
            ),
          }}
        />

        <Tabs.Screen
          name="browse"
          options={{
            title: "Browse",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon focused={focused} icon={icons.home} title="Browse" />
            ),
          }}
        />
        <Tabs.Screen
          name="orders"
          options={{
            title: "Orders",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon focused={focused} icon={icons.home} title="Orders" />
            ),
          }}
        />
        <Tabs.Screen
          name="favourites"
          options={{
            title: "Favourites",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon focused={focused} icon={icons.home} title="Favourites" />
            ),
          }}
        />
        <Tabs.Screen
          name="notifications"
          options={{
            title: "Notifications",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon
                focused={focused}
                icon={icons.home}
                title="Notifications"
              />
            ),
          }}
        />
        <Tabs.Screen
          name="account"
          options={{
            title: "Account",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon focused={focused} icon={icons.home} title="Account" />
            ),
            tabBarLabel: ({ focused }) => (
              <Text className="font-semibold ml-2">Account</Text>
            ),
          }}
        />
      </Tabs>
    </View>
  );
};

export default bapappLayout;
