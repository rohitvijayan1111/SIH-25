import React from 'react';
import { View, Text, Image, ScrollView, TouchableOpacity } from 'react-native';
import tw from 'tailwind-react-native-classnames';

const VerifyProductsScreen = ({ route, navigation }) => {
  const { bpp_response } = route.params;

  if (!bpp_response?.message?.order) {
    return (
      <View style={tw`flex-1 justify-center items-center`}>
        <Text style={tw`text-red-500 text-lg`}>❌ Invalid order data</Text>
      </View>
    );
  }

  const order = bpp_response.message.order;
  const items = order.items || [];
  const provider = order.provider || {};
  const quote = order.quote || {};
  const fulfillment = order.fulfillment || {};
  const payment = order.payment || {};

  return (
    <ScrollView style={tw`bg-gray-100 p-4`}>
      {/* ✅ Provider Info */}
      <View style={tw`mb-4`}>
        <Text style={tw`text-xl font-bold text-green-800`}>{provider.descriptor?.name || "Unknown Provider"}</Text>
        <Text style={tw`text-sm text-gray-700 mt-1`}>{fulfillment.start?.location?.address || "No address"}</Text>
      </View>

      {/* ✅ Fulfillment Info */}
      <View style={tw`bg-white p-4 rounded-lg shadow mb-4`}>
        <Text style={tw`text-base font-semibold mb-1`}>🚚 Fulfillment Type: {fulfillment.type}</Text>
        <Text style={tw`text-sm text-gray-700`}>📍 Pickup: {fulfillment.start?.location?.address}</Text>
        <Text style={tw`text-sm text-gray-700`}>🏁 Delivery: {fulfillment.end?.location?.address}</Text>
        <Text style={tw`text-sm text-gray-700 mt-1`}>
          ⏳ ETA: {fulfillment.estimated_delivery ? new Date(fulfillment.estimated_delivery).toLocaleString() : "N/A"}
        </Text>
      </View>

      {/* ✅ Verified Products */}
      <Text style={tw`text-lg font-bold mb-2`}>🧾 Verified Products</Text>
      {items.map((item, idx) => {
        const subtotal = (parseFloat(item.price?.value || 0) * item.quantity?.count || 1).toFixed(2);
        const unit = item.quantity?.unitized?.measure?.unit || '';
        return (
          <View key={idx} style={tw`bg-white p-4 rounded-lg shadow mb-3`}>
            <View style={tw`flex-row`}>
              <Image
                source={{ uri: item.descriptor?.images?.[0] || "https://via.placeholder.com/60" }}
                style={tw`w-16 h-16 rounded mr-4`}
              />
              <View style={tw`flex-1`}>
                <Text style={tw`font-semibold text-base`}>{item.descriptor?.name}</Text>
                <Text style={tw`text-sm text-gray-600`}>
                  Quantity: {item.quantity?.count} {unit}
                </Text>
                <Text style={tw`text-sm text-gray-600`}>
                  Unit Price: ₹{parseFloat(item.price?.value || 0).toFixed(2)}
                </Text>
                <Text style={tw`text-green-700 font-bold`}>
                  Subtotal: ₹{subtotal}
                </Text>
                <Text style={tw`text-xs text-gray-500`}>
                  Organic: {item.tags?.[0]?.value === 'true' ? '✅' : '❌'}
                </Text>
              </View>
            </View>
          </View>
        );
      })}

      {/* ✅ Price Summary */}
      <View style={tw`bg-white p-4 rounded-lg shadow mb-4`}>
        <Text style={tw`text-lg font-semibold mb-2`}>💵 Price Summary</Text>
        {(quote.breakup || []).map((entry, idx) => (
          <View key={idx} style={tw`flex-row justify-between`}>
            <Text>{entry.title}</Text>
            <Text>₹{parseFloat(entry.price?.value || 0).toFixed(2)}</Text>
          </View>
        ))}
        <View style={tw`border-t border-gray-300 mt-2 pt-2 flex-row justify-between`}>
          <Text style={tw`font-bold`}>Total</Text>
          <Text style={tw`font-bold`}>₹{parseFloat(quote.price?.value || 0).toFixed(2)}</Text>
        </View>
      </View>

      {/* ✅ Payment Info */}
      <View style={tw`bg-white p-4 rounded-lg shadow mb-5`}>
        <Text style={tw`text-base font-semibold`}>💳 Payment Info</Text>
        <Text style={tw`text-sm text-gray-700`}>Mode: {payment.type}</Text>
        <Text style={tw`text-sm text-gray-700`}>Collected By: {payment.collected_by}</Text>
        <Text style={tw`text-sm text-gray-700`}>Status: {payment.status}</Text>
        <Text style={tw`text-sm text-gray-700`}>
          Time To Pay: {payment.ttl?.replace('PT', '').toLowerCase() || 'N/A'}
        </Text>
      </View>

      {/* ✅ Confirm Button */}
      <TouchableOpacity
        style={tw`bg-green-600 p-4 rounded-xl mb-8`}
        onPress={() => navigation.navigate('ConfirmOrderScreen', { order })}
      >
        <Text style={tw`text-white text-center font-bold text-base`}>✅ Confirm & Place Order</Text>
      </TouchableOpacity>
    </ScrollView>
  );
};

export default VerifyProductsScreen;
