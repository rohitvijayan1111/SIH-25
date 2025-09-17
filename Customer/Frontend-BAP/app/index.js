import { View, Text, TouchableOpacity } from 'react-native';
import React from 'react';
import { useRouter } from 'expo-router';

const index = () => {
  const router = useRouter();

  return (
    <View className='items-center justify-center flex-1'>
      <Text className='text-2xl font-bold text-blue-400'>index</Text>
      <TouchableOpacity onPress={() => router.push('/Login')} className='my-4'>
        <Text className='text-lg font-semibold'>Login</Text>
      </TouchableOpacity>
      <TouchableOpacity onPress={() => router.push('/SignUp')} className='my-4'>
        <Text className='text-lg font-semibold'>Signup</Text>
      </TouchableOpacity>
      {/* <TouchableOpacity
        onPress={() => router.push('/Favourites')}
        className='my-4'
      >
        <Text className='text-lg font-semibold'>Favourites</Text>
      </TouchableOpacity>
      <TouchableOpacity
        onPress={() => router.push('/Notifications')}
        className='my-4'
      >
        <Text className='text-lg font-semibold'>Notifications</Text>
      </TouchableOpacity> */}
      <TouchableOpacity
        onPress={() => router.push('/BrowsePage')}
        className='my-4'
      >
      <Text className='text-lg font-semibold'>Browse</Text>
      </TouchableOpacity>
      <TouchableOpacity
        onPress={() => router.push('/Checkout')}
        className='my-4'
      >
        <Text className='text-lg font-semibold'>Checkout</Text>
      </TouchableOpacity>

      <TouchableOpacity
        onPress={() => router.push('/QrScanScreen')}
        className='my-4'
      >
      <Text className='text-lg font-semibold'>QR Scan Screen</Text>
      </TouchableOpacity>
      <TouchableOpacity
        onPress={() => router.push('/UploadHarvest')}
        className='my-4'
      >
        <Text className='text-lg font-semibold'>Upload Harvest</Text>
      </TouchableOpacity>

      
    </View>
  );
};

export default index;
