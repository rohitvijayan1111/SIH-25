// global.dart
class Globals {
  // API URLs
  static const String SERVER_URL_BAP = "http://127.0.0.1:5000";
  static const String SERVER_URL_BPP = "http://127.0.0.1:3000";
  static const String SERVER_URL_BPP_N = "http://127.0.0.1:2000";
}

// Global user state
String? globalUserId;
String? globalUsername;
String? globalEmail;
int? globaltheme = 1;

// 🛒 Global Cart (Local in-memory store for now)
List<Map<String, dynamic>> globalCart = [];

/// Add a product to the global cart.
/// product should be a Map like:
/// {
///   "provider_name": "Farmer A",
///   "provider_address": "Village 1",
///   "items": [{"id": "1", "name": "Tomato", "qty": 1}]
/// }
void addToGlobalCart(Map<String, dynamic> product) {
  globalCart.add(product);
}

/// Clear the global cart
void clearGlobalCart() {
  globalCart.clear();
}
