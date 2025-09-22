// import 'package:flutter/material.dart';

// class OrdersScreen extends StatefulWidget {
//   final int value;

//   const OrdersScreen({super.key, this.value = 0});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Orders',
//           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: const Color(0xFF4CAF50),
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: const Color(0xFF4CAF50),
//           tabs: const [
//             Tab(text: 'Current'),
//             Tab(text: 'Pickup'),
//             Tab(text: 'Delivery'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildCurrentOrders(),
//           _buildPickupOrders(),
//           _buildDeliveryOrders(),
//         ],
//       ),
//     );
//   }

//   Widget _buildCurrentOrders() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 3, // Sample orders
//       itemBuilder: (context, index) {
//         return _buildOrderCard(
//           orderId: '#ORD-00${index + 1}',
//           items: '3 items',
//           total: '₹${280 + (index * 50)}',
//           status: 'Processing',
//           statusColor: Colors.orange,
//         );
//       },
//     );
//   }

//   Widget _buildPickupOrders() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 2,
//       itemBuilder: (context, index) {
//         return _buildOrderCard(
//           orderId: '#ORD-P0${index + 1}',
//           items: '${index + 2} items',
//           total: '₹${150 + (index * 30)}',
//           status: 'Ready for Pickup',
//           statusColor: const Color(0xFF4CAF50),
//         );
//       },
//     );
//   }

//   Widget _buildDeliveryOrders() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         return _buildOrderCard(
//           orderId: '#ORD-D0${index + 1}',
//           items: '${index + 1} items',
//           total: '₹${200 + (index * 75)}',
//           status: 'Delivered',
//           statusColor: Colors.grey,
//         );
//       },
//     );
//   }

//   Widget _buildOrderCard({
//     required String orderId,
//     required String items,
//     required String total,
//     required String status,
//     required Color statusColor,
//   }) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   orderId,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: statusColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     status,
//                     style: TextStyle(
//                       color: statusColor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   items,
//                   style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                 ),
//                 Text(
//                   total,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF4CAF50),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {},
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(color: Color(0xFF4CAF50)),
//                     ),
//                     child: const Text(
//                       'View Details',
//                       style: TextStyle(color: Color(0xFF4CAF50)),
//                     ),
//                   ),
//                 ),
//                 if (status != 'Delivered') ...[
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF4CAF50),
//                       ),
//                       child: const Text(
//                         'Track Order',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  final int value; // Initial tab index

  const OrdersScreen({super.key, this.value = 0});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample order data (can be fetched from API or model)
  final List<Map<String, dynamic>> orders = [
    {
      "orderId": "#ORD-2024-001",
      "total": "149.99",
      "title": "Maize",
      "image": "assets/CustomerUIAssets/images/maize.jpg",
      "products": [
        {
          "name": "Papaya",
          "image": "assets/CustomerUIAssets/images/papaya.jpg",
          "quantity": 1,
        },
        {
          "name": "Paneer",
          "image": "assets/CustomerUIAssets/images/paneer.jpg",
          "quantity": 1,
        },
      ],
      "status": "Processing",
      "statusColor": Colors.orange,
      "estDelivery": "Dec 25",
      "actions": ["Track Order", "Cancel"],
    },
    {
      "orderId": "#ORD-2024-002",
      "total": "29.99",
      "title": "Rice",
      "image": "assets/CustomerUIAssets/images/rice.jpg",
      "products": [
        {
          "name": "Wheat",
          "image": "assets/CustomerUIAssets/images/wheat.jpg",
          "quantity": 2,
        },
      ],
      "status": "Shipped",
      "statusColor": Colors.blue,
      "estDelivery": "Dec 23",
      "actions": ["Track Order", "Contact"],
    },
    {
      "orderId": "#ORD-2024-003",
      "total": "24.99",
      "title": "Banana",
      "image": "assets/CustomerUIAssets/images/banana.jpg",
      "products": [
        {
          "name": "Organic Basmati Rice",
          "image": "assets/FarmerUIAssets/images/organic-basmati-rice.jpg",
          "quantity": 1,
        },
      ],
      "status": "Delivered",
      "statusColor": Colors.green,
      "estDelivery": "Dec 20",
      "actions": ["Rate Order", "Return"],
    },
    {
      "orderId": "#ORD-2024-004",
      "total": "39.99",
      "title": "Curd",
      "image": "assets/CustomerUIAssets/images/curd.jpg",
      "products": [
        {
          "name": "Premium Basmati Rice",
          "image": "assets/FarmerUIAssets/images/premium-basmati-rice.jpg",
          "quantity": 1,
        },
      ],
      "status": "Preparing",
      "statusColor": Colors.orange,
      "estDelivery": "Dec 27",
      "actions": ["Track Order", "Cancel"],
    },
  ];

  @override
  void initState() {
    super.initState();
    // Home tab shows Pickup (value=0 shows tab 1)
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.value.clamp(0, 2),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // MAIN UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4CAF50),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF4CAF50),
          tabs: const [
            Tab(text: 'Current'),
            Tab(text: 'Pickup'),
            Tab(text: 'Delivery'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(0), // Current
          _buildOrderList(1), // Pickup
          _buildOrderList(2), // Delivery
        ],
      ),
    );
  }

  // Returns list of orders based on tab
  Widget _buildOrderList(int tabIndex) {
    // This sample keeps all orders on 'Current'.
    // Customize data selection for 'Pickup' or 'Delivery' as needed.
    List<Map<String, dynamic>> filteredOrders = [];
    if (tabIndex == 0) {
      filteredOrders = orders.sublist(0, 4);
    } else if (tabIndex == 1) {
      filteredOrders = [orders[0]]; // Pending order for Pickup tab
    } else {
      filteredOrders = [orders[2]]; // Delivered order for Delivery tab
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        return _OrderCard(order: filteredOrders[index]);
      },
    );
  }
}

class _OrderCard extends StatefulWidget {
  final Map<String, dynamic> order;

  const _OrderCard({required this.order});

  @override
  State<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    order['image'],
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['orderId'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        order['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87.withOpacity(0.85),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                _StatusBadge(
                  label: order['status'],
                  color: order['statusColor'],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: order['products'].length > 1
                      ? () {
                          setState(() {
                            expanded = !expanded;
                          });
                        }
                      : null,
                  child: Row(
                    children: [
                      Text(
                        'Quantity: ${order['products'].fold<int>(0, (prev, el) => prev + el['quantity'] as int)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      if (order['products'].length > 1) ...[
                        const SizedBox(width: 4),
                        Icon(
                          expanded ? Icons.expand_less : Icons.expand_more,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  '\$${order['total']}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (expanded && order['products'].length > 1)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    for (final product in order['products'])
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              product['image'],
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${product['name']} (x${product['quantity']})',
                              style: const TextStyle(fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                  child: Text(
                    order['status'] == "Delivered"
                        ? "Delivered: ${order['estDelivery']}"
                        : "Est. delivery: ${order['estDelivery']}",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF4CAF50)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Track Order',
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (order['actions'] != null &&
                    order['actions'].length >= 2) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        order['actions'][1],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.13),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
