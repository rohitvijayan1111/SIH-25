import 'package:flutter/material.dart';

import '../../global.dart';
import 'checkout_screen.dart';
import 'models/product_model.dart'; // ✅ import product data

class CartScreen extends StatefulWidget {
  final int value; // same as HomeScreen's value

  const CartScreen({super.key, this.value = 0});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int valuet;
  List<Product> products = [];
  bool isDeliverySelected = true;

  @override
  void initState() {
    super.initState();
    valuet = widget.value;
    products = valuet == 0
        ? ProductData.getAllProducts()
        : ProductData.getAllServices();
    
    // Debug: Print cart contents and available products
    debugPrint('=== CART DEBUG INFO ===');
    debugPrint('Cart contents: $gcart');
    debugPrint('Available products: ${products.map((p) => '${p.id}: ${p.name}').toList()}');
    debugPrint('Cart keys: ${gcart.keys.toList()}');
    debugPrint('Cart key types: ${gcart.keys.map((k) => k.runtimeType).toList()}');
    debugPrint('Product ID types: ${products.map((p) => p.id.runtimeType).toList()}');
    debugPrint('=====================');
  }

  // Helper function to extract numeric ID from cart key (H1 -> 1, H2 -> 2, etc.)
  int? _extractProductId(String cartKey) {
    final regex = RegExp(r'^[A-Z](\d+)$');
    final match = regex.firstMatch(cartKey);
    if (match != null) {
      return int.tryParse(match.group(1)!);
    }
    return null;
  }

  // Helper function to find product by cart key
  Product? _findProductByCartKey(String cartKey) {
    debugPrint('Looking for product with cart key: $cartKey');
    
    // Extract numeric ID from cart key (e.g., "H1" -> 1)
    final numericId = _extractProductId(cartKey);
    if (numericId != null) {
      try {
        final product = products.firstWhere((p) => p.id == numericId);
        debugPrint('Found product: ${product.name} (ID: ${product.id})');
        return product;
      } catch (e) {
        debugPrint('No product found with ID: $numericId');
      }
    }
    
    debugPrint('Could not find product for cart key: $cartKey');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.black,
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
    List<Widget> widgets = [];

    gcart.forEach((productId, batches) {
      debugPrint('Processing cart item: $productId');
      debugPrint('Batches: $batches');
      
      // Find the product by cart key
      Product? foundProduct = _findProductByCartKey(productId.toString());

      if (batches != null) {
        batches.forEach((batchId, values) {
          if (values != null && values.length >= 4) {
            int unitPrice = values[0] ?? 0;
            int itemCount = values[1] ?? 0;
            int logisticProvider = values[2] ?? 0;
            int deliveryChargePerUnit = values[3] ?? 0;

            widgets.add(
              _buildCartItemCard(
                foundProduct ?? Product.empty(),
                batchId,
                unitPrice,
                itemCount,
                logisticProvider,
                deliveryChargePerUnit,
                productId, // Pass the original productId for updates
              ),
            );
          }
        });
      }
    });

    if (widgets.isEmpty) {
      widgets.add(
        const Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  Widget _buildCartItemCard(
    Product product,
    String batchId,
    int unitPrice,
    int itemCount,
    int logisticProvider,
    int deliveryChargePerUnit,
    dynamic productId, // Add productId parameter for cart updates
  ) {
    // Check if product was found
    bool isProductFound = product.id != 0 && product.name.isNotEmpty;
    
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
              image: isProductFound && product.imageUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        debugPrint('Error loading image: $exception');
                      },
                    )
                  : null,
            ),
            child: (!isProductFound || product.imageUrl.isEmpty)
                ? const Icon(Icons.shopping_bag, size: 30, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isProductFound && product.category.isNotEmpty 
                      ? product.category 
                      : 'General',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isProductFound && product.name.isNotEmpty 
                      ? product.name 
                      : 'Unknown Product ($productId)',
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
                  "Batch: $batchId | Qty: $itemCount",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (!isProductFound)
                  Text(
                    "Product ID: $productId",
                    style: const TextStyle(fontSize: 10, color: Colors.red),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹${(unitPrice * itemCount).toStringAsFixed(0)}",
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
                    onTap: () {
                      _updateQuantity(productId, batchId, -1);
                    },
                    child: _circleBtn(
                      Icons.remove, 
                      itemCount > 1 ? Colors.grey[300]! : Colors.grey[200]!,
                      iconColor: itemCount > 1 ? Colors.black : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    constraints: const BoxConstraints(minWidth: 30),
                    child: Text(
                      '$itemCount',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      _updateQuantity(productId, batchId, 1);
                    },
                    child: _circleBtn(
                      Icons.add,
                      Colors.green,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _removeFromCart(productId, batchId);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

  void _updateQuantity(dynamic productId, String batchId, int change) {
    setState(() {
      if (gcart[productId] != null && gcart[productId]![batchId] != null) {
        int currentQuantity = gcart[productId]![batchId]![1] ?? 0;
        int newQuantity = currentQuantity + change;
        
        if (newQuantity > 0) {
          gcart[productId]![batchId]![1] = newQuantity;
        } else if (newQuantity <= 0) {
          // Remove the item if quantity becomes 0 or less
          _removeFromCart(productId, batchId);
        }
      }
    });
  }

  void _removeFromCart(dynamic productId, String batchId) {
    setState(() {
      if (gcart[productId] != null) {
        gcart[productId]!.remove(batchId);
        
        // If no more batches for this product, remove the product entirely
        if (gcart[productId]!.isEmpty) {
          gcart.remove(productId);
        }
      }
    });
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

    gcart.forEach((productId, batches) {
      batches?.forEach((batchId, values) {
        if (values != null && values.length >= 4) {
          int unitPrice = values[0] ?? 0;
          int itemCount = values[1] ?? 0;
          int deliveryChargePerUnit = values[3] ?? 0;

          subtotal += unitPrice * itemCount;
          if (isDeliverySelected) {
            deliveryFee += deliveryChargePerUnit * itemCount;
          }
          totalItems += itemCount;
        }
      });
    });

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
                color: !isDeliverySelected ? Colors.green : Colors.grey[300],
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
                color: isDeliverySelected ? Colors.green : Colors.grey[300],
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
        onPressed: hasItems ? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CheckoutScreen()),
          );
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: hasItems ? Colors.green : Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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