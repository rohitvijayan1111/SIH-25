import React from "react";
import { View, Text, TouchableOpacity, StyleSheet, Dimensions } from "react-native";
import { Ionicons } from "@expo/vector-icons";

const { width } = Dimensions.get("window");

export default function QRScannerScreen() {
  return (
    <View style={styles.container}>
      {/* Top Bar */}
      <View style={styles.topBar}>
        <TouchableOpacity>
          <Ionicons name="arrow-back" size={24} color="#fff" />
        </TouchableOpacity>
        <Text style={styles.topTitle}>Scan QR Code</Text>
        <TouchableOpacity>
          <Ionicons name="help-circle-outline" size={22} color="#00FF7F" />
        </TouchableOpacity>
      </View>

      {/* QR Scanner Frame */}
      <View style={styles.scannerContainer}>
        <View style={styles.scannerFrame}>
          {/* Corner Borders */}
          <View style={[styles.corner, styles.topLeft]} />
          <View style={[styles.corner, styles.topRight]} />
          <View style={[styles.corner, styles.bottomLeft]} />
          <View style={[styles.corner, styles.bottomRight]} />
        </View>
      </View>

      {/* Instruction Box */}
      <View style={styles.instructionBox}>
        <Text style={styles.instructionTitle}>Position QR code within the frame</Text>
        <Text style={styles.instructionSubtitle}>
          Ensure good lighting for best results
        </Text>
      </View>

      {/* Enter Code Manually */}
      <TouchableOpacity style={styles.manualBtn}>
        <Text style={styles.manualBtnText}>Enter Code Manually</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#0D1117", // dark background
    padding: 16,
    justifyContent: "space-between",
  },
  topBar: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginTop: 20,
  },
  topTitle: {
    color: "#fff",
    fontSize: 16,
    fontWeight: "600",
  },
  scannerContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  scannerFrame: {
    width: width * 0.7,
    height: width * 0.7,
    position: "relative",
    justifyContent: "center",
    alignItems: "center",
  },
  corner: {
    position: "absolute",
    width: 30,
    height: 30,
    borderColor: "#00FF7F",
  },
  topLeft: {
    top: 0,
    left: 0,
    borderLeftWidth: 3,
    borderTopWidth: 3,
  },
  topRight: {
    top: 0,
    right: 0,
    borderRightWidth: 3,
    borderTopWidth: 3,
  },
  bottomLeft: {
    bottom: 0,
    left: 0,
    borderLeftWidth: 3,
    borderBottomWidth: 3,
  },
  bottomRight: {
    bottom: 0,
    right: 0,
    borderRightWidth: 3,
    borderBottomWidth: 3,
  },
  instructionBox: {
    alignItems: "center",
    marginBottom: 20,
  },
  instructionTitle: {
    color: "#fff",
    fontSize: 14,
    fontWeight: "600",
    marginBottom: 4,
  },
  instructionSubtitle: {
    color: "#bbb",
    fontSize: 12,
  },
  manualBtn: {
    backgroundColor: "transparent",
    borderWidth: 1,
    borderColor: "#00FF7F",
    borderRadius: 6,
    paddingVertical: 14,
    alignItems: "center",
    marginBottom: 40,
  },
  manualBtnText: {
    color: "#00FF7F",
    fontWeight: "600",
    fontSize: 14,
  },
});
