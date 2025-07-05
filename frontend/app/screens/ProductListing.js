import React from "react";
import {
  View,
  Text,
  FlatList,
  ActivityIndicator,
  TouchableOpacity,
} from "react-native";
import axios from "axios";

// Custom hook for API calls
const useApi = (url, payload) => {
  const [data, setData] = React.useState(null);
  const [loading, setLoading] = React.useState(true);
  const [error, setError] = React.useState(null);

  const fetchData = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await axios.post(url, payload, {
        headers: {
          accept: "application/json",
          "Content-Type": "application/json",
        },
      });
      setData(response.data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  React.useEffect(() => {
    fetchData();
    // eslint-disable-next-line
  }, [url]);

  return { data, loading, error, refetch: fetchData };
};

export default function ProductsListComponent() {
  // API endpoint and payload
  const API_URL = "https://192.168.31.79:5000/bap/search";
  const payload = {
    productName: "",
    category: "",
    lat: 13.0524,
    lon: 80.2501,
    radius: 300,
  };

  const { data, loading, error, refetch } = useApi(API_URL, payload);

  // Extract products from API response
  const products = React.useMemo(() => {
    if (!data) return [];
    const catalog = data.catalog?.message?.catalog;
    if (catalog) {
      return catalog.items || [];
    }
    return [];
  }, [data]);

  if (loading) {
    return (
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
        <ActivityIndicator size="large" color="#00cc66" />
        <Text>Loading products...</Text>
      </View>
    );
  }

  if (error) {
    return (
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
        <Text style={{ color: "red" }}>Error: {error}</Text>
        <TouchableOpacity
          onPress={refetch}
          style={{
            marginTop: 16,
            padding: 8,
            backgroundColor: "#007bff",
            borderRadius: 4,
          }}
        >
          <Text style={{ color: "white" }}>Retry</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <View style={{ flex: 1, padding: 16 }}>
      <FlatList
        data={products}
        keyExtractor={(item) => item.id || Math.random().toString()}
        renderItem={({ item }) => (
          <Text style={{ fontSize: 18, marginBottom: 12 }}>
            {item.descriptor?.name || "Unnamed Product"}
          </Text>
        )}
      />
    </View>
  );
}
