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
        <Image source={icon} tintColor="#93C22F" className="size-5" />
        {/* <Text className="font-semibold ml-2">{title}</Text> */}
      </View>
      // </ImageBackground>
    );
  }

  return (
    <View className="">
      {/* <Image source={icon} tintColor="#A8B5DB" className="size-5" /> */}
      <Image source={icon} tintColor="#DADADA" className="size-5" />
    </View>
  );
}

const bapappLayout = () => {
  return (
    <View className="flex-1 bg-white">
      <Tabs
        // initialRouteName="shop"
        ScreenOptions={{
          tabBarShowLabel: false,
          tabBarActiveTintColor: "#93C22F",
          tabBarInactiveTintColor: "#DADADA",
        }}
      >
        <Tabs.Screen
          name="home"
          options={{
            title: "home",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon focused={focused} icon={icons.home} title="home" />
            ),
          }}
        />
        <Tabs.Screen
          name="shop"
          options={{
            title: "Shop",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon focused={focused} icon={icons.orders} title="Shop" />
            ),
          }}
        />
        <Tabs.Screen
          name="mynetwork"
          options={{
            title: "My Network",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon
                focused={focused}
                icon={icons.network}
                title="My Network"
              />
            ),
          }}
        />

        <Tabs.Screen
          name="mytasks"
          options={{
            title: "My Tasks",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon focused={focused} icon={icons.task} title="My Tasks" />
            ),
          }}
        />

        {/* <Tabs.Screen
          name="myaccount"
          options={{
            title: "Account",
            headerShown: false,
            tabBarIcon: ({ focused }) => (
              <TabIcon focused={focused} icon={icons.profile} title="Account" />
            ),
            // tabBarLabel: ({ focused }) => (

            // ),
          }}
        /> */}
      </Tabs>
    </View>
  );
};

export default bapappLayout;
