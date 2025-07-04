import { View, Text } from "react-native";
import React from "react";
import { Stack } from "expo-router";
const onboardinglayout = () => {
  return (
    <Stack>
      <Stack.Screen name="Beckn" />
      {/* <Stack.Screen name="bap" />
      <Stack.Screen name="bpp" /> */}
    </Stack>
  );
};

export default onboardinglayout;
