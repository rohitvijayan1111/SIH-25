import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  // API URLs
  static const String SERVER_URL_BAP = "http://127.0.0.1:5000";
  static const String SERVER_URL_BPP = "http://localhost:3000";
  static const String SERVER_URL_BPP_N = "http://127.0.0.1:2000";
}

// Global user state
String? globalUserId;
Map<String, Map<String, List<int>>> gcart = {};

String? globalUsername;
String? globalEmail;
int? globaltheme = 1;

// 🛒 Global Cart (in-memory)
List<Map<String, dynamic>> globalCart = [];

/// Add a product to the global cart and persist it
Future<void> addToGlobalCart(Map<String, dynamic> product) async {
  globalCart.add(product);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('cart', jsonEncode(globalCart));
}

Future<void> clearGlobalCart() async {
  globalCart.clear();
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('cart');
}
