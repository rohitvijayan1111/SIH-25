import {
  View,
  Text,
  FlatList,
  TouchableOpacity,
  Image,
  SafeAreaView,
  TextInput,
  ScrollView,
  Dimensions,
} from 'react-native';
import React from 'react';
import backArrow from '../assets/left-arrow.png';
import ProcurementCard from '../components/ProcurementCard';
import tw from 'tailwind-react-native-classnames';
import { useState, useMemo, useRef } from 'react';
import CompletedProcurementCard from '../components/CompletedProcurementCard';
import filterIcon from '../assets/filter.png';
import Modal from 'react-native-modal';
import { useNavigation } from '@react-navigation/native';
import { images } from '../constants/images';
import { data } from '../constants/data';
import CreateProcurementScreen from './CreateProcurementScreen';

const Circle = ({ selected }) => (
  <View
    style={{
      borderRadius: 12,
      borderWidth: 2,
      borderColor: '#2B9846',
      alignItems: 'center',
      justifyContent: 'center',
    }}
    className='w-6 h-6 rounded-full '
  >
    {selected && (
      <View
        style={{
          width: 12,
          height: 12,
          borderRadius: 6,
          backgroundColor: '#2B9846',
        }}
      />
    )}
  </View>
);

const ProcurementsScreen = () => {
  const [isFarmerModal, setFarmerModal] = useState(false);

  const farmerInputRef = useRef < TextInput > null;
  const [isModalVisible, setModalVisible] = useState(false);
  const [selectedDays, setSelectedDays] = useState('Last 60 days');
  const [selectedCrops, setSelectedCrops] = useState(['Wheat']);
  const [selectedFarmers, setSelectedFarmers] = useState(['Rahul Kumar']);

  const toggleModal = () => {
    setModalVisible(!isModalVisible);
  };

  const openFarmerModal = () => setFarmerModal(true);
  const closeFarmerModal = () => {
    setFarmerModal(false);
  };
  const clearFilter = () => {
    setSelectedDays('');
    setSelectedCrops([]);
    setSelectedFarmers([]);
  };
  const [selectedTab, setSelectedTab] = useState('progressing');

  const { procurementList, farmers } = data;

  const filteredList = procurementList.filter(
    (item) => item.isCompleted === (selectedTab === 'completed' ? true : false)
  );

  const navigation = useNavigation();

  return (
    <SafeAreaView style={tw`flex-1 bg-white`}>
      <View
        style={tw`flex flex-row justify-start items-center p-1`}
        className='bg-[#B2FFB7]'
      >
        <TouchableOpacity onPress={() => navigation.navigate('Welcome')}>
          <Image source={backArrow} style={tw`w-6 h-6`} />
        </TouchableOpacity>
        <Text style={tw`text-xl font-semibold p-2`}>Procurement</Text>
      </View>

      <View className='flex-row border-b items-center border-gray-300 my-3'>
        <TouchableOpacity
          onPress={() => setSelectedTab('progressing')}
          className='w-1/2'
        >
          <Text
            className={`pb-2 flex justify-center item-center font-semibold text-sm ${
              selectedTab === 'progressing'
                ? 'text-green-600 border-b-2 border-green-600'
                : 'text-gray-500'
            }`}
          >
            Progressing
          </Text>
        </TouchableOpacity>

        <TouchableOpacity
          onPress={() => setSelectedTab('completed')}
          className='justify-center w-1/2'
        >
          <Text
            className={`pb-2 
                flex justify-center item-center
                font-semibold text-sm ${
                  selectedTab === 'completed'
                    ? 'text-green-600 border-b-2 border-green-600'
                    : 'text-gray-500'
                }`}
          >
            Completed
          </Text>
        </TouchableOpacity>
      </View>

      <View className='flex flex-row  justify-between items-center space-x-3 p-2'>
        <TouchableOpacity onPress={openFarmerModal} className='flex-1'>
          <View className='flex flex-row items-center border-2 border-[#D9D9D9] rounded-md p-2'>
            <Image
              source={images.find}
              tintColor='#D9D9D9'
              style={tw`w-6 h-6`}
            />
            <Text className='pl-2'>Search Farmers</Text>
          </View>
        </TouchableOpacity>

        <TouchableOpacity className='' onPress={toggleModal}>
          <View className='flex flex-row'>
            <Image source={filterIcon} style={tw`w-6 h-6`} />
            <Text className='text-gray-600 text-sm'>Filters</Text>
          </View>
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

      <TouchableOpacity
        className='absolute bottom-6 right-6 bg-green-600 w-12 h-12 rounded-md  shadow-lg'
        style={tw`flex justify-center items-center`}
        onPress={() => navigation.navigate('CreateProcurement')}
      >
        {/* <Text className='text-white text-5xl w-du'>+</Text> */}
        <Image
          source={images.filterplus}
          resizeMode='contain'
          // className='w-10 h-10 '
          style={[tw`w-9 h-9`, { tintColor: 'white' }]}
        />
      </TouchableOpacity>

      <Modal
        isVisible={isFarmerModal}
        onBackdropPress={closeFarmerModal}
        style={{ margin: 0, justifyContent: 'flex-end' }}
        animationType='slide' // className='flex'
        className
      >
        <View className=' bg-white rounded-t-3xl p-6 max-h-96'>
          <View className='flex-1'>
            <Text className='text-2xl font-semibold mb-4'>Select Farmer</Text>
            <View className='border-b-1 border-[#D9D9D9]'></View>
            <ScrollView>
              <View className='mb-4'>
                <FlatList
                  data={farmers}
                  renderItem={({ item }) => (
                    <View className='flex-row justify-between bg-[#2B9846]/[0.08] p-2  rounded-lg my-1'>
                      <View className='flex-row flex-1 gap-2'>
                        <View className='w-10 h-10 rounded-lg bg-[#2B9846] justify-center items-center'>
                          <Text className='text-white font-semibold text-xl'>
                            {item.name[0]}
                          </Text>
                        </View>
                        <View className='flex-col flex-1'>
                          <Text>{item.name}</Text>
                          <Text>{item.mobile}</Text>
                        </View>
                      </View>

                      <View className=' rounded-full border-1'>
                        <Circle selected={false} />
                      </View>
                    </View>
                  )}
                  key={(item) => item.id}
                />
              </View>
            </ScrollView>
            <View className='flex-row space-x-3 mt-4'>
              <TouchableOpacity
                className='flex-1 py-3 rounded-lg items-center border-2 border-[#2B9846]'
                onPress={clearFilter}
              >
                <Text className='text-[#2B9846] font-medium'>Clear Filter</Text>
              </TouchableOpacity>
              <TouchableOpacity className='flex-1 justify-center items-center bg-[#2B9846] rounded-lg'>
                <Text className=' text-white'>Apply</Text>
              </TouchableOpacity>
            </View>
          </View>
        </View>
      </Modal>

      <Modal
        isVisible={isModalVisible}
        onBackdropPress={toggleModal}
        // propagateSwipe={true}
        animationType='slide'
        style={{ margin: 0, justifyContent: 'flex-end' }}
      >
        <View className=' bg-white rounded-t-3xl p-6'>
          <View className='flex-1'>
            {/* <ScrollView className='flex-1'> */}
            <ScrollView>
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
                          ? 'border-2 border-[#2B9846]  bg-[#2B984613]'
                          : 'bg-gray-200'
                      }`}
                      onPress={() => setSelectedDays(item)}
                    >
                      <Text
                        className={`${
                          selectedDays === item
                            ? 'text-[#2B9846]'
                            : 'text-gray-700'
                        }`}
                      >
                        {item}
                      </Text>
                    </TouchableOpacity>
                  ))}
                </ScrollView>
              </View>

              <View className='mb-4'>
                <Text className='text-sm font-medium mb-2'>Crop Name</Text>
                <View className='flex flex-row items-center border border-gray-300 rounded-md mb-2'>
                  <Image source={images.find} style={tw`w-6 h-6 m-2`} />
                  <TextInput className='p-2' placeholder='Search Crop' />
                </View>

                <View className='flex-row flex-wrap'>
                  {['Wheat', 'Bajra', 'Sugarcane', 'Chana'].map((crop) => (
                    <TouchableOpacity
                      key={crop}
                      className={`px-4 py-2 rounded-full mr-2 mb-2 ${
                        selectedCrops.includes(crop)
                          ? 'border-2 border-[#2B9846] bg-[#2B984613]'
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
                      <Text
                        className={`${
                          selectedCrops.includes(crop)
                            ? 'text-[#2B9846]'
                            : 'text-gray-700'
                        }`}
                      >
                        {crop}
                      </Text>
                    </TouchableOpacity>
                  ))}
                </View>
              </View>

              <View className='mb-4'>
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
                            ? 'border-2 border-[#2B9846] bg-[#2B984613]'
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
                        <Text
                          className={`${
                            selectedFarmers.includes(farmer)
                              ? 'text-gray-700'
                              : 'text-gray-700'
                          }`}
                        >
                          {farmer}
                        </Text>
                      </TouchableOpacity>
                    )
                  )}
                </View>
              </View>

              <View className='flex-row space-x-3 mt-4'>
                <TouchableOpacity
                  className='flex-1 bg-gray-200 py-3 rounded-md items-center'
                  onPress={clearFilter}
                >
                  <Text className='text-gray-700 font-medium'>
                    Clear Filter
                  </Text>
                </TouchableOpacity>
                <TouchableOpacity
                  className='flex-1 bg-green-600 py-3 rounded-md items-center'
                  onPress={toggleModal}
                >
                  <Text className='text-white font-medium'>Apply</Text>
                </TouchableOpacity>
              </View>
            </ScrollView>
          </View>
        </View>
      </Modal>
    </SafeAreaView>
  );
};

export default ProcurementsScreen;
