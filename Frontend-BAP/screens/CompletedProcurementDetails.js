import { View, Text } from 'react-native'
import React from 'react'

const CompletedProcurementDetails = ({item}) => {

  const Procurement={

  }
  return (
    <View style={tw`bg-white p-4 rounded-lg border-gray-300 border-2 m-2`}>
      <View
        style={tw`flex-row justify-between border-b-2 border-gray-400 pb-2 mb-2`}
      >
        <View style={tw`flex-row justify-start`}>
          <Text style={tw`text-sm text-gray-500`}>Date:</Text>
          <Text className='text-md'>{item.date}</Text>
        </View>
        <TouchableOpacity

          style={tw`flex-row justify-end border-2 rounded-lg p-2`}
          className='border-[#2B9846]'
        >
          <Text style={tw`text-sm font-semibold`} className='text-[#2B9846]'>
            More Details
          </Text>
        </TouchableOpacity>
      </View>
      <View style={tw`flex-row justify-between mb-2`}>
        <Text style={tw`text-sm text-gray-500`}>Farmer Name</Text>
        {/* <Text style={tw`text-lg font-bold`}>{item.farmerName}</Text> */}
        <Text className='text-md font-bold'>{item.farmerName}</Text>
      </View>

      <View style={tw`flex-row justify-between mb-2`}>
        <Text style={tw`text-sm text-gray-500`}>Farmer No.</Text>
        <Text className='text-md font-bold'>{item.farmerMobile}</Text>
      </View>

      <View style={tw`flex-row justify-between mb-2`}>
        <Text style={tw`text-sm text-gray-500`}>Crop Name</Text>
        {/* <Text style={tw`text-md font-bold`}>{item.cropName}</Text> */}
        <Text className='text-md font-bold'>{item.cropName}</Text>
        {/* <Text style={tw`text-md font-bold`}>{item.cropName}</Text> */}
      </View>

      <View style={tw`flex-row justify-between mb-2`}>
        <Text style={tw`text-sm text-gray-500`}>Variety</Text>
        <Text style={tw`text-sm font-bold`}>{item.variety}</Text>
      </View>

      <TouchableOpacity
        // style={[tw`p-2 rounded-lg my-1`, { backgroundColor: '#2B9846' }]}
        style={tw`p-2 rounded-lg my-1`}
        className='bg-[#2B9846]'
      >
        <Text
          style={tw`text-white text-sm font-semibold justify-center items-center flex`}
        >
          Complete the form
        </Text>
      </TouchableOpacity>
    </View>
  );
}

export default CompletedProcurementDetails