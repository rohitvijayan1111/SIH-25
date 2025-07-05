import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { View, Text, TouchableOpacity } from 'react-native';
import "./global.css";
import ProductDetailsScreen from './screens/ProductDetailsScreen';

const Stack = createNativeStackNavigator();

// ✅ Dummy Home Screen with a button
function HomeScreen({ navigation }) {
  return (
    <View className="flex-1 items-center justify-center bg-white">
      <Text className="text-lg font-bold mb-4">Welcome to the Shop</Text>
      <TouchableOpacity
        className="bg-green-600 px-4 py-2 rounded"
        onPress={() =>
          navigation.navigate('ProductDetails', {
            item_id: '10ffc029-cbc4-4778-8b6b-06eb0bffad2f'
          })
        }
      >
        <Text className="text-white font-semibold">View Product</Text>
      </TouchableOpacity>
    </View>
  );
}

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen
          name="ProductDetails"
          component={ProductDetailsScreen}
          options={{ title: 'Product Details' }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
