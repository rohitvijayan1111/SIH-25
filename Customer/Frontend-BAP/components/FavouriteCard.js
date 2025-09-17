import { View, Text, Image, TouchableOpacity } from 'react-native';
import React from 'react';
import tw from 'tailwind-react-native-classnames';

const FavouriteCard = ({ item }) => {
  return (
    <TouchableOpacity className='bg-white m-2 rounded-lg shadow w-40' flex-1>
      <View className='w-full'>
        <Image
          source={item.image}
          resizeMode='contain'
          // className='h-32'
          style={tw`h-32`}
        />
      </View>

      <View className='p-2'>
        <Text>{item.name}</Text>
        <Text>{item.price}</Text>
      </View>
    </TouchableOpacity>
  );
};

export default FavouriteCard;
