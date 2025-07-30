import { View, Text, TouchableOpacity } from 'react-native';
import React from 'react';
import tw from 'tailwind-react-native-classnames';
import { useNavigation } from '@react-navigation/native';

const ProcurementCard = ({ item }) => {
  const navigation = useNavigation();
  return (
    <View style={tw`bg-white p-4 rounded-lg border-gray-300 border-2 m-2`}>
      <View
        style={tw`-mx-4 flex flex-row justify-between items-center border-b-2 border-gray-300 pb-2 pl-2 pr-2`}
      >
        <View style={tw`flex-row justify-start items-center mx-2`}>
          <Text style={tw`text-sm text-gray-500`}>Date:</Text>
          {/* <Text style={tw`text-lg font-bold`}>{item.date}</Text> */}
          <Text className='text-md'>{item.date}</Text>
        </View>
        <TouchableOpacity
          // style={[tw`flex-row justify-end border-2 rounded-lg p-1`, { borderColor: '#2B9846' }]}
          style={tw`flex-row border-2 rounded-lg px-4 py-1 mx-1`}
          className='border-[#2B9846]'
        >
          <Text
            style={tw`text-sm font-semibold`}
            className='text-[#2B9846]'
            onPress={() => navigation.navigate('PaymentDetails')}
          >
            Payment Info
          </Text>
        </TouchableOpacity>
      </View>
      <View style={tw`flex-row justify-between my-2`}>
        <Text style={tw`text-sm text-gray-500`}>Farmer Name</Text>
        {/* <Text style={tw`text-lg font-bold`}>{item.farmerName}</Text> */}
        <Text className='text-md font-bold'>{item.farmerName}</Text>
      </View>

      <View style={tw`flex-row justify-between mb-2`}>
        <Text style={tw`text-sm text-gray-500`}>Farmer No.</Text>
        {/* <Text style={tw`text-lg font-bold`}>{item.farmerMobile}</Text> */}
        <Text className='text-md font-bold'>{item.farmerMobile}</Text>
      </View>

      <View style={tw`flex-row justify-between mb-2`}>
        <Text style={tw`text-sm text-gray-500`}>Crop Name</Text>
        {/* <Text style={tw`text-md font-bold`}>{item.cropName}</Text> */}
        <Text className='text-md font-bold'>{item.cropName}</Text>
        {/* <Text style={tw`text-md font-bold`}>{item.cropName}</Text> */}
      </View>

      <View style={tw`flex-row justify-between mb-2`}>
        <Text style={tw`text-sm text-gray-500`}>Quantity</Text>
        <Text style={tw`text-sm font-bold`}>{item.quantity}</Text>
      </View>
      <View style={tw`flex-row justify-between mb-2`}>
        <Text style={tw`text-sm text-gray-500`}>Price Per Quintal</Text>
        <Text style={tw`text-sm font-bold`}>₹{item.pricePerQuintal}</Text>
      </View>
      <View style={tw`flex-row justify-between mb-2`}>
        <Text style={tw`text-sm text-gray-500`}>Total Amount</Text>
        <Text style={tw`text-sm font-bold`}>₹{item.totalAmount}</Text>
      </View>
      <View style={tw`flex-row justify-between mb-2`}>
        <Text style={tw`text-sm text-gray-500`}>Variety</Text>
        <Text style={tw`text-sm font-bold`}>{item.variety}</Text>
      </View>

      <TouchableOpacity
        // style={[tw`p-2 rounded-lg my-1`, { backgroundColor: '#2B9846' }]}
        style={tw`p-2 rounded-lg my-1`}
        // className='bg-[#2B9846]'
        className='border-[#2B9846] border-2'
        onPress={() => navigation.navigate('CompletedProcurementDetails')}
      >
        <Text
          // style={tw`text-white text-sm font-semibold justify-center items-center flex`}
          style={tw`text-sm font-semibold justify-center items-center flex`}
          className='text-[#2B9846]'
        >
          More Info
        </Text>
      </TouchableOpacity>
    </View>
  );
};

export default ProcurementCard;
