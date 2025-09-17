import {
  View,
  Text,
  SafeAreaView,
  TouchableOpacity,
  FlatList,
  Image,
} from 'react-native';
import React from 'react';
import FavouriteCard from '../components/FavouriteCard';
import broccolipic from '../assets/images/broccoli.jpeg';
import tw from 'tailwind-react-native-classnames';


const favourites = () => {
  const favoritesData = [
    {
      id: 1,
      name: 'Broccoli',
      price: '₹50',
      originalPrice: '₹60',
      image: broccolipic,
      category: 'vegetables',
      isOrganic: true,
      inStock: true,
      rating: 4.5,
      discount: 17,
      isFavorite: true,
    },
    {
      id: 2,
      name: 'Fresh Papaya',
      price: '₹80',
      originalPrice: '₹90',
      image: broccolipic,
      category: 'fruits',
      isOrganic: true,
      inStock: true,
      rating: 4.3,
      discount: 11,
      isFavorite: true,
    },
    {
      id: 3,
      name: 'Banana Bread',
      price: '₹3.45',
      originalPrice: '₹4.00',
      image: broccolipic,
      category: 'bakery',
      isOrganic: false,
      inStock: true,
      rating: 4.7,
      discount: 14,
      isFavorite: true,
    },
    {
      id: 4,
      name: 'Carrot',
      price: '₹3.45',
      originalPrice: '₹4.00',
      image: broccolipic,
      category: 'vegetables',
      isOrganic: true,
      inStock: true,
      rating: 4.2,
      discount: 14,
      isFavorite: true,
    },
    {
      id: 5,
      name: 'Watermelon',
      price: '₹45',
      originalPrice: '₹55',
      image: broccolipic,
      category: 'fruits',
      isOrganic: false,
      inStock: true,
      rating: 4.1,
      discount: 18,
      isFavorite: true,
    },
    {
      id: 6,
      name: 'Red Onion',
      price: '₹25',
      originalPrice: '₹30',
      image: broccolipic,
      category: 'vegetables',
      isOrganic: false,
      inStock: true,
      rating: 4.0,
      discount: 17,
      isFavorite: true,
    },
  ];

  return (
    <SafeAreaView>
      <View className='bg-emerald-800 flex-row justify-between items-center p-4'>
        <TouchableOpacity>
          <Text>Edit</Text>
        </TouchableOpacity>
        <TouchableOpacity>
          <Text>Search</Text>
        </TouchableOpacity>
      </View>
      <View>
        <Text className='text-2xl font-bold'>Favourites</Text>
      </View>
      <View className='bg-emerald-400 flex-row justify-between items-center p-4'>
        <TouchableOpacity className=' flex-1 bg-emerald-800 p-2 rounded'>
          <Text>Sort</Text>
        </TouchableOpacity>
        <TouchableOpacity className='flex-1 bg-emerald-800 m-x-2 p-2 rounded'>
          <Text>Filter</Text>
        </TouchableOpacity>
      </View>
      {/* <Image source='' /> */}
      <View>
        <FlatList
          data={favoritesData}
          numColumns={2}
          className='p-2'
          renderItem={({ item }) => (
            // <View>
            //   <Text>{item.name}</Text>
            //   <Text>{item.price}</Text>
            //   <Image source={item.image} />
            // </View>

            <FavouriteCard item={item} />
          )}
          keyExtractor={(item) => item.id.toString()}
        />
      </View>
    </SafeAreaView>
  );
};

export default favourites;
