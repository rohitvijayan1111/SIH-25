import { Stack } from "expo-router";
const RootLayout = () => {
  return (
    <Stack>
      <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
      <Stack.Screen name="product/01f2f512-ad91-41d2-91c1-57a26ab3b14d" />
    </Stack>
  );
};

export default RootLayout;
