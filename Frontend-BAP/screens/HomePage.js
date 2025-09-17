import React, { useEffect, useState } from 'react';
import { SERVER_URL } from '@env';
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
//changing


const categoryList = [
  { id: 'seed', name: 'Seeds' },
  { id: 'micro', name: 'Micro Nutrient' },
  { id: 'fertilizer', name: 'Fertilizer' },
  { id: 'fungicide', name: 'Fungicide' },
  { id: 'growth_promoter', name: 'Growth Promoter' },
  { id: 'growth_regulator', name: 'Growth Regulators' },
  { id: 'herbicide', name: 'Herbicide' },
  { id: 'land', name: 'Land Lease & Sale' },
];


const HomePage = ({navigation}) => {
  const mobile="http://10.98.198.249:5000";
  
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  
  console.log(SERVER_URL);
  useEffect(() => {
    loadInitialCategories();
  }, []);


  const loadInitialCategories = async () => {
    setLoading(true);
    Promise.all([fetchCategoryProducts("seed"), fetchCategoryProducts("FERTILIZER")])
      .then((results) => setCategories(results))
      .finally(() => setLoading(false));
  };

  

  const fetchCategoryProducts = async (category) => {
    try {
      
      const response = await fetch(`${mobile}/bap/search`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          productName: '',
          category: category,
          lat: '23.2599',
          lon: '79.0882',
          radius: 1000,
        }),
      });
     if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }  
    const json = await response.json();

    // Check response structure
    const catalog = json?.catalog?.message?.catalog;

    if (!catalog) {
      throw new Error('Invalid ONDC /on_search response format.');
    }
    // console.log(catalog);
    return {
      category: category.toUpperCase(),
      items: Array.isArray(catalog.items) ? catalog.items : [],
      providers: Array.isArray(catalog.providers) ? catalog.providers : [],
    };
  } catch (error) {
    console.error(`❌ Error fetching ${category} products:`, error.message);
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
      const response = await fetch(`${mobile}/bap/search`, {
        method: 'POST',
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          productName: name,
          category: "",
          lat: "23.2599",
          lon: "79.0882",
          radius: 1000,
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
      console.error("Error searching product name:", error);
    } finally {
      setLoading(false);
    }
  };
  
  const handleCategoryPress = async (categoryID, categoryName) => {
  setLoading(true);
  console.log("🔍 Fetching category:", categoryID);
  // console.log("categriy if",categoryID);
 
    try {
      const response = await fetch(`${mobile}/bap/search`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
       body: JSON.stringify({
  productName: '',
  category: categoryID.toLowerCase(), // ✅ Fixed casing
  lat: '23.2599',
  lon: '79.0882',
  radius: 1000,
})
,
      });

    // Validate HTTP response
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    const json = await response.json();

    // Validate response structure
    const catalog = json?.catalog?.message?.catalog;
    if (!catalog) {
      throw new Error('Invalid /on_search response format. Missing catalog.');
    }

    setCategories([
      {
        category: categoryName,
        items: Array.isArray(catalog.items) ? catalog.items : [],
        providers: Array.isArray(catalog.providers) ? catalog.providers : [],
      },
    ]);
  } catch (error) {
    console.error(`❌ Error fetching category "${categoryName}":`, error.message);
    // Optional: show a toast or alert to the user
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
     <View style={tw`px-4 pt-4 pb-2 bg-green-100 rounded-b-2xl shadow-md`}>
      <View style={tw`flex-row items-center`}>
        <TextInput
          placeholder="Search products..."
          placeholderTextColor="#6B7280" // Tailwind's text-gray-500
          value={searchTerm}
          onChangeText={setSearchTerm}
          style={tw`flex-1 bg-white rounded-full px-4 py-2 text-gray-800 shadow-sm`}
        />
        <TouchableOpacity
          onPress={() => searchProductsByName(searchTerm)}
          style={tw`ml-2 bg-green-500 px-4 py-2 rounded-full shadow-md`}
        >
          <Text style={tw`text-white font-semibold`}>Search</Text>
        </TouchableOpacity>
      </View>
    </View>
        
       {/* Category */}
<View style={tw`mt-4`}>
  <FlatList
    data={categoryList}
    horizontal
    showsHorizontalScrollIndicator={false}
    keyExtractor={(item) => item.id}
    renderItem={({ item }) => (
      <TouchableOpacity
        onPress={() => handleCategoryPress(item.id, item.name)}
        activeOpacity={0.7}
        style={tw`bg-green-200 px-5 py-2 rounded-full mx-1 shadow-sm`}
      >
        <Text style={tw`text-green-800 font-medium text-sm`}>
          {item.name}
        </Text>
      </TouchableOpacity>
    )}
    contentContainerStyle={tw`px-3`}
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
