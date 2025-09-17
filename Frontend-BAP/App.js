import React from 'react';
import { View, Text, TouchableOpacity } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import tw from 'tailwind-react-native-classnames';
import HomePage from './screens/HomePage'; // Make sure path is correct
import VoicePage from './screens/VoicePage';
import ProductDetailsScreen from './screens/ProductDetails'; // adjust path if needed
import ViewCartScreen from './screens/ViewCartScreen';
import ProviderItemsScreen from './screens/ProviderItemsScreen';
import PaymentScreen from './screens/PaymentScreen';
// import ConfirmOrderScreen from './ConfirmOrderScreen';
import './global.css';
import PaymentDetails from './screens/PaymentDetails';
const Stack = createNativeStackNavigator();
const CartStack = createNativeStackNavigator();
import ProcurementDetails from './screens/ProcurementDetails';
import CompletedProcurementDetails from './screens/CompletedProcurementDetails';
import VerifyProductsScreen from './screens/VerifyProductsScreen';
import PaymentSuccessPage from './screens/PaymentCompletionScreen';


import ProcurementsScreen from './screens/ProcurementsScreen';
import CreateProcurementScreen from './screens/CreateProcurementScreen';
const WelcomeScreen = ({ navigation }) => {
 return (
    <View style={tw`flex-1 justify-center items-center bg-gray-50 p-6`}>
      <Text style={tw`text-3xl font-extrabold mb-10 text-gray-800`}>
        Welcome to the Shopping App
      </Text>

      <TouchableOpacity
        onPress={() => navigation.navigate('Voice')}
        style={tw`mb-4 w-full bg-green-600 py-4 rounded-xl items-center shadow-md`}
      >
        <Text style={tw`text-white text-lg font-semibold`}>Add Product using voice feature</Text>
      </TouchableOpacity>

      {/* Home Button */}
      <TouchableOpacity
        onPress={() => navigation.navigate('Home')}
        style={tw`mb-4 w-full bg-green-600 py-4 rounded-xl items-center shadow-md`}
      >
        <Text style={tw`text-white text-lg font-semibold`}>Go to Home Page</Text>
      </TouchableOpacity>

      {/* Cart Button */}
      <TouchableOpacity
        onPress={() => navigation.navigate('Cart')}
        style={tw`mb-4 w-full bg-blue-600 py-4 rounded-xl items-center shadow-md`}
      >
        <Text style={tw`text-white text-lg font-semibold`}>View My Cart</Text>
      </TouchableOpacity>

      {/* Procurements Button */}
      <TouchableOpacity
        onPress={() => navigation.navigate('Procurements')}
        style={tw`w-full bg-indigo-600 py-4 rounded-xl items-center shadow-md`}
      >
        <Text style={tw`text-white text-lg font-semibold`}>Procurements</Text>
      </TouchableOpacity>
    </View>
  );
};

function CartStackScreen() {
  return (
    <CartStack.Navigator>
      <CartStack.Screen name='ViewCart' component={ViewCartScreen} />
      <CartStack.Screen name='ProviderItems' component={ProviderItemsScreen} />
    </CartStack.Navigator>
  );
}

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName='Welcome'>
        <Stack.Screen
          name='Welcome'
          component={WelcomeScreen}
          options={{ headerShown: false }}
        />
        <Stack.Screen name='Voice' component={VoicePage} />
        <Stack.Screen name='Home' component={HomePage} />
        <Stack.Screen
          name='ProductDetails'
          component={ProductDetailsScreen}
          options={{ title: 'Product Details' }}
        />
        <Stack.Screen
          name='Cart'
          component={CartStackScreen}
          options={{ headerShown: false }} // hides nested headers
        />
        <Stack.Screen name="PaymentScreen" component={PaymentScreen} />
        <Stack.Screen
          name='Procurements'
          component={ProcurementsScreen}
          options={{ headerShown: false }} // hides nested headers
        />
        <Stack.Screen
          name='PaymentDetails'
          component={PaymentDetails}
          options={{ headerShown: false }} // hides nested headers
        />
        <Stack.Screen
          name='ProcurementDetails'
          component={ProcurementDetails}
          options={{ headerShown: false }} // hides nested headers
        />
        <Stack.Screen
          name='CompletedProcurementDetails'
          component={CompletedProcurementDetails}
          options={{ headerShown: false }} // hides nested headers
        />
        <Stack.Screen
          name='CreateProcurement'
          component={CreateProcurementScreen}
          options={{ headerShown: false }} // hides nested headers
        />
          <Stack.Screen
    name='VerifyProductsScreen'
    component={VerifyProductsScreen}
    options={{ title: 'Verify Products' }}
  /> 
  <Stack.Screen
  name='PaymentSuccess'
  component={PaymentSuccessPage}
  options={{ headerShown: false }} // hides the top header
/>

      </Stack.Navigator>
    </NavigationContainer>
  );
}
