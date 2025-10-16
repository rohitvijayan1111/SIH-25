import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:demo/screens/CustomerScreens/cart_screen.dart';
import 'package:demo/screens/CustomerScreens/models/cart_model.dart';

class CartService {
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  // Add item to cart API call
  static Future<Map<String, dynamic>> addToCart({
    required String userId,
    required String batchId,
    required String itemName,
    required int quantity,
    required double unitPrice,
    required String imageUrl,
    required String productId,
  }) async {
    final url = Uri.parse('http://localhost:5000/cart/add');
    final body = {
      'user_id': userId,
      'bpp_product_id':
          batchId, // sometimes batchId might be same as bppProductId, adjust as needed
      'item_name': itemName,
      'quantity': quantity,
      'unit_price': unitPrice,
      'image_url': imageUrl,
      'provider_id': productId,
    };

    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    print('Add to cart status: ${resp.statusCode}');
    print('Add to cart response: ${resp.body}');

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw Exception('Add to cart failed: ${resp.statusCode} ${resp.body}');
    }
  }

  // View cart
  static Future<Map<String, dynamic>> viewCart({required String userId}) async {
    final url = Uri.parse('http://localhost:5000/cart/view/$userId');
    final resp = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    print('Status code: ${resp.statusCode}');
    print('Response body: ${resp.body}');
    print('Decoded JSON: ${json.decode(resp.body)}');

    final data = json.decode(resp.body);
    if (resp.statusCode == 200) {
      if (data is Map<String, dynamic>) {
        return data; // return the whole response map
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('View cart failed: ${resp.statusCode}');
    }
  }

  // Delete item from cart
  static Future<void> deleteFromCart({
    required String userId,
    required String batchId,
  }) async {
    final url = Uri.parse('http://localhost:5000/cart/clear');
    final resp = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'user_id': userId, 'bpp_product_id': batchId}),
    );
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception(
        'Delete from cart failed: ${resp.statusCode} ${resp.body}',
      );
    }
  }
}
