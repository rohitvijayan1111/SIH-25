import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Dimensions,
} from "react-native";
import { Ionicons } from "@expo/vector-icons";

const { width } = Dimensions.get("window");

export default function UploadHarvest() {
  const [product, setProduct] = useState("");
  const [quantity, setQuantity] = useState("");
  const [price, setPrice] = useState("");
  const [harvestDate, setHarvestDate] = useState("");
  const [quality, setQuality] = useState("Organic");

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity>
          <Ionicons name="arrow-back" size={24} color="#fff" />
        </TouchableOpacity>
        <Text style={styles.headerTitle}>Upload Harvest</Text>
      </View>

      {/* Product Details */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Product Details</Text>

        <TextInput
          style={styles.input}
          placeholder="Product Name"
          value={product}
          onChangeText={setProduct}
        />

        <View style={styles.row}>
          <TextInput
            style={[styles.input, { flex: 1, marginRight: 8 }]}
            placeholder="Quantity (kg/tonnes)"
            keyboardType="numeric"
            value={quantity}
            onChangeText={setQuantity}
          />
          <TextInput




            style={[styles.input, { flex: 1 }]}
            placeholder="Price per kg (₹)"
            keyboardType="numeric"
            value={price}
            onChangeText={setPrice}
          />
        </View>

        <TextInput
          style={styles.input}
          placeholder="Harvest Date (mm/dd/yyyy)"
          value={harvestDate}
          onChangeText={setHarvestDate}
        />

        {/* Quality Grade */}
        <View style={styles.qualityContainer}>
          {["Organic", "Grade A", "Standard"].map((q) => (
            <TouchableOpacity
              key={q}
              style={[
                styles.qualityButton,
                quality === q && styles.qualityButtonActive,
              ]}
              onPress={() => setQuality(q)}
            >
              <Text
                style={[
                  styles.qualityText,
                  quality === q && styles.qualityTextActive,
                ]}
              >
                {q}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {/* Photos & Location */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Photos & Location</Text>

        <View style={styles.photoBox}>
          <Text style={styles.photoText}>Add Photos of Your Produce</Text>
          <View style={styles.row}>
            <TouchableOpacity style={styles.cameraBtn}>
              <Ionicons name="camera" size={18} color="#fff" />
              <Text style={styles.btnText}>Camera</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.galleryBtn}>
              <Ionicons name="images" size={18} color="#fff" />
              <Text style={styles.btnText}>Gallery</Text>
            </TouchableOpacity>
          </View>
        </View>

        <TouchableOpacity style={styles.locationBox}>
          <Ionicons name="location" size={18} color="#4CAF50" />
          <Text style={styles.locationText}>
            Auto-detected Location (Tap to change)
          </Text>
          <Text style={styles.editText}>Edit</Text>
        </TouchableOpacity>
      </View>

      {/* Voice Input */}
      <TouchableOpacity style={styles.voiceBtn}>
        <Ionicons name="mic" size={18} color="#007BFF" />
        <Text style={styles.voiceText}>Voice Input Available</Text>
      </TouchableOpacity>

      {/* Blockchain Info */}
      <View style={styles.blockchainBox}>
        <Ionicons name="shield-checkmark" size={18} color="#9C27B0" />
        <Text style={styles.blockchainText}>
          Your harvest will be recorded on blockchain – transparent, secure, and
          tamper-proof.
        </Text>
      </View>

      {/* Buttons */}
      <TouchableOpacity style={styles.submitBtn}>
        <Text style={styles.submitText}>Submit Harvest</Text>
      </TouchableOpacity>

      <TouchableOpacity style={styles.draftBtn}>
        <Text style={styles.draftText}>Save as Draft</Text>
      </TouchableOpacity>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#F9FAFB",
    padding: 16,
  },
  header: {
    flexDirection: "row",
    alignItems: "center",
    backgroundColor: "#4CAF50",
    padding: 16,
    borderRadius: 8,
    marginBottom: 16,
  },
  headerTitle: {
    color: "#fff",
    fontSize: 18,
    fontWeight: "600",
    marginLeft: 10,
  },
  section: {
    backgroundColor: "#fff",
    borderRadius: 8,
    padding: 16,
    marginBottom: 16,
    shadowColor: "#000",
    shadowOpacity: 0.05,
    shadowOffset: { width: 0, height: 2 },
    shadowRadius: 4,
    elevation: 2,
  },
  sectionTitle: {
    fontSize: 14,
    fontWeight: "600",
    marginBottom: 10,
    color: "#333",
  },
  input: {
    borderWidth: 1,
    borderColor: "#E0E0E0",
    borderRadius: 6,
    padding: 10,
    marginBottom: 12,
    backgroundColor: "#FDFDFD",
  },
  row: {
    flexDirection: "row",
    alignItems: "center",
  },
  qualityContainer: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
  qualityButton: {
    flex: 1,
    borderWidth: 1,
    borderColor: "#E0E0E0",
    padding: 10,
    marginHorizontal: 4,
    borderRadius: 6,
    alignItems: "center",
  },
  qualityButtonActive: {
    backgroundColor: "#E8F5E9",
    borderColor: "#4CAF50",
  },
  qualityText: {
    fontSize: 13,
    color: "#555",
  },
  qualityTextActive: {
    color: "#4CAF50",
    fontWeight: "600",
  },
  photoBox: {
    borderWidth: 1,
    borderColor: "#E0E0E0",
    borderRadius: 6,
    padding: 12,
    alignItems: "center",
    marginBottom: 12,
  },
  photoText: {
    marginBottom: 10,
    color: "#666",
  },
  cameraBtn: {
    backgroundColor: "#4CAF50",
    flexDirection: "row",
    alignItems: "center",
    padding: 10,
    borderRadius: 6,
    marginRight: 8,
  },
  galleryBtn: {
    backgroundColor: "#607D8B",
    flexDirection: "row",
    alignItems: "center",
    padding: 10,
    borderRadius: 6,
  },
  btnText: {
    color: "#fff",
    marginLeft: 5,
    fontSize: 13,
  },
  locationBox: {
    flexDirection: "row",
    alignItems: "center",
    borderWidth: 1,
    borderColor: "#E0E0E0",
    borderRadius: 6,
    padding: 12,
    justifyContent: "space-between",
  },
  locationText: {
    flex: 1,
    marginLeft: 6,
    color: "#333",
  },
  editText: {
    color: "#4CAF50",
    fontWeight: "600",
  },
  voiceBtn: {
    flexDirection: "row",
    alignItems: "center",
    borderWidth: 1,
    borderColor: "#007BFF",
    borderRadius: 6,
    padding: 12,
    marginBottom: 16,
  },
  voiceText: {
    marginLeft: 8,
    color: "#007BFF",
    fontWeight: "600",
  },
  blockchainBox: {
    flexDirection: "row",
    alignItems: "center",
    backgroundColor: "#F3E5F5",
    borderRadius: 6,
    padding: 12,
    marginBottom: 16,
  },
  blockchainText: {
    marginLeft: 8,
    color: "#6A1B9A",
    fontSize: 13,
    flex: 1,
  },
  submitBtn: {
    backgroundColor: "#4CAF50",
    padding: 14,
    borderRadius: 6,
    alignItems: "center",
    marginBottom: 10,
  },
  submitText: {
    color: "#fff",
    fontWeight: "600",
    fontSize: 15,
  },
  draftBtn: {
    borderWidth: 1,
    borderColor: "#9E9E9E",
    padding: 14,
    borderRadius: 6,
    alignItems: "center",
    marginBottom: 30,
  },
  draftText: {
    color: "#555",
    fontWeight: "600",
  },
});
