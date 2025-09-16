import React, { useState } from 'react';
import {
  View,
  Text,
  SafeAreaView,
  ScrollView,
  TouchableOpacity,
  Image,
  FlatList,
  TextInput,
  ImageBackground,
} from 'react-native';
import { router } from 'expo-router';
// import { StatusBar } from 'expo-status-bar';
import tw from 'tailwind-react-native-classnames';

import {
  categoriesWithProducts,
  getFeaturedProducts,
  getProductsByCategory,
} from '../data/categoriesWithProducts';
import uipics from '../constants/uipics';

export default function Home() {
  const [selectedCategory, setSelectedCategory] = useState(1); // Fruits selected by default
  const [cartCount, setCartCount] = useState(3);

  const featuredProducts = getFeaturedProducts();
  const currentProducts = getProductsByCategory(selectedCategory);

  const renderCategoryTab = ({ item }) => (
    // <TouchableOpacity
    //   className={`items-center justify-center px-4 py-2 mx-2 rounded-full ${
    //     item.isSelected ? 'bg-green-500' : 'bg-gray-200'
    //   }`}
    //   onPress={() => setSelectedCategory(item.id)}
    // >
    //   <Text className='text-2xl mb-1'>{item.icon}</Text>
    //   <Text
    //     className={`text-sm font-medium ${
    //       item.isSelected ? 'text-white' : 'text-gray-700'
    //     }`}
    //   >
    //     {item.name}
    //   </Text>
    // </TouchableOpacity>
    <TouchableOpacity
      className='w-40 h-52 rounded-xl overflow-hidden mr-4 shadow-sm'
      onPress={() => setSelectedCategory(item.id)}
    >
      <ImageBackground
        source={item.image} // <-- Use category image here
        style={{ flex: 1, justifyContent: 'flex-end' }}
        imageStyle={{ borderRadius: 12, width: '100%', height: '100%' }}
        resizeMode='cover'
      >
        <View className='bg-black bg-opacity-40 p-3 rounded-b-xl'>
          <Text className='text-white text-lg font-semibold'>{item.name}</Text>
          {/* <Text className='text-white text-sm'>From ₹{item.price}</Text> */}
        </View>
      </ImageBackground>
    </TouchableOpacity>
  );

  const renderFeaturedProduct = ({ item }) => (
    <TouchableOpacity
      className='w-32 bg-white rounded-lg shadow-sm mr-3 py-3 pb-3'
      onPress={() => router.push(`/product/${item.id}`)}
    >
      <View className='relative'>
        <View className='w-full h-20 bg-gray-100 rounded-lg mb-2 items-center justify-center'>
          {/* <Text className='text-2xl'>
            {item.category === 'Fruits' ? '🍎' : '🥬'}
          </Text> */}
          {item.image && (
            <Image
              source={item.image}
              className='w-32 h-32s rounded-lg'
              style={{ width: 100, height: 100 }}
              resizeMode='contain'
            />
          )}
        </View>
        <TouchableOpacity className='absolute top-1 right-1 w-5 h-5 bg-white rounded-full items-center justify-center'>
          <Text
            className={
              item.isFavorite ? 'text-red-500 text-lg' : 'text-gray-400 text-lg'
            }
          >
            ♥
          </Text>
        </TouchableOpacity>
      </View>

      <Text className='text-xs font-medium text-gray-900 mb-1'>
        {item.category}
      </Text>
      <Text className='text-sm font-semibold text-gray-900 mb-1'>
        {item.name}
      </Text>
      <Text className='text-lg font-bold text-gray-900'>{item.price}</Text>
    </TouchableOpacity>
  );

  const renderProductItem = ({ item }) => (
    <View className='flex-row bg-white rounded-lg shadow-sm mb-3 p-4'>
      <View className='w-16 h-16 bg-gray-100 rounded-lg mr-6 items-center justify-center'>
        {item.image && (
          <Image
            source={item.image}
            className='w-32 h-32s rounded-lg'
            style={{ width: 100, height: 100 }}
            resizeMode='cover'
          />
        )}
      </View>

      <View className='flex-1'>
        <Text className='text-xs text-green-600 font-medium mb-1'>
          {item.category}
        </Text>
        <Text className='text-sm font-semibold text-gray-900 mb-1'>
          {item.name}
        </Text>
        <Text className='text-lg font-bold text-gray-900'>{item.price}</Text>
      </View>

      <View className='items-end justify-between'>
        <View className='flex-row items-center'>
          <Text className='text-lg font-bold mr-2'>{item.quantity}</Text>
          <TouchableOpacity className='w-8 h-8 bg-green-500 rounded-full items-center justify-center'>
            <Text className='text-white font-bold text-lg'>+</Text>
          </TouchableOpacity>
        </View>

        <TouchableOpacity className='bg-green-500 px-4 py-2 rounded-lg mt-2'>
          <Text className='text-white text-xs font-medium'>
            {item.addToCartText}
          </Text>
        </TouchableOpacity>
      </View>
    </View>
  );

  return (
    <SafeAreaView 
    className='flex-1 bg-gray-50'
     style={tw`flex-1`}
     >
      {/* <ScrollView> */}
      <ScrollView showsVerticalScrollIndicator={false} style={tw`flex-1`}>
        {/* Hero Section */}
        {/* <View className='bg-green-600 px-4 pt-4 pb-20 relative'> */}
        <ImageBackground
          source={uipics.BannerWithBlack}
          className='px-4 pt-4 pb-20'
          style={{ resizeMode: 'cover', width: '100%' }}
        >
          {/* Header */}
          <View className='flex-row items-center justify-end mb-6'>
            {/* <View className='w-10 h-10 bg-white rounded-full items-center justify-center'>
              <Text className='text-green-600 font-bold'>GK</Text>
            </View> */}

            <View className='flex-row items-center'>
              <TouchableOpacity className='mr-4'>
                {/* <Text className='text-white text-lg'>🔍</Text> */}
                <Image
                  source={uipics.search}
                  className='w-6 h-6'
                  style={{ width: 24, height: 24 }}
                  tintColor='white'
                />
              </TouchableOpacity>
              <TouchableOpacity
                className='relative'
                onPress={() => router.push('/ShoppingCart')}
              >
                <Image
                  source={uipics.cart}
                  className='w-6 h-6'
                  style={{ width: 24, height: 24 }}
                  tintColor='white'
                />
                {cartCount > 0 && (
                  <View className='absolute -top-2 -right-2 w-5 h-5 bg-red-500 rounded-full items-center justify-center'>
                    <Text className='text-white text-xs font-bold'>
                      {cartCount}
                    </Text>
                  </View>
                )}
              </TouchableOpacity>
            </View>
          </View>

          {/* Location */}
          <Text className='text-white text-sm opacity-75 mb-2'>1/5</Text>
          <Text className='text-white text-lg font-medium mb-6'>
            Fruits & Vegetables
          </Text>

          {/* Hero Text */}
          <Text className='text-white text-2xl font-bold mb-2'>
            Produced by local &
          </Text>
          <Text className='text-white text-2xl font-bold mb-4'>
            it's safe to eat
          </Text>
          <TouchableOpacity className='bg-green-500 px-6 py-3 rounded-lg self-start'>
            <Text className='text-white font-semibold'>Shop Now</Text>
          </TouchableOpacity>
          {/* </View> */}
        </ImageBackground>

        {/* White Content Container */}
        <View className='flex-1 bg-white -mt-12 mx-4 rounded-t-2xl'>
          {/* Categories Section */}
          <View className='p-4'>
            <View className='flex-row items-center justify-between mb-4'>
              <Text className='text-lg font-bold text-gray-900'>
                Categories
              </Text>
              <TouchableOpacity>
                <Text className='text-green-600 font-medium'>See all</Text>
              </TouchableOpacity>
            </View>

            {/* Category Tabs */}
            <FlatList
              data={categoriesWithProducts}
              renderItem={renderCategoryTab}
              keyExtractor={(item) => item.id.toString()}
              horizontal
              showsHorizontalScrollIndicator={false}
              className='mb-6'
            />

            {/* Categories Grid */}
          </View>

          {/* Featured Section */}
          <View className='px-4 mb-4'>
            <View className='flex-row items-center justify-between mb-4'>
              <Text className='text-lg font-bold text-gray-900'>Featured</Text>
              <TouchableOpacity>
                <Text className='text-green-600 font-medium'>See all</Text>
              </TouchableOpacity>
            </View>

            <FlatList
              data={featuredProducts}
              renderItem={renderFeaturedProduct}
              keyExtractor={(item) => item.id.toString()}
              horizontal
              showsHorizontalScrollIndicator={false}
              contentContainerStyle={{ paddingRight: 16 }}
            />
          </View>

          {/* Best Sellers Section */}
          <View className='px-4'>
            <View className='flex-row items-center justify-between mb-4'>
              <Text className='text-lg font-bold text-gray-900'>
                Best Sellers
              </Text>
              <View className='flex-row items-center'>
                <TouchableOpacity className='mr-4'>
                  <Text className='text-gray-600'>🔁 Sort</Text>
                </TouchableOpacity>
                <TouchableOpacity>
                  <Text className='text-gray-600'>🔧 Filter</Text>
                </TouchableOpacity>
              </View>
            </View>

            {/* Products List */}
            <FlatList
              data={currentProducts}
              renderItem={renderProductItem}
              keyExtractor={(item) => item.id.toString()}
              scrollEnabled={false}
            />
          </View>
          {/* </ScrollView> */}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}
