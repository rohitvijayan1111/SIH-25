import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  ScrollView,
  SafeAreaView,
  TouchableOpacity,
  StatusBar,
  Image,
  Alert,
  Dimensions,
} from 'react-native';
import { useLocalSearchParams, router } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { categoriesWithProducts } from '../../data/categoriesWithProducts';

const { width } = Dimensions.get('window');

export default function ProductDetails() {
  const { id } = useLocalSearchParams();
  const [product, setProduct] = useState(null);
  const [selectedUnit, setSelectedUnit] = useState('100g');
  const [quantity, setQuantity] = useState(2);
  const [loading, setLoading] = useState(true);

  // Units available
  const availableUnits = [
    { label: '100g', value: '100g', priceMultiplier: 0.5 },
    { label: '250g', value: '250g', priceMultiplier: 1.25 },
    { label: '500g', value: '500g', priceMultiplier: 2.5 },
    { label: '1kg', value: '1kg', priceMultiplier: 5 },
  ];

  useEffect(() => {
    loadProduct();
  }, [id]);

  const loadProduct = () => {
    try {
      // Get all products from categories
      let allProducts = [];
      categoriesWithProducts.forEach((category) => {
        if (category.products) {
          allProducts = [...allProducts, ...category.products];
        }
      });

      const foundProduct = allProducts.find(
        (p) => p.id.toString() === id.toString()
      );

      if (foundProduct) {
        setProduct(foundProduct);
      } else {
        Alert.alert('Error', 'Product not found');
        router.back();
      }
    } catch (error) {
      console.error('Error loading product:', error);
      Alert.alert('Error', 'Failed to load product');
    } finally {
      setLoading(false);
    }
  };

  const calculateCurrentPrice = () => {
    if (!product) return 0;

    const basePrice = parseFloat(product.price.replace('₹', ''));
    const unitConfig = availableUnits.find((u) => u.value === selectedUnit);
    const unitPrice = basePrice * (unitConfig?.priceMultiplier || 1);

    return unitPrice * quantity;
  };

  const handleAddToCart = () => {
    const totalPrice = calculateCurrentPrice();

    Alert.alert(
      'Added to Cart',
      `${product.name} (${quantity}x ${selectedUnit}) - ₹${totalPrice.toFixed(2)}`,
      [
        { text: 'Continue Shopping', style: 'cancel' },
        { text: 'View Cart', onPress: () => router.push('/cart') },
      ]
    );
  };

  if (loading) {
    return (
      <SafeAreaView
        style={{
          flex: 1,
          backgroundColor: 'white',
          justifyContent: 'center',
          alignItems: 'center',
        }}
      >
        <Text style={{ fontSize: 18 }}>Loading...</Text>
      </SafeAreaView>
    );
  }

  if (!product) {
    return (
      <SafeAreaView
        style={{
          flex: 1,
          backgroundColor: 'white',
          justifyContent: 'center',
          alignItems: 'center',
        }}
      >
        <Text style={{ fontSize: 18, color: '#ef4444' }}>
          Product not found
        </Text>
        <TouchableOpacity
          onPress={() => router.back()}
          style={{
            marginTop: 16,
            paddingHorizontal: 24,
            paddingVertical: 8,
            backgroundColor: '#22c55e',
            borderRadius: 8,
          }}
        >
          <Text style={{ color: 'white', fontWeight: '600' }}>Go Back</Text>
        </TouchableOpacity>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: 'white' }}>
      <StatusBar barStyle='dark-content' backgroundColor='white' />

      {/* Header */}
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
          paddingHorizontal: 16,
          paddingVertical: 12,
          backgroundColor: 'white',
        }}
      >
        <TouchableOpacity onPress={() => router.back()} style={{ padding: 8 }}>
          <Ionicons name='arrow-back' size={24} color='#000' />
        </TouchableOpacity>

        <Text style={{ fontSize: 18, fontWeight: '600' }}>Product Details</Text>

        <TouchableOpacity style={{ padding: 8 }}>
          <Ionicons name='ellipsis-horizontal' size={24} color='#000' />
        </TouchableOpacity>
      </View>

      <ScrollView style={{ flex: 1 }} showsVerticalScrollIndicator={false}>
        {/* Product Image Section */}
        <View
          style={{
            position: 'relative',
            backgroundColor: 'white',
            paddingBottom: 16,
          }}
        >
          {/* Main Product Image */}
          <View
            style={{
              justifyContent: 'center',
              alignItems: 'center',
              paddingVertical: 24,
            }}
          >
            <Image
              source={
                typeof product.image === 'string'
                  ? { uri: product.image }
                  : product.image
              }
              style={{
                width: width * 0.85,
                height: width * 0.65,
                borderRadius: 16,
              }}
              resizeMode='contain'
            />
          </View>

          {/* Trending Badge */}
          {product.discount > 15 && (
            <View
              style={{
                position: 'absolute',
                top: 32,
                left: 24,
                backgroundColor: '#22c55e',
                paddingHorizontal: 12,
                paddingVertical: 4,
                borderRadius: 20,
              }}
            >
              <Text style={{ color: 'white', fontSize: 12, fontWeight: '500' }}>
                Trending Now
              </Text>
            </View>
          )}

          {/* Image Count Indicator */}
          <View
            style={{
              position: 'absolute',
              bottom: 32,
              right: 24,
              backgroundColor: 'rgba(0,0,0,0.5)',
              paddingHorizontal: 12,
              paddingVertical: 4,
              borderRadius: 20,
            }}
          >
            <Text style={{ color: 'white', fontSize: 12 }}>1/3</Text>
          </View>
        </View>

        {/* Product Info Section */}
        <View style={{ paddingHorizontal: 16, paddingVertical: 16 }}>
          {/* Category and Organic Badge */}
          <View
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              marginBottom: 8,
            }}
          >
            <Text style={{ color: '#22c55e', fontWeight: '500' }}>
              {product.category}
            </Text>
            {product.isOrganic && (
              <View
                style={{
                  marginLeft: 8,
                  paddingHorizontal: 8,
                  paddingVertical: 4,
                  backgroundColor: '#dcfce7',
                  borderRadius: 20,
                }}
              >
                <Text
                  style={{ color: '#166534', fontSize: 12, fontWeight: '500' }}
                >
                  Organic
                </Text>
              </View>
            )}
          </View>

          {/* Product Name */}
          <Text
            style={{
              fontSize: 28,
              fontWeight: 'bold',
              color: '#111827',
              marginBottom: 8,
            }}
          >
            {product.name}
          </Text>

          {/* Price Section */}
          <View
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              marginBottom: 12,
            }}
          >
            <Text
              style={{
                fontSize: 28,
                fontWeight: 'bold',
                color: '#111827',
                marginRight: 8,
              }}
            >
              {product.price}
            </Text>
            <Text style={{ fontSize: 16, color: '#6b7280' }}>/200gr</Text>
            {product.originalPrice && (
              <>
                <Text
                  style={{
                    fontSize: 18,
                    color: '#6b7280',
                    textDecorationLine: 'line-through',
                    marginLeft: 8,
                    marginRight: 8,
                  }}
                >
                  {product.originalPrice}
                </Text>
                {product.discount > 0 && (
                  <View
                    style={{
                      paddingHorizontal: 8,
                      paddingVertical: 4,
                      backgroundColor: '#fee2e2',
                      borderRadius: 4,
                    }}
                  >
                    <Text
                      style={{
                        color: '#dc2626',
                        fontSize: 12,
                        fontWeight: '500',
                      }}
                    >
                      -{product.discount}%
                    </Text>
                  </View>
                )}
              </>
            )}
          </View>

          {/* Unit Selector */}
          <View style={{ marginTop: 24 }}>
            <Text style={{ fontSize: 18, fontWeight: '600', marginBottom: 12 }}>
              Unit
            </Text>

            <View style={{ flexDirection: 'row', flexWrap: 'wrap' }}>
              {availableUnits.map((unit) => (
                <TouchableOpacity
                  key={unit.value}
                  onPress={() => setSelectedUnit(unit.value)}
                  style={{
                    paddingHorizontal: 16,
                    paddingVertical: 8,
                    borderRadius: 8,
                    marginRight: 12,
                    marginBottom: 8,
                    borderWidth: 1,
                    backgroundColor:
                      selectedUnit === unit.value ? '#22c55e' : 'white',
                    borderColor:
                      selectedUnit === unit.value ? '#22c55e' : '#d1d5db',
                  }}
                >
                  <Text
                    style={{
                      fontWeight: '500',
                      color: selectedUnit === unit.value ? 'white' : '#374151',
                    }}
                  >
                    {unit.label}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>

          {/* Description */}
          <View style={{ marginTop: 24 }}>
            <Text style={{ fontSize: 18, fontWeight: '600', marginBottom: 8 }}>
              Description
            </Text>
            <Text style={{ color: '#6b7280', lineHeight: 24 }}>
              Endlessly versatile, broccoli has a cabbage-like flavor and a
              satisfying crunch. It's nutritious, low in calories and available
              year-round. An extremely popular vegetable, broccoli can be used
              in stir-fries, soups, casseroles or served.
            </Text>
          </View>

          {/* Quantity Selector */}
          <View style={{ marginTop: 24 }}>
            <View
              style={{
                flexDirection: 'row',
                alignItems: 'center',
                justifyContent: 'space-between',
              }}
            >
              <Text style={{ fontSize: 18, fontWeight: '600' }}>
                Product Quantity
              </Text>

              <View style={{ flexDirection: 'row', alignItems: 'center' }}>
                <TouchableOpacity
                  onPress={() => quantity > 1 && setQuantity(quantity - 1)}
                  style={{
                    width: 40,
                    height: 40,
                    borderRadius: 8,
                    borderWidth: 1,
                    borderColor: '#d1d5db',
                    justifyContent: 'center',
                    alignItems: 'center',
                  }}
                >
                  <Ionicons name='remove' size={20} color='#666' />
                </TouchableOpacity>

                <Text
                  style={{
                    marginHorizontal: 16,
                    fontSize: 18,
                    fontWeight: '600',
                    minWidth: 32,
                    textAlign: 'center',
                  }}
                >
                  {quantity}
                </Text>

                <TouchableOpacity
                  onPress={() => quantity < 10 && setQuantity(quantity + 1)}
                  style={{
                    width: 40,
                    height: 40,
                    borderRadius: 8,
                    borderWidth: 1,
                    borderColor: '#d1d5db',
                    justifyContent: 'center',
                    alignItems: 'center',
                  }}
                >
                  <Ionicons name='add' size={20} color='#666' />
                </TouchableOpacity>

                {/* Heart Icon */}
                <TouchableOpacity style={{ marginLeft: 16, padding: 8 }}>
                  <Ionicons name='heart-outline' size={24} color='#666' />
                </TouchableOpacity>
              </View>
            </View>
          </View>
        </View>
      </ScrollView>

      {/* Bottom Add to Cart */}
      <View
        style={{
          paddingHorizontal: 16,
          paddingVertical: 16,
          backgroundColor: 'white',
          borderTopWidth: 1,
          borderTopColor: '#e5e7eb',
        }}
      >
        <TouchableOpacity
          onPress={handleAddToCart}
          style={{
            backgroundColor: '#22c55e',
            paddingVertical: 16,
            paddingHorizontal: 24,
            borderRadius: 8,
            flexDirection: 'row',
            justifyContent: 'space-between',
            alignItems: 'center',
          }}
        >
          <Text style={{ color: 'white', fontSize: 18, fontWeight: '600' }}>
            Add to Cart
          </Text>
          <Text style={{ color: 'white', fontSize: 18, fontWeight: 'bold' }}>
            ₹{calculateCurrentPrice().toFixed(2)}
          </Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}
