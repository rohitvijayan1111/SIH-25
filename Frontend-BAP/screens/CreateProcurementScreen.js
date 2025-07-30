import {
  View,
  Text,
  TouchableOpacity,
  Image,
  TextInput,
  ScrollView,
} from 'react-native';
import { useState } from 'react';
import backArrow from '../assets/left-arrow.png';
import { CameraIcon } from 'react-native-heroicons/outline';
import tw from 'tailwind-react-native-classnames';
import { useNavigation } from '@react-navigation/native';
const CreateProcurementScreen = () => {
  const navigation = useNavigation();
  const [sameAsFarmer, setSameAsFarmer] = useState(false);
  return (
    <View className='flex-1 relative h-full bg-white'>
      <View
        style={tw`flex-row justify-start items-center p-2`}
        className='bg-[#B2FFB7]'
      >
        <TouchableOpacity onPress={() => navigation.navigate('Procurements')}>
          <Image source={backArrow} style={tw`w-6 h-6 p-1`} />
        </TouchableOpacity>
        <Text style={tw`text-xl font-semibold`}>Add New Procurement</Text>
      </View>

      <ScrollView className='flex-col space-y-2 p-4'>
        {/* <View className='flex-col space-y-2'> */}
        <Text className='font-bold'>Farmer Details</Text>

        <Text>Farmer Name</Text>
        <TextInput className='border-2 border-[#D9D9D9] rounded-lg p-2' />

        <Text>Phone No.</Text>
        <TextInput className='border-2 border-[#D9D9D9] rounded-lg p-2' />

        <Text className='font-bold'>Crop Details</Text>
        <TextInput
          className='border-2 border-[#D9D9D9] rounded-lg p-2'
          placeholder='Crop Name'
        />
        <TextInput
          className='border-2 border-[#D9D9D9] rounded-lg p-2'
          placeholder='Variety Name'
        />
        <Text className='font-semibold'>Upload or Click Crop Photo</Text>
        <TouchableOpacity
          // style={tw`flex m-2 justify-center items-center bg-gray-400 rounded-lg p-4`}
          className='flex  justify-center items-center h-[45%] bg-[#D9D9D9] rounded-lg '
        >
          <CameraIcon />
        </TouchableOpacity>

        <Text className='font-bold'>Delivery Person Details</Text>
        {!sameAsFarmer && (
          <View className='flex-col h-full space-y-2'>
            <TextInput
              className='border-2 border-[#D9D9D9] rounded-lg p-2'
              placeholder='Name'
            />
            <TextInput
              className='border-2 border-[#D9D9D9] rounded-lg p-2'
              placeholder='Mobile No.'
            />
            <TextInput
              className='border-2 border-[#D9D9D9] rounded-lg p-2'
              placeholder='Tractor No.'
            />

            <Text className='font-semibold'>Upload or Click Tractor Photo</Text>
            <TouchableOpacity
              // style={tw`flex m-2 justify-center items-center bg-gray-400 rounded-lg p-4`}
              className='flex justify-center items-center h-[45%] bg-[#D9D9D9] rounded-lg'
            >
              <CameraIcon />
            </TouchableOpacity>
          </View>
        )}
        {/* </View> */}
      </ScrollView>

      <View className='bg-[#ecfcf4] w-full absolute bottom-0 justify-center items-center py-2 px-4'>
        <TouchableOpacity className='bg-[#2B9846] justify-center items-center w-full p-2 rounded-lg'>
          <Text className='text-white'>Save</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

export default CreateProcurementScreen;
