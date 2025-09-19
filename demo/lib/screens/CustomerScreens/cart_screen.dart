import 'package:flutter/material.dart';

// Cart Item Model - Represents each product in cart
class CartItem {
  final String id;
  final String name;
  final String category;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.quantity,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample cart items data (normally this comes from a database/API)
  List<CartItem> cartItems = [
    CartItem(
      id: '1',
      name: 'Mustard Greens',
      category: 'Vegetables',
      image: '🥬', // Using emoji as placeholder
      price: 59.0,
      quantity: 1,
    ),
    CartItem(
      id: '2',
      name: 'Organic Carrots',
      category: 'Vegetables',
      image: '🥕',
      price: 60.0,
      quantity: 1,
    ),
    CartItem(
      id: '3',
      name: 'Organic Apple',
      category: 'Fruits',
      image: '🍎',
      price: 120.0,
      quantity: 1,
    ),
  ];

  // Variables for delivery and pickup selection
  bool isDeliverySelected = true; // True = delivery, False = pickup
  double deliveryFee = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color of entire screen
      backgroundColor: Colors.white,

      // Top app bar
      appBar: AppBar(
        // Background color of app bar
        backgroundColor: Colors.white,
        // Remove shadow under app bar
        elevation: 0,

        // Back button (automatically added by Flutter)
        leading: IconButton(
          onPressed: () =>
              Navigator.pop(context), // Goes back to previous screen
          icon: const Icon(Icons.close, color: Colors.black),
        ),

        // Title in center
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,

        // Edit button on right
        actions: [
          TextButton(
            onPressed: () {
              // Handle edit action
              print('Edit tapped');
            },
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),

      // Main content of screen
      body: Column(
        children: [
          // Scrollable list of cart items
          Expanded(
            child: ListView.builder(
              // Add padding around the list
              padding: const EdgeInsets.all(16),
              // Number of items in cart
              itemCount: cartItems.length,
              // Builder function creates each cart item widget
              itemBuilder: (context, index) {
                final item = cartItems[index]; // Get item at current index
                return _buildCartItemCard(
                  item,
                  index,
                ); // Create card for this item
              },
            ),
          ),

          // Bottom section with delivery options and checkout
          _buildBottomSection(),
        ],
      ),
    );
  }

  // Builds individual cart item card
  Widget _buildCartItemCard(CartItem item, int index) {
    return Container(
      // Add space between cards
      margin: const EdgeInsets.only(bottom: 16),
      // Card styling
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Shadow effect
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      // Row layout: image on left, details in middle, quantity controls on right
      child: Row(
        children: [
          // Product image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(item.image, style: const TextStyle(fontSize: 30)),
            ),
          ),

          const SizedBox(width: 16), // Space between image and text
          // Product details (name, category, price)
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to left
              children: [
                // Category label
                Text(
                  item.category,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                // Product name
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 4),

                // Quantity display
                Text(
                  'Qty: ${item.quantity}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Right side: price and quantity controls
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Price
              Text(
                '₹${item.price.toInt()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              // Quantity controls row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Decrease quantity button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (item.quantity > 1) {
                          item.quantity--;
                        }
                      });
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Quantity display
                  Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Increase quantity button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        item.quantity++;
                      });
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Builds bottom section with coupon, delivery options, and checkout
  Widget _buildBottomSection() {
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
          // Coupon code section
          _buildCouponSection(),

          const SizedBox(height: 16),

          // Delivery/Pickup options
          _buildDeliveryOptions(),

          const SizedBox(height: 16),

          // Price breakdown
          _buildPriceBreakdown(),

          const SizedBox(height: 20),

          // Checkout button
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  // Coupon code input section
  Widget _buildCouponSection() {
    return Row(
      children: [
        const Text(
          'Coupon code',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),

        const Spacer(), // Pushes "Your code" to right

        GestureDetector(
          onTap: () {
            // Handle coupon tap
            print('Coupon tapped');
          },
          child: Text(
            'Your code',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  // Delivery and pickup option buttons
  Widget _buildDeliveryOptions() {
    return Row(
      children: [
        // Pickup button
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isDeliverySelected = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: !isDeliverySelected ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: !isDeliverySelected ? Colors.green : Colors.grey!,
                ),
              ),
              child: Text(
                'Pickup',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: !isDeliverySelected ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Delivery button
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isDeliverySelected = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isDeliverySelected ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDeliverySelected ? Colors.green : Colors.grey!,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Delivery',
                    style: TextStyle(
                      color: isDeliverySelected ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (isDeliverySelected) ...[
                    const SizedBox(width: 8),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Price calculation and breakdown
  Widget _buildPriceBreakdown() {
    // Calculate subtotal
    double subtotal = cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    double currentDeliveryFee = isDeliverySelected ? deliveryFee : 0;
    double total = subtotal + currentDeliveryFee;

    return Column(
      children: [
        // Delivery fee row
        if (isDeliverySelected)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery fee', style: TextStyle(fontSize: 16)),
                Text(
                  '₹${currentDeliveryFee.toInt()}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

        // Total price row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Price',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '₹${total.toInt()}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        // Item count
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${cartItems.length} items',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                'Include taxes',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Checkout button
  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity, // Full width button
      child: ElevatedButton(
        onPressed: () {
          // Handle checkout
          print('Checkout tapped');
          // Navigate to checkout screen or show payment options
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
