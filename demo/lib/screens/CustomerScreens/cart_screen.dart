import 'package:flutter/material.dart';

import '../../global.dart';
import 'checkout_screen.dart';
import 'models/product_model.dart';

import 'package:demo/services/cart_service.dart';
import 'models/cart_model.dart';

class CartScreen extends StatefulWidget {
  final int value;

  const CartScreen({super.key, this.value = 0, required String userId});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Map<String, String> backendToStaticIdMap = {
    "34799eb9-d699-4433-875b-a8bd4bc0a12a": "1",
    "cb8c866e-943b-4db5-8cec-99c720ad10e6": "2",
    "7b9de6e2-9993-4011-b2a7-be51837a2f8c": "3",
    "ffb25be8-34cb-4d27-8947-6e09325ebe2c": "4",
    "a26448ae-21ec-484f-a4ca-39c34ec31509": "6",
    "9352287f-8885-4d5e-8e9d-d7615841db79": "8",
    "fba521cd-15db-42fe-b3da-8deb336576ed": "9",
    "ee26fc7a-580f-4c6e-bc65-b8566054f9f5": "10",
    "55a0ccbf-45fa-4965-a05e-b80590297fd7": "11",
    "1a51ceef-95f3-4817-a239-213f315cf04e": "12",
    "260c5087-88a2-41bd-a892-ccc0db199b78": "13",
    "fe3d48d4-099a-49e3-86d6-140f2e37d515": "14",
    "f94489e7-2454-42fd-98a6-2e561a72d62e": "15",
    "7c327257-38c1-4595-adbb-8360fd244b40": "16",
    "9aec7171-c03a-4329-98e9-59bd2c8986c2": "17",
  };

  late int valuet;
  List<Product> products = [];
  List<CartItem> cartItems = [];
  bool isDeliverySelected = true;

  Map<String, Map<String, List<dynamic>>> gcart = {};

  @override
  void initState() {
    super.initState();
    valuet = widget.value;
    products = valuet == 0
        ? ProductData.getAllProducts()
        : ProductData.getAllServices();

    fetchCartFromBackend();

    debugPrint('=== CART DEBUG INFO ===');
    debugPrint(
      'Available products: ${products.map((p) => '${p.id}: ${p.name}').toList()}',
    );
    debugPrint('Cart keys: ${gcart.keys.toList()}');
    debugPrint(
      'Cart key types: ${gcart.keys.map((k) => k.runtimeType).toList()}',
    );
    debugPrint(
      'Product ID types: ${products.map((p) => p.id.runtimeType).toList()}',
    );
    debugPrint('=====================');
  }

