import React from 'react';
import {
  View,
  Text,
  FlatList,
  Image,
  TouchableOpacity,
} from 'react-native';
import tw from 'tailwind-react-native-classnames';

const SimilarProducts = ({ relatedItems, navigation }) => {
  if (!relatedItems || relatedItems.length === 0) {
    return null;
  }

  const renderProductCard = ({ item }) => {
    const providerName = item.providerName || item.provider?.descriptor?.name || 'Unknown Seller';
    const imageUrl = item.image || item.descriptor?.images?.[0] || 'https://via.placeholder.com/150';
    const priceValue = item.price?.value || '0.00';
    const currency = item.price?.currency || 'INR';
    const unit = item.quantity?.unitized?.measure?.unit || '';

    return (
      <TouchableOpacity
        onPress={() =>
          navigation.navigate('ProductDetails', { item_id: item.id })
        }
        style={tw`w-44 mr-4 bg-green-50 rounded-xl p-4 shadow-md border border-green-100`}
      >
        {/* Product Image */}
        <Image
          source={{ uri: imageUrl }}
          style={tw`w-full h-36 rounded-lg mb-3`}
          resizeMode="contain"
        />

        {/* Product Name */}
        <Text
          style={tw`text-sm font-semibold text-gray-800 mb-1`}
          numberOfLines={2}
        >
          {item.descriptor?.name || 'Unnamed Product'}
        </Text>

        {/* Price */}
        <Text style={tw`text-green-600 font-bold text-sm mb-1`}>
          ₹{priceValue} / {unit}
        </Text>

        {/* Seller Info */}
        <Text style={tw`text-green-700 text-xs font-medium`} numberOfLines={1}>
          Seller: {providerName}
        </Text>
      </TouchableOpacity>
    );
  };

  return (
    <View style={tw`mt-8`}>
      <Text style={tw`text-xl font-bold px-2 mb-3 text-gray-800`}>
        Similar Products
      </Text>
      <FlatList
        horizontal
        data={relatedItems}
        keyExtractor={(item) => item.id}
        renderItem={renderProductCard}
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={tw`px-2`}
      />
    </View>
  );
};

export default SimilarProducts;