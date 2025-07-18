// components/CategorySection.js
import React from 'react';
import { View, Text, FlatList } from 'react-native';
import tw from 'tailwind-react-native-classnames';
import ProductCard from './ProductCard';

export default function CategorySection({ category, items, providers, navigation }) {
  
  const renderItem = ({ item }) => {
    const provider = providers.find(p => p.id === item.provider.id);
    return (
      <ProductCard
        item={item}
        provider={provider}
        onPress={() => {
          navigation.navigate('ProductDetails', { item_id: item.id });
        }}
      />
    );
  };

  return (
    <View style={tw`mb-6`}>
      <Text style={tw`text-xl font-bold px-4 mb-3 text-gray-800`}>
        {category === 'CROP'
          ? 'Grains & Pulses'
          : category === 'DAIRY'
          ? 'Dairy Products'
          : category}
      </Text>
      <FlatList
        horizontal
        data={items}
        renderItem={renderItem}
        keyExtractor={(item) => item.id}
        contentContainerStyle={tw`px-4`}
        showsHorizontalScrollIndicator={false}
        ListEmptyComponent={
          <View style={tw`w-full h-32 justify-center items-center`}>
            <Text style={tw`text-gray-500`}>No products available</Text>
          </View>
        }
      />
    </View>
  );
}