  Future<void> fetchCartFromBackend() async {
    try {
      final userId = 'a985baac-9028-4dc1-bbd9-a6f3aae49ef5';
      final Map<String, dynamic> responseData =
          await CartService.viewCart(userId: userId);
      List<CartItem> loadedItems = [];

      if (responseData.containsKey('cart') && responseData['cart'] is List) {
        final staticProducts = products;

        for (var provider in responseData['cart']) {
          String providerName = provider['provider_name'] ?? '';
          String providerAddress = provider['provider_address'] ?? '';
          String providerId = provider['provider_id'] ?? '';

          if (provider.containsKey('items') && provider['items'] is List) {
            for (var item in provider['items']) {
              String batchId = item['bpp_product_id'] ?? '';
              String backendProductName = item['item_name'] ?? '';
              String backendCategory = item['category'] ?? '';
              String backendImageUrl = item['image_url'] ?? '';

              Product staticProduct = Product.empty();
              if (batchId.isNotEmpty) {
                String? staticId = backendToStaticIdMap[batchId];
                if (staticId != null) {
                  staticProduct = staticProducts.firstWhere(
                    (p) => p.id == staticId,
                    orElse: () => Product.empty(),
                  );
                }
              }

              loadedItems.add(CartItem(
                id: "",
                userId: userId,
                batchId: batchId,
                productId: providerId,
                productName: staticProduct.name.isNotEmpty
                    ? staticProduct.name
                    : backendProductName,
                quantity: (item['quantity'] as num?)?.toInt() ?? 0,
                unitPrice: (item['unit_price'] as num?)?.toDouble() ?? 0.0,
                imageUrl: staticProduct.imageUrl.isNotEmpty
                    ? staticProduct.imageUrl
                    : backendImageUrl,
                batchCode: batchId,
                farmerName: providerName,
                location: providerAddress,
                category: staticProduct.category.isNotEmpty
                    ? staticProduct.category
                    : backendCategory,
              ));
            }
          }
        }
      }

      setState(() {
        cartItems = loadedItems;
      });

      debugPrint('Loaded cart with merged product data: $cartItems');
    } catch (e) {
      debugPrint('Failed to load cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange, // solid orange, no gradient/blur
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: _buildCartItems(),
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }

  List<Widget> _buildCartItems() {
    if (cartItems.isEmpty) {
      return [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ),
      ];
    }

    return cartItems.map((item) => _buildCartItemCard(item)).toList();
  }

  Widget _buildCartItemCard(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              image: item.imageUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        debugPrint('Error loading image: $exception');
                      },
                    )
                  : null,
            ),
            child: item.imageUrl.isEmpty
                ? const Icon(Icons.shopping_bag, size: 30, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category.isNotEmpty ? item.category : 'General',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.productName.isNotEmpty
                      ? item.productName
                      : 'Unknown Product (${item.productId})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Batch: ${item.batchId} | Qty: ${item.quantity}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  "Farmer: ${item.farmerName} | Location: ${item.location}",
                  style:
                      const TextStyle(fontSize: 10, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹${(item.unitPrice * item.quantity).toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _updateQuantity(item, -1),
                    child: _circleBtn(
                      Icons.remove,
                      item.quantity > 1
                          ? Colors.grey[300]!
                          : Colors.grey[200]!,
                      iconColor:
                          item.quantity > 1 ? Colors.black : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    constraints: const BoxConstraints(minWidth: 30),
                    child: Text(
                      '${item.quantity}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => _updateQuantity(item, 1),
                    child: _circleBtn(
                      Icons.add,
                      Colors.orange,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _removeFromCart(item),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      color: Colors.red[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateQuantity(CartItem item, int change) async {
    int newQuantity = item.quantity + change;
    if (newQuantity > 0) {
      try {
        await CartService.addToCart(
          userId: item.userId,
          batchId: item.batchId,
          itemName: item.productName,
          quantity: newQuantity,
          unitPrice: item.unitPrice,
          imageUrl: item.imageUrl,
          productId: item.productId,
        );
        await fetchCartFromBackend();
      } catch (e) {
        debugPrint('Failed to update quantity: $e');
      }
    } else {
      _removeFromCart(item);
    }
  }

  void _removeFromCart(CartItem item) async {
    try {
      await CartService.deleteFromCart(
          userId: item.userId, batchId: item.batchId);
      await fetchCartFromBackend();
    } catch (e) {
      debugPrint('Failed to remove from cart: $e');
    }
  }

  Widget _circleBtn(
    IconData icon,
    Color color, {
    Color iconColor = Colors.black,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Icon(icon, size: 16, color: iconColor),
    );
  }

  Widget _buildBottomSection() {
    double subtotal = 0;
    double deliveryFee = 0;
    int totalItems = 0;

    for (final item in cartItems) {
      subtotal += item.unitPrice * item.quantity;
      totalItems += item.quantity;
    }

    double total = subtotal + deliveryFee;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDeliveryOptions(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(fontSize: 16)),
              Text(
                '₹${subtotal.toInt()}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          if (isDeliverySelected && deliveryFee > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery fee', style: TextStyle(fontSize: 16)),
                Text(
                  '₹${deliveryFee.toInt()}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          const Divider(height: 20, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '₹${total.toInt()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$totalItems item${totalItems != 1 ? 's' : ''}',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const Text(
                'Include taxes',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildCheckoutButton(totalItems > 0),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isDeliverySelected = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: !isDeliverySelected ? Colors.orange : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Pickup',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: !isDeliverySelected ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isDeliverySelected = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isDeliverySelected ? Colors.orange : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Delivery',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDeliverySelected ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(bool hasItems) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: hasItems
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: hasItems ? Colors.orange : Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          hasItems ? 'Checkout' : 'Cart is Empty',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
