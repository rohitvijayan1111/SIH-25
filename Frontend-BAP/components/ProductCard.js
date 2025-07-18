import React from 'react';
import { View, Text, TouchableOpacity, Image } from 'react-native';
import tw from 'tailwind-react-native-classnames';

export default function ProductCard({ item, provider, onPress }) {
  const imageUrl = item?.descriptor?.images?.[0] || 'https://via.placeholder.com/150';
  const name = item?.descriptor?.name || 'Unnamed Product';
  const unit = item?.quantity?.unitized?.measure?.unit || '';
  const isOrganic = item?.tags?.includes('organic');

  const sellerName = provider?.descriptor?.name || 'Unknown Seller';
  const sellerLocation = provider?.locations?.[0]?.address?.split(',')[0] || '';

  return (
    <TouchableOpacity
      onPress={onPress}
      style={tw`w-44 mr-4 bg-green-50 rounded-xl p-4 shadow-md border border-green-100 relative`}
    >
      {/* Image container with badge */}
      <View style={tw`relative w-full h-36 mb-3`}>
        {isOrganic && (
          <View style={tw`absolute top-2 right-2 bg-green-200 px-2 py-0.5 rounded-full z-10`}>
            <Text style={tw`text-green-800 text-xs font-semibold`}>Organic</Text>
          </View>
        )}

        <Image
          source={{ uri: imageUrl }}
          style={tw`w-full h-full rounded-lg`}
          resizeMode="contain"
        />
      </View>

      {/* Product Name */}
      <Text style={tw`text-base font-semibold text-gray-800 mb-1`} numberOfLines={2}>
        {name}
      </Text>

      {/* Price List for All Batches */}
      {Array.isArray(item.batches) && item.batches.length > 0 ? (
        <View style={tw`mb-2`}>
          {item.batches.map((batch, index) => (
            <Text key={index} style={tw`text-green-700 text-xs`}>
              ₹{batch?.price?.value} / {unit}
            </Text>
          ))}
        </View>
      ) : (
        <Text style={tw`text-gray-500 text-xs mb-2`}>Price unavailable</Text>
      )}

      {/* Seller Info */}
      <Text style={tw`text-green-600 text-xs font-medium`} numberOfLines={1}>
        Seller: {sellerName}
      </Text>
      <Text style={tw`text-gray-500 text-xs mt-1`} numberOfLines={1}>
        {sellerLocation}
      </Text>
    </TouchableOpacity>
  );
}
