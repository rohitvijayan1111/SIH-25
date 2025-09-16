import React from 'react';
import {
  View,
  Text,
  SafeAreaView,
  TouchableOpacity,
  StatusBar,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useNavigation } from '@react-navigation/native';
const PaymentSuccessPage = () => {
    const navigation=useNavigation();
  // Handler for the "View Order Details" button
  const handleViewOrderDetails = () => {
    console.log('View Order Details pressed');
    // Navigate to order details page
  };

  return (
    // Safe area wrapper with status bar
    <SafeAreaView className='flex-1'>
      <StatusBar barStyle='dark-content' backgroundColor='#ffffff' />

      {/* Main container - full screen with light gray background, centered content */}
      <View className='flex-1 bg-gray-50 justify-center items-center px-6'>
        {/* Success card container - white background with shadow and rounded corners */}
        <View className='bg-white rounded-2xl shadow-lg p-8 w-full max-w-sm'>
          {/* Success icon container - green circle with checkmark */}
          <View className='items-center mb-6'>
            <View className='w-16 h-16 bg-[#2B9846] rounded-full justify-center items-center'>
              <Ionicons name='checkmark' size={32} color='#ffffff' />
            </View>
          </View>

          {/* Success message title */}
          <Text className='text-2xl font-semibold text-gray-900 text-center mb-2'>
            Order Successful
          </Text>

          {/* Success message subtitle */}
          <Text className='text-gray-500 text-center mb-8 leading-6'>
            Thank you for your purchase. Your order is being processed.
          </Text>

          {/* Payment details section */}
          <View className='mb-8'>
            {/* Amount paid row */}
            <View className='flex-row justify-between items-center py-3 border-b border-gray-100'>
              <Text className='text-gray-500'>Amount Paid</Text>
              <Text className='font-medium text-gray-900'>₹1679</Text>
            </View>

            {/* Payment method row */}
            <View className='flex-row justify-between items-center py-3 border-b border-gray-100'>
              <Text className='text-gray-500'>Payment Method</Text>
              <Text className='font-medium text-gray-900 flex-shrink'>
                Cash
              </Text>
            </View>

            {/* Date and time row */}
            <View className='flex-row justify-between items-center py-3 border-b border-gray-100'>
              <Text className='text-gray-500'>Date & Time</Text>
              <Text className='font-medium text-gray-900 flex-shrink text-right'>
                September 1, 2025 at 9:45 PM
              </Text>
            </View>
          </View>

          {/* View Order Details button - dark background with white text */}
          <TouchableOpacity
            onPress={() => navigation.navigate('Home')}
            className='w-full bg-[#2B9846] active:bg-gray-900 py-4 px-6 rounded-lg'
            activeOpacity={0.8}
          >
            <Text className='text-white font-semibold text-center'>
              Back to Home
            </Text>
          </TouchableOpacity>
        </View>
      </View>
    </SafeAreaView>
  );
};

export default PaymentSuccessPage;
