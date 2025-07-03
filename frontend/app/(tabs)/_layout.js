import { Tabs } from "expo-router";

const tabsLayout = () => {
  return (
    <Tabs>
      <Tabs.Screen name="home" />
      <Tabs.Screen name="profile" />
    </Tabs>
  );
};

export default tabsLayout;
