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
    const providerName = item.provider?.descriptor?.name || 'Unknown Seller';

    return (
      <TouchableOpacity
        onPress={() =>
          navigation.navigate('ProductDetails', { item_id: item.id })
        }
        style={tw`w-44 mr-4 bg-white rounded-xl p-3 shadow-sm border border-gray-100`}
      >
        <Image
          source={{
            uri: item.descriptor?.images?.[0] || 'https://via.placeholder.com/150',
          }}
          style={tw`w-full h-36 rounded-lg mb-2`}
          resizeMode="contain"
        />
        <Text style={tw`text-base font-semibold`} numberOfLines={2}>
          {item.descriptor?.name}
        </Text>
        <Text style={tw`text-blue-600 font-medium text-sm my-1`}>
          ₹{item.price?.value} / {item.quantity?.unitized?.measure?.unit}
        </Text>
        <Text style={tw`text-green-600 text-xs`} numberOfLines={1}>
          Seller: {providerName}
        </Text>
      </TouchableOpacity>
    );
  };

  return (
    <View style={tw`mt-8`}>
      <Text style={tw`text-xl font-bold px-2 mb-3`}>Similar Products</Text>
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
