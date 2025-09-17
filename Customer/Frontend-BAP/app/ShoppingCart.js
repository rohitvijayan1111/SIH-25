import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Image,
  TextInput,
  ScrollView,
} from 'react-native';
import { useNavigation } from '@react-navigation/native'; // 👈 added
import { useRouter } from 'expo-router';

/* Reusable Mock Status Bar (use this on every screen) */
function MockStatusBar() {
  return (
    <View style={styles.mockStatusBar}>
      <Text style={styles.mockTime}>9:12</Text>

      <View style={styles.mockIcons}>
        <Image
          source={{
            uri: 'https://img.icons8.com/ios-filled/50/000000/cellular-network.png',
          }}
          style={styles.icon}
        />
        <Image
          source={{
            uri: 'https://img.icons8.com/ios-filled/50/000000/wifi.png',
          }}
          style={styles.icon}
        />
        <Image
          source={{
            uri: 'https://img.icons8.com/ios-filled/50/000000/full-battery.png',
          }}
          style={styles.icon}
        />
      </View>
    </View>
  );
}

export default function ShoppingCartScreen() {
  const navigation = useNavigation(); // 👈 added
  const router = useRouter();
  return (
    <View style={styles.container}>
      {/* ---------- consistent mock status bar ---------- */}
      <MockStatusBar />

      {/* ---------- main content ---------- */}
      <ScrollView contentContainerStyle={styles.scrollContent}>
        {/* Header */}
        <View style={styles.header}>
          <TouchableOpacity
            onPress={() => {
              router.back();
            }}
          >
            <Text style={styles.close}>×</Text>
          </TouchableOpacity>

          <Text style={styles.title}>Shopping Cart</Text>
          <Text style={styles.edit}>Edit</Text>
        </View>

        {/* Cart Items */}
        {[
          {
            name: 'Mustard Greens',
            category: 'Vegetables',
            price: '₹59',
            // image: require("../assets/Shopping Cart/Mustard_greens.png")
            image: require('../assets/images/mustardseeds.jpeg'),
          },
          {
            name: 'Organic Carrots',
            category: 'Vegetables',
            price: '₹60',
            image: require('../assets/images/carrot.jpg'),
          },
          {
            name: 'Organic Apple',
            category: 'Fruits',
            price: '₹120',
            image: require('../assets/images/apple.jpg'),
          },
        ].map((item, index) => (
          <View key={index} style={styles.cartItem}>
            <Image source={item.image} style={styles.itemImage} />

            <View style={styles.itemDetails}>
              <Text style={styles.category}>{item.category}</Text>
              <Text style={styles.itemName}>{item.name}</Text>
              <Text style={styles.qty}>Qty: 1</Text>
            </View>

            <View style={styles.rightColumn}>
              <Text style={styles.price}>{item.price}</Text>
              <View style={styles.qtyControls}>
                <TouchableOpacity style={styles.qtyBtn}>
                  <Text>-</Text>
                </TouchableOpacity>
                <Text style={styles.qtyValue}>1</Text>
                <TouchableOpacity style={styles.qtyBtn}>
                  <Text>+</Text>
                </TouchableOpacity>
              </View>
            </View>
          </View>
        ))}

        {/* Coupon */}
        <TextInput style={styles.couponInput} placeholder='Your code' />

        {/* Pickup / Delivery toggle */}
        <View style={styles.deliveryOptions}>
          <TouchableOpacity style={styles.optionBtn}>
            <Text>Pickup</Text>
          </TouchableOpacity>

          <TouchableOpacity style={[styles.optionBtn, styles.selectedBtn]}>
            <Text style={styles.selectedText}>Delivery ✓</Text>
          </TouchableOpacity>
        </View>

        {/* Price details */}
        <View style={styles.priceDetails}>
          <Text style={styles.feeText}>Delivery Fee</Text>
          <Text style={styles.feeText}>₹25</Text>
        </View>

        <View style={styles.priceDetails}>
          <View>
            <Text style={styles.totalLabel}>Total Price</Text>
            <Text style={styles.subText}>3 items</Text>
          </View>
          <View style={{ alignItems: 'flex-end' }}>
            <Text style={styles.totalPrice}>₹264</Text>
            <Text style={styles.subText}>Include taxes</Text>
          </View>
        </View>
      </ScrollView>

      {/* Checkout pinned at bottom */}
      <TouchableOpacity
        style={styles.checkoutBtn}
        // onPress={() => navigation.navigate('Checkout')} // 👈 changed
        onPress={() => router.push('/chkout')}
      >
        <Text style={styles.checkoutText}>Checkout</Text>
      </TouchableOpacity>
    </View>
  );
}
const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#fff' },

  /* -------- Mock status bar (same across screens) -------- */
  mockStatusBar: {
    height: 36,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 14,
    paddingTop: 6,
    borderBottomWidth: 0.5,
    borderBottomColor: '#e8e8e8',
    backgroundColor: '#fff',
  },
  mockTime: { fontSize: 13, color: '#111' },
  mockIcons: { flexDirection: 'row', alignItems: 'center' },
  icon: {
    width: 16,
    height: 16,
    marginLeft: 8,
    resizeMode: 'contain',
  },

  /* ---------- main scroll content ---------- */
  scrollContent: {
    paddingHorizontal: 18,
    paddingTop: 22,
    paddingBottom: 140,
  },

  /* header */
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 18,
  },
  close: { fontSize: 24, width: 30 },
  title: { fontSize: 20, fontWeight: '700' },
  edit: { color: 'gray', width: 40, textAlign: 'right' },

  /* cart item */
  cartItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 18,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
    paddingBottom: 14,
  },
  itemImage: {
    width: 92,
    height: 92,
    borderRadius: 8,
    marginRight: 14,
    backgroundColor: '#f6f6f6',
  },
  itemDetails: { flex: 1 },
  category: { color: 'green', fontSize: 12 },
  itemName: { fontSize: 16, fontWeight: '600', marginTop: 4 },
  qty: { fontSize: 12, color: '#666', marginTop: 6 },

  rightColumn: {
    alignItems: 'flex-end',
    marginLeft: 8,
  },
  price: { fontWeight: '700', fontSize: 15, marginBottom: 8 },
  qtyControls: {
    flexDirection: 'row',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: '#e0e0e0',
    borderRadius: 6,
    paddingVertical: 4,
    paddingHorizontal: 6,
  },
  qtyBtn: {
    paddingHorizontal: 8,
    paddingVertical: 2,
  },
  qtyValue: { marginHorizontal: 8, minWidth: 18, textAlign: 'center' },

  /* coupon */
  couponInput: {
    borderWidth: 1,
    borderColor: '#e0e0e0',
    borderRadius: 8,
    padding: 12,
    fontSize: 14,
    marginVertical: 18,
  },

  /* delivery toggle */
  deliveryOptions: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 18,
  },
  optionBtn: {
    flex: 1,
    borderWidth: 1,
    borderColor: '#dcdcdc',
    borderRadius: 8,
    paddingVertical: 12,
    marginHorizontal: 6,
    alignItems: 'center',
  },
  selectedBtn: { backgroundColor: '#0b7a12', borderColor: '#0b7a12' },
  selectedText: { color: '#fff', fontWeight: '700' },

  /* price details */
  priceDetails: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
    paddingHorizontal: 4,
  },
  feeText: { fontSize: 14, color: '#222' },
  totalLabel: { fontSize: 16, fontWeight: '700' },
  totalPrice: { fontSize: 18, fontWeight: '800' },
  subText: { fontSize: 12, color: '#888' },

  /* checkout button pinned bottom */
  checkoutBtn: {
    backgroundColor: '#8bc34a',
    paddingVertical: 16,
    paddingHorizontal: 20,
    borderRadius: 10,
    marginHorizontal: 18,
    marginBottom: 16,
  },
  checkoutText: {
    color: '#fff',
    fontWeight: '700',
    textAlign: 'center',
    fontSize: 16,
  },
});
