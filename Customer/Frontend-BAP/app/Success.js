import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Image,
  SafeAreaView,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons'; // expo install @expo/vector-icons
import { useNavigation } from '@react-navigation/native'; // 👈 added
import { useRouter } from 'expo-router';
export default function SuccessScreen() {
  const navigation = useNavigation(); // 👈 added
const router =useRouter();
  return (
    <SafeAreaView style={styles.container}>
      {/* ---------------- Mock Status Bar (Time + Icons) ---------------- */}
      <View style={styles.statusBar}>
        <Text style={styles.time}>9:12</Text>
        <View style={styles.icons}>
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

      {/* ---------------- Main Content ---------------- */}
      <View style={styles.content}>
        {/* Title */}
        <Text style={styles.title}>Success!</Text>

        {/* Check Icon */}
        <View style={styles.iconCircle}>
          <Ionicons name='checkmark' size={60} color='#77C043' />
        </View>

        {/* Subtitle */}
        <Text style={styles.subtitle}>
          <Text style={styles.bold}>Thank you for shopping{'\n'}</Text>
          <Text style={styles.text}>
            Your items has been placed and is{'\n'}on its way to being processed
          </Text>
        </Text>

        {/* Buttons */}
        <TouchableOpacity style={styles.trackButton}>
          <Text style={styles.trackText}>Track Order</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.shopButton}
          // onPress={() => navigation.navigate("ShoppingCart")}
          onPress={() => router.push('BrowsePage')}
          // 👈 navigate back
        >
          <Text style={styles.shopText}>Back to Shop</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#fff' },
  statusBar: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: 10,
    paddingTop: 5,
    paddingBottom: 10,
  },
  time: { fontSize: 16, fontWeight: '500' },
  icons: { flexDirection: 'row', alignItems: 'center' },
  icon: { width: 20, height: 20, marginLeft: 6, tintColor: '#000' },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 20,
  },
  title: { fontSize: 32, fontWeight: 'bold', marginBottom: 20, color: '#000' },
  iconCircle: {
    width: 120,
    height: 120,
    borderRadius: 60,
    borderWidth: 3,
    borderColor: '#77C043',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 25,
  },
  subtitle: { textAlign: 'center', marginBottom: 40 },
  bold: { fontWeight: 'bold', fontSize: 18 },
  text: { fontSize: 15, color: '#333' },
  trackButton: {
    backgroundColor: '#77C043',
    paddingVertical: 14,
    paddingHorizontal: 50,
    borderRadius: 8,
    marginBottom: 15,
  },
  trackText: { color: '#fff', fontSize: 16, fontWeight: '600' },
  shopButton: {
    borderWidth: 1,
    borderColor: '#77C043',
    paddingVertical: 12,
    paddingHorizontal: 50,
    borderRadius: 8,
  },
  shopText: { color: '#000', fontSize: 16, fontWeight: '500' },
});
