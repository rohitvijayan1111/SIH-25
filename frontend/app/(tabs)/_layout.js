import { Tabs } from "expo-router";

const tabslayout = () => {
  return (
    <Tabs>
      <Tabs.Screen name="home" />
      <Tabs.Screen name="categories" />
      <Tabs.Screen name="favourites" />
      <Tabs.Screen name="cart" />
    </Tabs>
  );
};

export default tabslayout;
