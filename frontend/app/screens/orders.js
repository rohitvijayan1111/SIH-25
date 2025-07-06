import { View, Text, FlatList } from "react-native";
import React from "react";

const orders = ({ orders }) => {
  return (
    <View>
      <Text>orders </Text>

      <FlatList
        data={orders}
        renderItem={({ item }) => <Text>{item.name}</Text>}
      />
    </View>
  );
};

export default orders;
