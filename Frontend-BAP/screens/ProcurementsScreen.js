import { View, Text,FlatList,TouchableOpacity,Image,SafeAreaView,TextInput,ScrollView} from 'react-native'
import React from 'react'
import backArrow from '../assets/left-arrow.png'
import ProcurementCard from '../components/ProcurementCard'
import tw from 'tailwind-react-native-classnames';
import { useState, useMemo } from 'react';
import CompletedProcurementCard from '../components/CompletedProcurementCard';
import filterIcon from '../assets/filter.png'
import Modal from 'react-native-modal';
import { useNavigation } from '@react-navigation/native';

const ProcurementsScreen = () => {
  const navigation = useNavigation();


  const [isModalVisible, setModalVisible] = useState(false);
  const [selectedDays, setSelectedDays] = useState('Last 60 days');
  const [selectedCrops, setSelectedCrops] = useState(['Wheat']);
  const [selectedFarmers, setSelectedFarmers] = useState(['Rahul Kumar']);

  const toggleModal = () => {
    setModalVisible(!isModalVisible);
  };

  const clearFilter = () => {
    setSelectedDays('');
    setSelectedCrops([]);
    setSelectedFarmers([]);
  };
  const [selectedTab, setSelectedTab] = useState('progressing');
    const procurementList = [
      {
        id: 'P001',
        date: '28-Jan-2023',
        farmerName: 'Rahul Kumar',
        farmerMobile: '9999999999',
        cropName: 'Wheat',
        variety: 'Desi',
        quantity: '67 Quintal',
        pricePerQuintal: 1350,
        totalAmount: 1350,
        dueAmount: 135,
        paymentStatus: 'Pending',
        isCompleted: false,
      },
      {
        id: 'P002',
        date: '27-Jan-2023',
        farmerName: 'Sachin Kumar',
        farmerMobile: '8888888888',
        cropName: 'Bajra',
        variety: 'Hybrid',
        quantity: '50 Quintal',
        pricePerQuintal: 1200,
        totalAmount: 60000,
        dueAmount: 0,
        paymentStatus: 'Completed',
        isCompleted: true,
      },
      {
        id: 'P003',
        date: '25-Jan-2023',
        farmerName: 'Rajat Kumar',
        farmerMobile: '7777777777',
        cropName: 'Sugarcane',
        variety: 'CO 86032',
        quantity: '80 Quintal',
        pricePerQuintal: 1000,
        totalAmount: 80000,
        dueAmount: 20000,
        paymentStatus: 'Partially Paid',
        isCompleted: false,
      },
      {
        id: 'P004',
        date: '24-Jan-2023',
        farmerName: 'Pawan Lalit',
        farmerMobile: '6666666666',
        cropName: 'Wheat',
        variety: 'Desi',
        quantity: '80 Quintal',
        pricePerQuintal: 1000,
        totalAmount: 80000,
        dueAmount: 20000,
        paymentStatus: 'Partially Paid',
        isCompleted: false,
      },
      {
        id: 'P005',
        date: '23-Jan-2023',
        farmerName: 'Parasuram',
        farmerMobile: '5555555555',
        cropName: 'Rice',
        variety: 'Basmati',
        quantity: '100 Quintal',
        pricePerQuintal: 1000,
        totalAmount: 100000,
        dueAmount: 0,
        paymentStatus: 'Completed',
        isCompleted: true,
      },
    ];


    const filteredList = procurementList.filter((item) => item.isCompleted === (selectedTab === 'completed' ? true : false));

  return (
    <SafeAreaView style={tw`flex-1 bg-white`}>
      <View
        style={tw`flex-row justify-start items-center p-1`}
        className='bg-[#B2FFB7]'
      >
        <TouchableOpacity onPress={() => navigation.navigate('Home')}>
          <Image source={backArrow} style={tw`w-6 h-6 p-1`} />
        </TouchableOpacity>
        <Text style={tw`text-xl font-semibold p-2`}>Procurement</Text>
      </View>

      <View className='flex-row border-b items-center border-gray-300 space-x-6 m-3'>
        <TouchableOpacity onPress={() => setSelectedTab('progressing')}>
          <Text
            className={`pb-2 font-semibold text-sm ${
              selectedTab === 'progressing'
                ? 'text-green-600 border-b-2 border-green-600'
                : 'text-gray-500'
            }`}
          >
            Progressing
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => setSelectedTab('completed')}>
          <Text
            className={`pb-2 font-semibold text-sm ${
              selectedTab === 'completed'
                ? 'text-green-600 border-b-2 border-green-600'
                : 'text-gray-500'
            }`}
          >
            Completed
          </Text>
        </TouchableOpacity>
      </View>

      <View className='flex-row items-center m-2 space-x-3'>
        <TextInput
          placeholder='Search Farmer'
          className='flex-1 border border-gray-300 rounded-md px-3 py-2 text-sm'
        />
        <TouchableOpacity className='flex-row items-center space-x-2' onPress={toggleModal}>
          <Image source={filterIcon} style={tw`w-6 h-6`} tintColor='#' />
          <Text className='text-gray-600 text-sm'>Filters</Text>
        </TouchableOpacity>
      </View>
      <View className='flex-1'>
        <FlatList
          showsVerticalScrollIndicator={false}
          data={filteredList}
          renderItem={({ item }) =>
            selectedTab === 'completed' ? (
              <CompletedProcurementCard item={item} />
            ) : (
              <ProcurementCard item={item} />
            )
          }
          keyExtractor={(item) => item.id.toString()}
        />
      </View>

      <TouchableOpacity className='absolute bottom-6 right-6 bg-green-600 w-12 h-12 rounded-md flex items-center justify-center shadow-lg'>
        <Text className='text-white text-2xl'>+</Text>
      </TouchableOpacity>

      <Modal
        isVisible={isModalVisible}
        onBackdropPress={toggleModal}
        style={{ margin: 0, justifyContent: 'flex-end' }}
      >
        <View className='bg-white rounded-t-3xl p-6 max-h-96'>
          <Text className='text-xl font-semibold mb-4'>Filters</Text>

          <View className='mb-4'>
            <Text className='text-sm font-medium mb-2'>Date Range</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false}>
              {[
                'Last 30 days',
                'Last 60 days',
                'Last 3 month',
                'Last 6 months',
              ].map((item) => (
                <TouchableOpacity
                  key={item}
                  className={`px-4 py-2 rounded-full mr-2 ${
                    selectedDays === item
                      ? 'bg-green-600'
                      : 'bg-gray-200'
                  }`}
                  onPress={() => setSelectedDays(item)}
                >
                  <Text className={`${
                    selectedDays === item ? 'text-white' : 'text-gray-700'
                  }`}>{item}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>

          <View className='mb-4'>
            <Text className='text-sm font-medium mb-2'>Crop Name</Text>
            <TextInput 
              className='border border-gray-300 rounded-md px-3 py-2 mb-2' 
              placeholder='Search Crop' 
            />
            <View className='flex-row flex-wrap'>
              {['Wheat', 'Bajra', 'Sugarcane', 'Chana'].map((crop) => (
                <TouchableOpacity
                  key={crop}
                  className={`px-4 py-2 rounded-full mr-2 mb-2 ${
                    selectedCrops.includes(crop)
                      ? 'bg-green-600'
                      : 'bg-gray-200'
                  }`}
                  onPress={() => {
                    setSelectedCrops((prev) =>
                      prev.includes(crop)
                        ? prev.filter((c) => c !== crop)
                        : [...prev, crop]
                    );
                  }}
                >
                  <Text className={`${
                    selectedCrops.includes(crop) ? 'text-white' : 'text-gray-700'
                  }`}>{crop}</Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>

          {/* <View className='mb-4'>
            <Text className='text-sm font-medium mb-2'>Farmer Name</Text>
            <TextInput 
              className='border border-gray-300 rounded-md px-3 py-2 mb-2' 
              placeholder='Search Farmer' 
            />
            <View className='flex-row flex-wrap'>
              {['Rahul Kumar', 'Sachin Kumar', 'Rajat Kumar', 'Suraj'].map(
                (farmer) => (
                  <TouchableOpacity
                    key={farmer}
                    className={`px-4 py-2 rounded-full mr-2 mb-2 ${
                      selectedFarmers.includes(farmer)
                        ? 'bg-green-600'
                        : 'bg-gray-200'
                    }`}
                    onPress={() => {
                      setSelectedFarmers((prev) =>
                        prev.includes(farmer)
                          ? prev.filter((f) => f !== farmer)
                          : [...prev, farmer]
                      );
                    }}
                  >
                    <Text className={`${
                      selectedFarmers.includes(farmer) ? 'text-white' : 'text-gray-700'
                    }`}>{farmer}</Text>
                  </TouchableOpacity>
                )
              )}
            </View>
          </View> */}

          <View className='flex-row space-x-3 mt-4'>
            <TouchableOpacity 
              className='flex-1 bg-gray-200 py-3 rounded-md items-center' 
              onPress={clearFilter}
            >
              <Text className='text-gray-700 font-medium'>Clear Filter</Text>
            </TouchableOpacity>
            <TouchableOpacity 
              className='flex-1 bg-green-600 py-3 rounded-md items-center' 
              onPress={toggleModal}
            >
              <Text className='text-white font-medium'>Apply</Text>
            </TouchableOpacity>
          </View>
        </View>
      </Modal>
    </SafeAreaView>
  );
}

export default ProcurementsScreen