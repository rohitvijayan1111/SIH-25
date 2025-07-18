import { View, Text,TouchableOpacity,Image,SafeAreaView } from 'react-native'
import React from 'react'
import vehicle from '../assets/vehicle.png'
import backArrow from '../assets/left-arrow.png'
import crop from '../assets/crop.png'
import tw from "tailwind-react-native-classnames";
import { procurementdata } from '../constants/procurementdetails';
const ProcurementDetails = () => {


  const item=procurementdata;



  return (
    <SafeAreaView>
      <View
        style={tw`flex-row justify-start items-center p-1`}
        className='bg-[#B2FFB7]'
      >
        <TouchableOpacity onPress={() => navigation.navigate('Home')}>
          <Image source={backArrow} style={tw`w-6 h-6 p-1`} />
        </TouchableOpacity>
        <Text style={tw`text-xl font-semibold p-2`}>{item.farmerName}</Text>
      </View>
      <View style={tw`bg-white p-4 rounded-lg border-gray-300 border-2 m-2`}>
        <View
          style={tw`flex-row justify-between border-b-2 border-gray-400 pb-2 mb-2`}
        >
          <View style={tw`flex-row justify-start`}>
            <Text style={tw`text-sm text-gray-500`}>Date:</Text>
            {/* <Text style={tw`text-lg font-bold`}>{item.date}</Text> */}
            <Text className='text-md'>{item.date}</Text>
          </View>
          <TouchableOpacity
            // style={[tw`flex-row justify-end border-2 rounded-lg p-1`, { borderColor: '#2B9846' }]}
            style={tw`flex-row justify-end border-2 rounded-lg`}
            className='border-[#2B9846] px-2 py-1'
          >
            <Text style={tw`text-sm font-semibold`} className='text-[#2B9846]'>
              Edit
            </Text>
          </TouchableOpacity>
        </View>
        <View className='border-b border-gray-300 w-full mt-2' />

        <Text className='text-md font-bold'>Farmer Details</Text>
        <View style={tw`flex-row justify-between mb-2`}>
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
        <View className='border-b border-gray-300 w-full mt-2' />

        <Text className='text-md font-bold'>Crop Details</Text>
        <View style={tw`flex-row justify-between mb-2`}>
          <Text style={tw`text-sm text-gray-500`}>Farmer Name</Text>
          {/* <Text style={tw`text-lg font-bold`}>{item.farmerName}</Text> */}
          <Text className='text-md font-bold'>{item.cropName}</Text>
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
          <Text style={tw`text-sm text-gray-500`}>Variety</Text>
          <Text style={tw`text-sm font-bold`}>{item.variety}</Text>
        </View>
        <Text style={tw`text-sm text-gray-500 font-semibold`}>Crop Photo</Text>
        {/* <Text>Crop Photo</Text> */}
        <View style={tw`flex-row justify-center`}>
          <Image source={crop} />
        </View>
        <View className='border-b border-gray-300 w-full mt-2' />
        <Text className='text-md font-bold'>Delivery Person Details</Text>
        <View style={tw`flex-row justify-between mb-2`}>
          <Text style={tw`text-sm text-gray-500`}>Delivery Person Name</Text>
          {/* <Text style={tw`text-lg font-bold`}>{item.farmerName}</Text> */}
          <Text className='text-md font-bold'>{item.deliveryPersonName}</Text>
        </View>

        <View style={tw`flex-row justify-between mb-2`}>
          {/* <Text style={tw`text-sm text-gray-500`}>Delivery Person Mobile</Text> */}
          <Text style={tw`text-sm text-gray-500`} className=''>
            Delivery Person Mobile
          </Text>
          {/* <Text style={tw`text-md font-bold`}>{item.cropName}</Text> */}
          <Text className='text-md font-bold'>{item.deliveryPersonMobile}</Text>
          {/* <Text style={tw`text-md font-bold`}>{item.cropName}</Text> */}
        </View>

        <View style={tw`flex-row justify-between mb-2`}>
          <Text style={tw`text-sm text-gray-500`}>Vehicle No.</Text>
          <Text style={tw`text-sm font-bold`}>{item.tractorNo}</Text>
        </View>

        <Text style={tw`text-sm text-gray-500 font-semibold`}>
          Vehicle Photo
        </Text>

        <View style={tw`flex-row justify-center m-0 p-0`}>
          <Image source={vehicle} resizeMode='cover' />
        </View>
      </View>

      <View className="my-1">
        <TouchableOpacity
          // style={[tw`p-2 rounded-lg my-1`, { backgroundColor: '#2B9846' }]}
          style={tw`p-2 rounded-lg mx-2`}
          className='bg-[#2B9846]'
        >
          <Text
            style={tw`text-white text-sm font-semibold justify-center items-center flex`}
          >
            Complete the form
          </Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}

export default ProcurementDetails