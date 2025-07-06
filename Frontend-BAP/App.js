import React from 'react';
import { View, Text, TouchableOpacity } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import tw from 'tailwind-react-native-classnames';
import HomePage from './screens/HomePage'; // Make sure path is correct

const Stack = createNativeStackNavigator();

const WelcomeScreen = ({ navigation }) => {
  return (
    <View style={tw`flex-1 justify-center items-center bg-white`}>
      <Text style={tw`text-2xl font-bold mb-6`}>Welcome to the Shopping App</Text>
      <TouchableOpacity
        onPress={() => navigation.navigate('Home')}
        style={tw`bg-green-600 px-6 py-3 rounded-lg`}
      >
        <Text style={tw`text-white text-lg`}>Go to Home Page</Text>
      </TouchableOpacity>
    </View>
  );
};

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Welcome">
        <Stack.Screen name="Welcome" component={WelcomeScreen} options={{ headerShown: false }} />
        <Stack.Screen name="Home" component={HomePage} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
