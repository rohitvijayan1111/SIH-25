import React from 'react';
import { View, Text, ScrollView, Image, TouchableOpacity } from 'react-native';

const SimilarProducts = ({ relatedItems, navigation }) => {
  if (!relatedItems?.length) return null;

  return (
    <View className="mt-10">
      <Text className="text-xl font-bold mb-4">Similar Products</Text>

      <ScrollView horizontal showsHorizontalScrollIndicator={false}>
        {relatedItems.map((prod, index) => (
          <TouchableOpacity
            key={prod.id || index}
            onPress={() =>
              navigation.navigate('ProductDetails', {
                item_id: prod.id,
              })
            }
          >
            <View className="bg-white rounded-lg shadow p-3 mr-4 w-[160px]">
              <Image
                source={{ uri: prod.descriptor.images?.[0] }}
                style={{ width: '100%', height: 100, borderRadius: 8 }}
              />
              <Text className="font-semibold text-sm mt-2" numberOfLines={1}>
                {prod.descriptor.name}
              </Text>
              <Text className="text-green-700 text-base font-bold">
                ₹{prod.price.value}/ {prod.quantity.unitized?.measure?.unit}
              </Text>
              <Text className="text-xs text-gray-500" numberOfLines={1}>
                {prod.provider?.descriptor?.name || 'Provider'}
              </Text>
              <Text className="text-xs text-gray-500">
                {prod.quantity.available.count}{' '}
                {prod.quantity.unitized?.measure?.unit} available
              </Text>
            </View>
          </TouchableOpacity>
        ))}
      </ScrollView>
    </View>
  );
};

export default SimilarProducts;
