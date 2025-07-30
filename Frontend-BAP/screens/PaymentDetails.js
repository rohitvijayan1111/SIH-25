import {
  View,
  Text,
  SafeAreaView,
  ScrollView,
  TouchableOpacity,
  Image,
  FlatList,
} from 'react-native';
import React from 'react';
import backArrow from '../assets/left-arrow.png';
import tw from 'tailwind-react-native-classnames';
import { useNavigation } from '@react-navigation/native';
import { data } from '../constants/data';
const PaymentDetails = () => {
  const paymentDetails = data.paymentDetails;

  const navigation = useNavigation();
  return (
    <SafeAreaView style={tw`flex-1 bg-white`}>
      {/* <Header title="Payment Details" page='Home' />
       */}
      <View
        style={tw`flex-row justify-start items-center p-1`}
        className='bg-[#B2FFB7]'
      >
        <TouchableOpacity onPress={() => navigation.navigate('Procurements')}>
          <Image source={backArrow} style={tw`w-6 h-6 p-1`} />
        </TouchableOpacity>
        <Text style={tw`text-xl font-semibold p-2`}>Payment Details</Text>
      </View>
      <ScrollView>
        <View style={tw`bg-white p-4 rounded-lg border-gray-300 border-2 m-2`}>
          <View style={tw`flex-row justify-between`}>
            <Text>Total Amount</Text>
            <Text>₹{paymentDetails.totalAmount}</Text>
          </View>
          <View style={tw`flex-row justify-between`}>
            <Text>Paid Amount</Text>
            <Text>₹{paymentDetails.paidAmount}</Text>
          </View>
          <View style={tw`flex-row justify-between`}>
            <Text>Due Amount</Text>
            <Text>₹{paymentDetails.dueAmount}</Text>
          </View>
        </View>

        {/* <View>
          <Text>Payment Details</Text>
          <View>
            <View>
              <Text>

            </Text>
            <Text>

            </Text>
            </View>
            <Text>

            </Text>
          </View>

        </View> */}
        <View style={tw`bg-white p-4 rounded-lg border-gray-300 border-2 m-2`}>
          <View>
            <Text style={tw`font-bold text-xl`}>Transaction</Text>
          </View>
          <FlatList
            data={paymentDetails.transactions}
            keyExtractor={(_, index) => index.toString()}
            renderItem={({ item }) => (
              <View className='py-2 flex-row justify-between item-center border-b border-gray-600'>
                <View className='flex-column items-start'>
                  <Text className='text-base font-semibold'>
                    Pay By {item.method}
                  </Text>
                  <Text className='text-sm text-gray-600'>
                    {new Date(item.date).toLocaleDateString('en-GB', {
                      day: '2-digit',
                      month: 'short',
                      year: 'numeric',
                    })}
                    ,{' '}
                    {new Date(item.date).toLocaleTimeString([], {
                      hour: '2-digit',
                      minute: '2-digit',
                      hour12: true,
                    })}
                  </Text>
                </View>
                <Text className='text-base font-bold'>
                  ₹{item.amount.toFixed(2)}
                </Text>
              </View>
            )}
          />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

export default PaymentDetails;
