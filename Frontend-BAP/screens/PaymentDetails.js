import { View, Text ,SafeAreaView,ScrollView} from 'react-native'
import React from 'react'
import tw from 'tailwind-react-native-classnames';

const PaymentDetails = () => {
  return (
    <SafeAreaView style={tw`flex-1 bg-white`}>
      <ScrollView>
        <View style={tw`bg-white p-4 rounded-lg border-gray-300 border-2 m-2`}>
          <View style={tw`flex-row justify-between`}>
            <Text>Total Amount</Text>
            <Text>₹20000</Text>
          </View>
          <View style={tw`flex-row justify-between`}>
            <Text>Paid Amount</Text>
            <Text>₹10000</Text>
          </View>
          <View style={tw`flex-row justify-between`}>
            <Text>Due Amount</Text>
            <Text>₹10000</Text>
          </View>
        </View>
        <View>
          <Text>Transaction</Text>
        </View>
        <View>
          <Text>Payment Details</Text>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

export default PaymentDetails