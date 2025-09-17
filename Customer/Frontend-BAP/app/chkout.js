import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  SafeAreaView,
  ScrollView,
  Image,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons'; // expo install @expo/vector-icons
import { useNavigation } from '@react-navigation/native'; // 👈 added

export default function CheckoutScreen() {
  const navigation = useNavigation(); // 👈 added

  return (
    <SafeAreaView style={styles.container}>
      {/* ---------------- Checkout Content ---------------- */}
      <ScrollView contentContainerStyle={styles.scrollContent}>
        {/* Header */}
        <View style={styles.header}>
          <Ionicons name='chevron-back' size={24} color='#000' />
          <Text style={styles.headerTitle}>Checkout</Text>
          <View style={{ width: 24 }} />
        </View>

        {/* Delivery Date */}
        <TouchableOpacity style={styles.section}>
          <Text style={styles.label}>Delivery Date</Text>
          <View style={styles.row}>
            <View>
              <Text style={styles.bold}>Thursday, October 12</Text>
              <Text style={styles.subText}>10:00 AM</Text>
            </View>
            <Ionicons name='chevron-forward' size={20} color='#999' />
          </View>
        </TouchableOpacity>

        {/* Delivery Address */}
        <TouchableOpacity style={styles.section}>
          <Text style={styles.label}>Delivery Address</Text>
          <View style={styles.row}>
            <View>
              <Text style={styles.bold}>Home</Text>
              <Text style={styles.subText}>
                43 Bourke Street, Newbridge NSW 837 Raffles ...
              </Text>
            </View>
            <Ionicons name='chevron-forward' size={20} color='#999' />
          </View>
        </TouchableOpacity>

        {/* Payment */}
        <TouchableOpacity style={styles.section}>
          <Text style={styles.label}>Payment</Text>
          <View style={styles.row}>
            <Image
              source={{
                uri: 'https://img.icons8.com/ios-filled/50/apple-pay.png',
              }}
              style={{ width: 40, height: 25, resizeMode: 'contain' }}
            />
            <Text style={styles.bold}>Apple Pay</Text>
            <Ionicons
              name='chevron-forward'
              size={20}
              color='#999'
              style={{ marginLeft: 'auto' }}
            />
          </View>
        </TouchableOpacity>

        {/* Order Summary */}
        <View style={styles.section}>
          <Text style={styles.label}>Order</Text>
          <Text style={styles.bold}>Today</Text>
          <View style={styles.orderRow}>
            <Text>Mustard Greens x 1</Text>
            <Text>₹59</Text>
          </View>
          <View style={styles.orderRow}>
            <Text>Organic Carrots x 1</Text>
            <Text>₹60</Text>
          </View>
          <View style={styles.orderRow}>
            <Text>Organic Apple x 1</Text>
            <Text>₹120</Text>
          </View>
          <View style={styles.orderRow}>
            <Text>Delivery Fee</Text>
            <Text>₹25</Text>
          </View>
          <View style={styles.totalRow}>
            <Text style={styles.bold}>Total</Text>
            <Text style={styles.bold}>₹264</Text>
          </View>
        </View>

        {/* Coupon */}
        <View style={styles.couponBox}>
          <Text style={styles.couponText}>Code Redeemed</Text>
          <View style={styles.discountTag}>
            <Text style={styles.discountText}>20% Off</Text>
          </View>
        </View>

        {/* Confirm Button */}
        <TouchableOpacity
          style={styles.confirmButton}
          onPress={() => navigation.navigate('Success')} // 👈 navigate
        >
          <Text style={styles.confirmText}>Confirm Order</Text>
        </TouchableOpacity>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#fff' },
  statusBar: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: 10,
    paddingTop: 8,
    paddingBottom: 8,
    borderBottomWidth: 0.5,
    borderBottomColor: '#eee',
  },
  time: { fontSize: 16, fontWeight: '500' },
  icons: { flexDirection: 'row', alignItems: 'center' },
  icon: { width: 20, height: 20, marginLeft: 6, tintColor: '#000' },
  scrollContent: { padding: 15, flexGrow: 1, justifyContent: 'center' },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 15,
  },
  headerTitle: { fontSize: 24, fontWeight: 'bold' },
  section: {
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
    paddingVertical: 15,
  },
  label: { fontSize: 13, color: '#888', marginBottom: 5 },
  bold: { fontSize: 16, fontWeight: 'bold' },
  subText: { fontSize: 14, color: '#555' },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  orderRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginVertical: 3,
  },
  totalRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 8,
    borderTopWidth: 1,
    borderTopColor: '#eee',
    paddingTop: 8,
  },
  couponBox: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    padding: 12,
    marginTop: 20,
    alignItems: 'center',
  },
  couponText: { fontSize: 15, fontWeight: '500' },
  discountTag: {
    backgroundColor: '#800080',
    borderRadius: 6,
    paddingHorizontal: 10,
    paddingVertical: 4,
  },
  discountText: { color: '#fff', fontWeight: 'bold', fontSize: 14 },
  confirmButton: {
    backgroundColor: '#77C043',
    paddingVertical: 15,
    borderRadius: 8,
    alignItems: 'center',
    marginTop: 25,
    marginBottom: 30,
  },
  confirmText: { color: '#fff', fontSize: 18, fontWeight: '600' },
});
