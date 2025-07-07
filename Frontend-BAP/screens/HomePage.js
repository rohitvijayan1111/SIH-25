import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  FlatList,
  ActivityIndicator,
  ScrollView,
  TextInput
} from 'react-native';
import { TouchableOpacity, Image } from 'react-native';
import tw from 'tailwind-react-native-classnames';
import CategorySection from '../components/CategorySection';



const categoryList = [
  { id: 'seed', name: 'Seeds' },
  { id: 'micro', name: 'Micro Nutrient' },
  { id: 'fertilizer', name: 'Fertilizer' },
  { id: 'fungicide', name: 'Fungicide' },
  { id: 'growth-promoter', name: 'Growth Promoter' },
  { id: 'growth-regulators', name: 'Growth Regulators' },
  { id: 'herbicide', name: 'Herbicide' },
  { id: 'land', name: 'Land Lease & Sale' },
];


const HomePage = ({navigation}) => {
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');

  useEffect(() => {
    loadInitialCategories();
  }, []);

  const loadInitialCategories = async () => {
    setLoading(true);
    Promise.all([fetchCategoryProducts('crop'), fetchCategoryProducts('dairy')])
      .then((results) => setCategories(results))
      .finally(() => setLoading(false));
  };

  const fetchCategoryProducts = async (category) => {
    try {
      const response = await fetch('http://localhost:5000/bap/search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          productName: '',
          category: category,
          lat: '13.0827',
          lon: '80.2707',
          radius: 300,
        }),
      });

      const json = await response.json();
      const catalog = json.catalog?.message?.catalog;

      return {
        category: category.toUpperCase(),
        items: catalog?.items || [],
        providers: catalog?.providers || [],
      };
    } catch (error) {
      console.error(`Error fetching ${category} products:`, error);
      return {
        category: category.toUpperCase(),
        items: [],
        providers: [],
      };
    }
  };

  const searchProductsByName = async (name) => {
    if (!name.trim()) {
      loadInitialCategories(); // Fallback to initial data
      return;
    }

    setLoading(true);

    try {
      const response = await fetch('http://192.168.199.249:5000/bap/search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          productName: name,
          category: '',
          lat: '13.0827',
          lon: '80.2707',
          radius: 300,
        }),
      });

      const json = await response.json();
      const catalog = json.catalog?.message?.catalog;

      setCategories([
        {
          category: `Results for "${name}"`,
          items: catalog?.items || [],
          providers: catalog?.providers || [],
        },
      ]);
    } catch (error) {
      console.error('Error searching product name:', error);
    } finally {
      setLoading(false);
    }
  };
  
  const handleCategoryPress = async (categoryID,categoryName) => {
  setLoading(true);

  try {
    const response = await fetch('http://localhost:5000/bap/search', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        productName: '',
        category: categoryID.toLowerCase(),
        lat: '13.0827',
        lon: '80.2707',
        radius: 300,
      }),
    });

    const json = await response.json();
    const catalog = json.catalog?.message?.catalog;

    setCategories([
      {
        category: categoryName,
        items: catalog?.items || [],
        providers: catalog?.providers || [],
      },
    ]);
  } catch (error) {
    console.error('Category fetch error:', error);
  } finally {
    setLoading(false);
  }
};
  

  if (loading) {
    return (
      <View style={tw`flex-1 justify-center items-center bg-gray-50`}>
        <ActivityIndicator size="large" color="#2E8B57" />
        <Text style={tw`mt-3 text-gray-600`}>Loading products...</Text>
      </View>
    );
  }

  return (
    <View style={tw`flex-1 bg-gray-50`}>
      {/* Search Bar */}
      <View style={tw`px-4 pt-4 pb-2 bg-white shadow-sm`}>
        <View style={tw`flex-row items-center`}>
          <TextInput
            placeholder="Search products..."
            placeholderTextColor="#9CA3AF"
            value={searchTerm}
            onChangeText={setSearchTerm}
            style={tw`flex-1 bg-gray-100 rounded-lg px-4 py-2 text-gray-800`}
          />
          <TouchableOpacity
            onPress={() => searchProductsByName(searchTerm)}
            style={tw`ml-2 bg-blue-500 px-4 py-2 rounded-lg shadow`}
          >
            <Text style={tw`text-white font-medium`}>Search</Text>
          </TouchableOpacity>
        </View>
      </View>
        
        {/*Category */}
        <View style={tw`mt-2`}>
  <FlatList
    data={categoryList}
    horizontal
    showsHorizontalScrollIndicator={false}
    keyExtractor={(item) => item.id}
    renderItem={({ item }) => (
      <TouchableOpacity
        onPress={() => handleCategoryPress(item.id,item.name)}
        style={tw`bg-green-200 px-4 py-2 rounded-full mx-1`}
      >
        <Text style={tw`text-green-800 font-medium text-sm`}>
          {item.name}
        </Text>
      </TouchableOpacity>
    )}
    contentContainerStyle={tw`px-2`}
  />
</View>


      {/* Content */}
      <ScrollView contentContainerStyle={tw`pb-8`}>
        {categories.map((section, index) => (
          <React.Fragment key={index}>
            <CategorySection
              category={section.category}
              items={section.items}
              providers={section.providers}
              navigation={navigation}
            />
            {index < categories.length - 1 && (
              <View style={tw`h-0.5 bg-gray-200 mx-4`} />
            )}
          </React.Fragment>
        ))}
      </ScrollView>
    </View>
  );

};

export default HomePage;