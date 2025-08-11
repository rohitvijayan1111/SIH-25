import React, { useState } from 'react';
import { View, Text, TouchableOpacity, Button, Alert } from 'react-native';
import tw from 'tailwind-react-native-classnames';

export default function PaymentScreen({ route, navigation }) {
  const { order } = route.params;
  const [paymentType, setPaymentType] = useState('COD');
  const [loading, setLoading] = useState(false);

  const handlePayment = async () => {
    if (loading) return;
    setLoading(true);

    try {
      if (paymentType === 'COD') {
        await confirmOrder('COD');
      } else {
        // TODO: Replace this with real payment gateway integration
        const paymentSuccess = true; 
        if (paymentSuccess) {
          await confirmOrder('ONLINE');
        } else {
          Alert.alert('Payment Failed', 'Please try again.');
        }
      }
    } catch (err) {
      console.error(err);
      Alert.alert('Error', 'Something went wrong while confirming order.');
    } finally {
      setLoading(false);
    }
  };

  const confirmOrder = async (type) => {
    try {
      console.log('Calling BAP /confirm with type:', type);

      // Replace this with your backend's confirm API URL
      const response = await fetch('https://your-bap-domain.com/confirm', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          context: {
            domain: 'agri.bpp',
            action: 'confirm',
            version: '1.2.0',
            transaction_id: order.transaction_id,
            message_id: order.message_id || `msg-${Date.now()}`,
            timestamp: new Date().toISOString(),
          },
          message: {
            order: {
              ...order,
              payment: {
                ...order.payment,
                type,
                status: type === 'COD' ? 'NOT_PAID' : 'PAID',
              },
            },
          },
        }),
      });

      if (!response.ok) {
        throw new Error(`Server error: ${response.status}`);
      }

      const data = await response.json();

      // Navigate to confirmation screen with updated order
      navigation.navigate('ConfirmOrderScreen', {
        order: { ...order, transaction_type: type, confirmationData: data },
      });
    } catch (err) {
      console.error(err);
      Alert.alert('Error', 'Unable to confirm order.');
    }
  };

  return (
  <View style={tw`flex-1 bg-green-50 p-5`}>
    
    {/* Title */}
    <Text style={tw`text-2xl font-bold text-green-800 mb-5`}>
      💳 Choose Payment Method
    </Text>

    {/* COD Option */}
    <TouchableOpacity
      activeOpacity={0.8}
      onPress={() => setPaymentType('COD')}
      style={[
        tw`flex-row items-center p-4 rounded-2xl mb-4 border`,
        paymentType === 'COD'
          ? tw`bg-green-100 border-green-500 shadow-md`
          : tw`bg-white border-gray-200 shadow-sm`
      ]}
    >
      <Text style={tw`text-lg font-medium text-gray-800 flex-1`}>
        🧺 Cash on Delivery (COD)
      </Text>
      {paymentType === 'COD' && (
        <Text style={tw`text-green-600 font-bold`}>✓</Text>
      )}
    </TouchableOpacity>

    {/* Online Payment Option */}
    <TouchableOpacity
      activeOpacity={0.8}
      onPress={() => setPaymentType('ONLINE')}
      style={[
        tw`flex-row items-center p-4 rounded-2xl mb-4 border`,
        paymentType === 'ONLINE'
          ? tw`bg-green-100 border-green-500 shadow-md`
          : tw`bg-white border-gray-200 shadow-sm`
      ]}
    >
      <Text style={tw`text-lg font-medium text-gray-800 flex-1`}>
        🌱 Online Payment
      </Text>
      {paymentType === 'ONLINE' && (
        <Text style={tw`text-green-600 font-bold`}>✓</Text>
      )}
    </TouchableOpacity>

    {/* Proceed Button */}
    <TouchableOpacity
      activeOpacity={0.9}
      onPress={handlePayment}
      disabled={loading}
      style={[
        tw`mt-6 p-4 rounded-full`,
        loading
          ? tw`bg-green-300`
          : tw`bg-green-600`
      ]}
    >
      <Text style={tw`text-center text-white text-lg font-semibold`}>
        {loading ? 'Processing...' : 'Proceed'}
      </Text>
    </TouchableOpacity>
    
  </View>
);

}
