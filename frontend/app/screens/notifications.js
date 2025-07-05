import { View, Text, FlatList } from "react-native";
import { useState } from "react";

const Notifications = () => {
  const [notificationdata, setNotification] = useState([]);

  return (
    <View>
      <Text>Notifications</Text>
      <FlatList
        data={notificationdata}
        renderItem={({ item }) => (
          <View>
            <Text>{item.title}</Text>
            <Text>{item.message}</Text>
          </View>
        )}
        keyExtractor={(item) => item.id}
      />
    </View>
  );
};

export default Notifications;
