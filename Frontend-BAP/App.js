import React from 'react';
import { View, Text, TouchableOpacity } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import tw from 'tailwind-react-native-classnames';
import HomePage from './screens/HomePage'; // Make sure path is correct
import ProductDetailsScreen from './screens/ProductDetails'; // adjust path if needed
import ViewCartScreen from './screens/ViewCartScreen';
import ProviderItemsScreen from './screens/ProviderItemsScreen';
import './global.css';
import PaymentDetails from './screens/PaymentDetails';
const Stack = createNativeStackNavigator();
const CartStack = createNativeStackNavigator();
import ProcurementDetails from './screens/ProcurementDetails';
import CompletedProcurementDetails from './screens/CompletedProcurementDetails';
import Toast, { BaseToast, ErrorToast } from 'react-native-toast-message';
import VerifyProductsScreen from './screens/VerifyProductsScreen';

import ProcurementsScreen from './screens/ProcurementsScreen';
import CreateProcurementScreen from './screens/CreateProcurementScreen';
const WelcomeScreen = ({ navigation }) => {
  return (
    <View style={tw`flex-1 justify-center items-center bg-white`}>
      <Text style={tw`text-2xl font-bold mb-6`}>
        Welcome to the Shopping App
      </Text>
      <TouchableOpacity
        onPress={() => navigation.navigate('Home')}
        style={tw`bg-green-600 px-6 py-3 rounded-lg`}
      >
        <Text style={tw`text-white text-lg`}>Go to Home Page</Text>
      </TouchableOpacity>
      <TouchableOpacity
        onPress={() => navigation.navigate('Cart')} // 👈 this navigates to ViewCart
        style={tw`bg-blue-600 px-6 py-3 rounded-lg`}
      >
        <Text style={tw`text-white text-lg`}>View My Cart</Text>
      </TouchableOpacity>
      <TouchableOpacity
        onPress={() => navigation.navigate('Procurements')} // 👈 this navigates to ViewCart
        style={tw`bg-blue-600 px-6 py-3 rounded-lg`}
      >
        <Text style={tw`text-white text-lg`}>Procurements</Text>
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

const toastConfig = {
  success: (props) => (
    <BaseToast
      {...props}
      style={{
        borderLeftColor: 'transparent',
        backgroundColor: '#f0f9f0',
      }}
      text1Style={{ fontSize: 15, fontWeight: '600' }}
      text2Style={{ fontSize: 13 }}
      renderLeadingIcon={() => (
        <View
          style={{
            height: '100%',
            justifyContent: 'center',
            alignItems: 'center',
            marginRight: 10,
            marginLeft: 10,
          }}
        >
          <Text style={{ fontSize: 30 }}>✅</Text>
        </View>
      )}
    />
  ),

  error: (props) => (
    <ErrorToast
      {...props}
      style={{
        borderLeftColor: 'transparent',
        backgroundColor: '#fdf2f2',
      }}
      text1Style={{ fontSize: 15, fontWeight: '600', color: '#b91c1c' }}
      text2Style={{ fontSize: 13, color: '#dc2626' }}
      renderLeadingIcon={() => (
        // <Text style={{ fontSize: 20, marginRight: 10 }}></Text>
        <View
          style={{
            height: '100%',
            justifyContent: 'center',
            alignItems: 'center',
            marginRight: 10,
            marginLeft: 10,
          }}
        >
          <Text style={{ fontSize: 30 }}>❌</Text>
        </View>
      )}
    />
  ),
};
export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName='Welcome'>
        <Stack.Screen
          name='Welcome'
          component={WelcomeScreen}
          options={{ headerShown: false }}
        />
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
      </Stack.Navigator>

      <Toast style={{ zIndex: 1000 }} config={toastConfig} />
    </NavigationContainer>
  );
}
