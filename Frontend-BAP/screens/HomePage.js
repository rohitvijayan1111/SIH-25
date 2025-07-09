import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  ActivityIndicator,
  ScrollView,
  TextInput,
} from "react-native";
import { TouchableOpacity, Image } from "react-native";
import tw from "tailwind-react-native-classnames";
import CategorySection from "../components/CategorySection";
import { LinearGradient } from "expo-linear-gradient";
import { images } from "../constants/images";

// const categoryList = [
//   { id: "seed", name: "Seeds" },
//   { id: "micro", name: "Micro Nutrient" },
//   { id: "fertilizer", name: "Fertilizer" },
//   { id: "fungicide", name: "Fungicide" },
//   { id: "growth-promoter", name: "Growth Promoter" },
//   { id: "growth-regulators", name: "Growth Regulators" },
//   { id: "herbicide", name: "Herbicide" },
//   { id: "land", name: "Land Lease & Sale" },
// ];

const categoriesforgrid = [
  { id: "seed", name: "Seeds", icon: images.seeds },
  { id: "micro", name: "Micro Nutrients", icon: images.micronutrients },
  { id: "fertilizer", name: "Fertilizer", icon: images.fertilizer },
  { id: "fungicide", name: "Fungicide", icon: images.fungicide },
  {
    id: "growth-promoter",
    name: "Growth Promoter",
    icon: images.growthpromoter,
  },
  {
    id: "growth-regulators",
    name: "Growth Regulators",
    icon: images.growthregulator,
  },
  { id: "herbicide", name: "Herbicide", icon: images.herbicide },
  { id: "land", name: "Land Lease & Sale", icon: images.landlease },
];

const HomePage = ({ navigation }) => {
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");

  useEffect(() => {
    loadInitialCategories();
  }, []);

  const loadInitialCategories = async () => {
    setLoading(true);
    Promise.all([fetchCategoryProducts("crop"), fetchCategoryProducts("dairy")])
      .then((results) => setCategories(results))
      .finally(() => setLoading(false));
  };

  const fetchCategoryProducts = async (category) => {
    try {
      const response = await fetch("http://localhost:5000/bap/search", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          productName: "",
          category: category,
          lat: "13.0827",
          lon: "80.2707",
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
      const response = await fetch("http://192.168.199.249:5000/bap/search", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          productName: name,
          category: "",
          lat: "13.0827",
          lon: "80.2707",
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
      console.error("Error searching product name:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleCategoryPress = async (categoryID, categoryName) => {
    setLoading(true);

    try {
      const response = await fetch("http://localhost:5000/bap/search", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          productName: "",
          category: categoryID.toLowerCase(),
          lat: "13.0827",
          lon: "80.2707",
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
      console.error("Category fetch error:", error);
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
    <View style={tw`flex-1`}>
      <LinearGradient
        colors={["#B2FFB7", "#ffffff"]}
        style={tw`px-2 pt-4 pb-4 rounded-b-4xl shadow-md`}
      >
        <View style={tw`flex-row justify-between items-center mb-2`}>
          <Text style={tw`text-lg font-extrabold text-green-800`}>
            FarmNFresh
          </Text>
          <View style={tw`flex-row items-center space-x-2`}>
            <View style={tw`bg-white px-2 py-1 rounded-md`}>
              <Text style={tw`text-[#2B9846] font-semibold text-sm`}>
                ₹20000
              </Text>
            </View>
          </View>
        </View>

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
      </LinearGradient>
      {/*Ajith Search Bar*/}
      {/* <View style={tw`px-4 pt-4 pb-2 bg-white shadow-sm`}>
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
      </View> */}
      {/* My Category List */}
      <View style={tw`mt-2`}>
        <FlatList
          data={categoriesforgrid}
          numColumns={4}
          // showsHorizontalScrollIndicator={false}
          keyExtractor={(item) => item.id}
          renderItem={({ item }) => (
            <TouchableOpacity
              onPress={() => handleCategoryPress(item.id, item.name)}
              style={tw`flex-1 justify-center items-center p-3 m-1 bg-white rounded-xl shadow-md`}
            >
              <Image
                source={item.icon}
                className="w-8 h-8"
                resizeMode="contain"
              />
              <Text numberOfLines={1} className="text-center text-xs mt-2">
                {item.name}
              </Text>
            </TouchableOpacity>
          )}
          contentContainerStyle={tw`px-2`}
        />
      </View>

      {/* Ajith Category List
      <View style={tw`mt-2`}>
        <FlatList
          data={categoryList}
          horizontal
          showsHorizontalScrollIndicator={false}
          keyExtractor={(item) => item.id}
          renderItem={({ item }) => (
            <TouchableOpacity
              onPress={() => handleCategoryPress(item.id, item.name)}
              style={tw`bg-green-200 px-4 py-2 rounded-full mx-1`}
            >
              <Text style={tw`text-green-800 font-medium text-sm`}>
                {item.name}
              </Text>
            </TouchableOpacity>
          )}
          contentContainerStyle={tw`px-2`}
        />
      </View> */}

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
