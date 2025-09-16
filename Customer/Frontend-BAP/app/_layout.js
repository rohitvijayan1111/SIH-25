import { View, Text } from 'react-native';
import { Stack } from 'expo-router';
import React from 'react';
import '../global.css';

const _layout = () => {
  return (
    <Stack screenOptions={{ headerShown: false }}>
      <Stack.Screen name='index' options={{ title: 'Home' }} />
    </Stack>
  );
};

export default _layout;
