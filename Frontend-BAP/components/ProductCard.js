// components/ProductCard.js
import React from 'react';
import { View, Text, TouchableOpacity, Image } from 'react-native';
import tw from 'tailwind-react-native-classnames';

export default function ProductCard({ item, provider, onPress }) {
   
    return (
          <TouchableOpacity
      onPress={onPress}
      style={tw`w-44 mr-4 bg-white rounded-xl p-3 shadow-sm border border-gray-100`}
    >
        <Image
          source={{ uri: item.descriptor.images?.[0] || 'https://via.placeholder.com/150' }}
          style={tw`w-full h-36 rounded-lg mb-2`}
          resizeMode="contain"
        />
        <Text style={tw`text-base font-semibold mt-1`} numberOfLines={2}>
          {item.descriptor.name}
        </Text>
        <Text style={tw`text-blue-600 font-medium text-sm my-1`}>
          ₹{item.price.value} / {item.quantity.unitized.measure.unit}
        </Text>
        {provider && (
          <>
            <Text style={tw`text-green-600 text-xs`} numberOfLines={1}>
              Seller: {provider.descriptor?.name}
            </Text>
            <Text style={tw`text-gray-400 text-xs mt-1`} numberOfLines={1}>
              {provider.locations?.[0]?.address.split(',')[0]}
            </Text>
          </>
        )}
       </TouchableOpacity>
    );
  };