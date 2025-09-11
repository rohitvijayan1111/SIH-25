import React, { useState,useEffect } from 'react';
import { Platform ,View, Text, Image, ScrollView, TouchableOpacity } from 'react-native';
import tw from 'tailwind-react-native-classnames';
import { SERVER_URL,mobile_url } from '@env';

const VerifyProductsScreen = ({ route, navigation }) => {
  const { bpp_response } = route.params;
   console.log(bpp_response);
  if (!bpp_response?.message?.order) {
    return (
      <View style={tw`flex-1 justify-center items-center`}>
        <Text style={tw`text-red-500 text-lg`}>❌ Invalid order data</Text>
      </View>
    );
  }
  useEffect(() => {
  callBapLogistics();
}, []);
  
  const [selectedDelivery, setSelectedDelivery] = useState(null);
  const [logisticsOptions, setLogisticsOptions] = useState([]);
  const order = bpp_response.message.order;
  // console.log(order);
  const items = order.items || [];
  const provider = order.provider || {};
  const quote = order.quote || {};
  const fulfillment = order.fulfillment || {};
  const payment = order.payment || {};

  const calculateTotalWeight = () => {
  return items.reduce((total, item) => {
    const perUnitWeight = parseFloat(item.quantity?.unitized?.measure?.value || 0); // weight per unit
    const qty = parseInt(item.quantity?.count || 0);
    return total + (perUnitWeight * qty);
  }, 0);
};


  const callBapLogistics = async () => {
  try {
    // const totalWeight = calculateTotalWeight();
    const payload = {
      start: {
        gps: fulfillment.start?.location?.gps || "13.0827,80.2707",
        address: fulfillment.start?.location?.address || "Warehouse, Chennai"
      },
      end: {
        gps: fulfillment.end?.location?.gps || "12.9716,77.5946",
        address: fulfillment.end?.location?.address || "Customer Address, Bangalore"
      },
      weight_kg: 5
    };

    const response = await fetch(`${SERVER_URL}/logistic/search`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload)
    });

    const data = await response.json();
    console.log("✅ Logistics API Response:", data);

    const providers = data?.message?.catalog?.providers || [];
    setLogisticsOptions(providers); // store in state

  } catch (error) {
    console.error("❌ Logistics API Error:", error);
  }
};

  

  return (
  <View style={tw`flex-1 bg-green-50 relative`}>
    <ScrollView
      style={tw`px-4 pt-5`}
      contentContainerStyle={{ paddingBottom: 160 }}
      showsVerticalScrollIndicator={false}
    >
      {/* 🌾 Provider Info */}
      <View style={tw`mb-6 bg-green-100 p-5 rounded-2xl shadow-md border border-green-200`}>
        <Text style={tw`text-2xl font-bold text-green-900`}>
          {provider.descriptor?.name || "Unknown Provider"}
        </Text>
        <Text style={tw`text-sm text-green-800 mt-1`} numberOfLines={2}>
          📍 {fulfillment.start?.location?.address || "No address"}
        </Text>
      </View>

      {/* 🚚 Fulfillment Info */}
      <View style={tw`bg-white p-5 rounded-2xl shadow-sm mb-6 border border-green-100`}>
        <Text style={tw`text-lg font-semibold text-green-700 mb-3`}>
          🚚 Fulfillment Info
        </Text>
        <Text style={tw`text-sm text-gray-700 mb-1`}>Type: {fulfillment.type || 'N/A'}</Text>
        <Text style={tw`text-sm text-gray-700 mb-1`}>📍 Pickup: {fulfillment.start?.location?.address || 'N/A'}</Text>
        <Text style={tw`text-sm text-gray-700 mb-1`}>🏁 Delivery: {fulfillment.end?.location?.address || 'N/A'}</Text>
        <Text style={tw`text-sm text-gray-700`}>
          ⏳ ETA: {fulfillment.estimated_delivery ? new Date(fulfillment.estimated_delivery).toLocaleString() : "N/A"}
        </Text>
      </View>

      {/* 🧾 Verified Products */}
      <Text style={tw`text-xl font-bold text-green-900 mb-4`}>
        🧾 Verified Products
      </Text>
      {items.map((item, idx) => {
        const subtotal = (parseFloat(item.price?.value || 0) * (item.quantity?.count || 1)).toFixed(2);
        const unit = item.quantity?.unitized?.measure?.unit || '';
        const isOrganic = item.tags?.[0]?.value === 'true';
        const imageUrl = item.descriptor?.images?.[0] || "https://via.placeholder.com/60";

        return (
          <View key={idx} style={tw`bg-white p-4 rounded-2xl shadow-sm mb-4 border border-green-100`}>
            <View style={tw`flex-row`}>
              {/* 🖼 Image + Organic Badge */}
              <View style={tw`relative mr-4`}>
                <Image
                  source={{ uri: imageUrl }}
                  style={tw`w-16 h-16 rounded-lg`}
                  resizeMode="cover"
                />
                {isOrganic && (
                  <View style={tw`absolute -top-2 -right-2 bg-green-200 px-2 py-0.5 rounded-full shadow`}>
                    <Text style={tw`text-green-900 text-xs font-semibold`}>Organic</Text>
                  </View>
                )}
              </View>

              {/* 🛒 Product Info */}
              <View style={tw`flex-1`}>
                <Text style={tw`font-semibold text-gray-900 text-sm mb-1`}>
                  {item.descriptor?.name}
                </Text>
                <Text style={tw`text-xs text-gray-700 mb-1`}>
                  Qty: {item.quantity?.count} {unit}
                </Text>
                <Text style={tw`text-xs text-gray-700 mb-1`}>
                  Unit Price: ₹{parseFloat(item.price?.value || 0).toFixed(2)}
                </Text>
                <Text style={tw`text-sm text-green-800 font-semibold mt-1`}>
                  Subtotal: ₹{subtotal}
                </Text>
              </View>
            </View>
          </View>
        );
      })}

      {/* 💰 Price Summary */}
      <View style={tw`bg-white p-5 rounded-2xl shadow-md mb-6 border border-green-100`}>
        <Text style={tw`text-lg font-bold text-green-900 mb-3`}>
          💰 Price Summary
        </Text>
        {(quote.breakup || []).map((entry, idx) => (
          <View key={idx} style={tw`flex-row justify-between mb-1`}>
            <Text style={tw`text-sm text-gray-700`}>{entry.title}</Text>
            <Text style={tw`text-sm text-gray-900`}>
              ₹{parseFloat(entry.price?.value || 0).toFixed(2)}
            </Text>
          </View>
        ))}
        <View style={tw`border-t border-green-200 mt-3 pt-3 flex-row justify-between`}>
          <Text style={tw`text-base font-bold text-gray-800`}>Total</Text>
          <Text style={tw`text-base font-bold text-green-900`}>
            ₹{parseFloat(quote.price?.value || 0).toFixed(2)}
          </Text>
        </View>
      </View>

      {/* 🚚 Delivery Options */}
      {logisticsOptions.length > 0 && (
        <View style={tw`bg-white p-5 rounded-2xl shadow-md mb-6 border border-green-100`}>
          <Text style={tw`text-xl font-bold text-green-900 mb-4`}>
            Delivery Options
          </Text>

          {logisticsOptions.map((provider, idx) => (
            <View key={idx} style={tw`mb-5`}>
              <View style={tw`bg-white rounded-xl shadow-sm border border-green-200 p-4`}>
                <Text style={tw`text-lg font-semibold text-gray-800 mb-2`}>
                  {provider.descriptor?.name}
                </Text>

                {(provider.items || []).map((option, oIdx) => {
                  const isSelected =
                    selectedDelivery?.providerId === provider.id &&
                    selectedDelivery?.itemId === option.id;

                  return (
                    <TouchableOpacity
                      key={oIdx}
                      activeOpacity={0.85}
                      onPress={() =>
                        setSelectedDelivery({
                          providerId: provider.id,
                          providerName: provider.descriptor?.name,
                          itemId: option.id,
                          itemName: option.descriptor?.name,
                          price: option.price?.value,
                          eta: option.time?.duration
                        })
                      }
                      style={tw`mt-3 rounded-xl p-4 shadow-sm border ${
                        isSelected
                          ? "bg-green-100 border-green-500"
                          : "bg-green-50 border-green-200"
                      }`}
                    >
                      <Text style={tw`text-base font-medium text-gray-900`}>
                        {option.descriptor?.name}
                      </Text>

                      <View style={tw`flex-row justify-between mt-2`}>
                        <Text style={tw`text-sm text-gray-700`}>
                          Price: ₹{parseFloat(option.price?.value || 0).toFixed(2)}
                        </Text>
                        <Text style={tw`text-sm text-gray-700`}>
                          ETA: {option.time?.duration?.replace("PT", "").toLowerCase()}
                        </Text>
                      </View>
                    </TouchableOpacity>
                  );
                })}
              </View>
            </View>
          ))}
        </View>
      )}

    </ScrollView>

    {/* ✅ Fixed Bottom CTA */}
    <View
      style={[
        tw`absolute left-0 right-0 bg-green-100 border-t border-green-200 px-4 pt-3`,
        { bottom: Platform.OS === 'ios' ? 28 : 0, paddingBottom: 16, shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 8, elevation: 8 }
      ]}
    >
      <TouchableOpacity
        style={tw`bg-green-700 py-4 rounded-full shadow-lg`}
        onPress={() => {
          if (selectedDelivery !== null) {
            navigation.navigate('PaymentScreen', { order });
          } else {
            console.log('Please select a delivery option before proceeding.');
          }
        }}
        activeOpacity={0.8}
      >
        <Text style={tw`text-white text-center font-bold text-base`}>
          ✅ Proceed to Payment
        </Text>
      </TouchableOpacity>
    </View>
  </View>
);



};

export default VerifyProductsScreen;
