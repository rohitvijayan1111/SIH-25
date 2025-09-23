import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4ADE80)),
        useMaterial3: true,
      ),
      home: const BuyerRequestsScreen(),
    );
  }
}

class BuyerRequestsScreen extends StatelessWidget {
  const BuyerRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // A light slate background
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [Color(0xFFFFFFFF), Color(0xFFF9FAFB)],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
            color: Colors.green,
          ),
        ),
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4B5563)),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: const Text(
          'Buyer Requests',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.menu, color: Color(0xFF4B5563)),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Column(
        children: [
          // Horizontal Filter Row
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(999),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Produce Type',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFF6B7280),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Material(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(999),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFF6B7280),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Scrollable List of Request Cards with animation
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                RequestCard(
                  status: 'Pending',
                  buyerName: 'Agro Exports Inc.',
                  location: 'Mumbai, India',
                  product: 'Tomatoes - 500 kg',
                  requestTime: '2 hours ago',
                  deliveryTime: 'Within 3 days',
                  price: '₹22/kg',
                  total: '₹11,000',
                  badges: const ['Organic', 'Grade A'],
                  isPending: true,
                  delay: 0,
                ),
                RequestCard(
                  status: 'Accepted',
                  buyerName: 'Fresh Produce Co.',
                  location: 'Pune, India',
                  product: 'Potatoes - 1,000 kg',
                  requestTime: '1 day ago',
                  deliveryTime: 'Within 5 days',
                  price: '₹15/kg',
                  total: '₹15,000',
                  badges: const ['Non-GMO'],
                  isAccepted: true,
                  delay: 200,
                ),
                RequestCard(
                  status: 'Declined',
                  buyerName: 'Grocery Hub',
                  location: 'Delhi, India',
                  product: 'Mangoes - 200 kg',
                  requestTime: '2 days ago',
                  deliveryTime: 'Within 1 day',
                  price: '₹80/kg',
                  total: '₹16,000',
                  badges: const ['Grade A'],
                  isDeclined: true,
                  delay: 400,
                ),
              ],
            ),
          ),
        ],
      ),
      // // Persistent Tab Bar with subtle shadow
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   selectedItemColor: const Color(0xFF16A34A),
      //   unselectedItemColor: const Color(0xFF9CA3AF),
      //   showSelectedLabels: true,
      //   showUnselectedLabels: true,
      //   selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_bag_outlined),
      //       label: 'Listings',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.request_page_rounded),
      //       label: 'Requests',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.message_outlined),
      //       label: 'Messages',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_outline),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}

// Creative and unique card widget with animation
class RequestCard extends StatefulWidget {
  final String status;
  final String buyerName;
  final String location;
  final String product;
  final String requestTime;
  final String deliveryTime;
  final String price;
  final String total;
  final List<String> badges;
  final bool isPending;
  final bool isAccepted;
  final bool isDeclined;
  final int delay;

  const RequestCard({
    super.key,
    required this.status,
    required this.buyerName,
    required this.location,
    required this.product,
    required this.requestTime,
    required this.deliveryTime,
    required this.price,
    required this.total,
    required this.badges,
    this.isPending = false,
    this.isAccepted = false,
    this.isDeclined = false,
    required this.delay,
  });

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = Colors.white;
    Color borderColor = const Color(0xFFE5E7EB); // A neutral gray border

    Color statusBadgeBgColor = widget.isPending
        ? const Color(0xFFFEF3C7)
        : widget.isAccepted
        ? const Color(0xFFD1FAE5)
        : const Color(0xFFE5E7EB);

    Color statusBadgeTextColor = widget.isPending
        ? const Color(0xFFB45309)
        : widget.isAccepted
        ? const Color(0xFF065F46)
        : const Color(0xFF374151);

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_animation),
        child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: 2,
            ), // Reduced border width
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Buyer Info Section with subtle styling
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.business_rounded,
                            color: Colors.blueGrey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.buyerName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: Color(0xFF6B7280),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.location,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Request Details Section with bolder typography
                    Text(
                      widget.product,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF16A34A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      label: 'Request time:',
                      value: widget.requestTime,
                      icon: Icons.access_time_filled,
                    ),
                    _buildDetailRow(
                      label: 'Delivery:',
                      value: widget.deliveryTime,
                      icon: Icons.local_shipping,
                    ),
                    _buildDetailRow(
                      label: 'Price:',
                      value: widget.price,
                      icon: Icons.attach_money,
                      valueStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                    _buildDetailRow(
                      label: 'Total:',
                      value: widget.total,
                      icon: Icons.payments,
                      valueStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Certification Badges
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.badges.map((badge) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: badge == 'Organic'
                                ? const Color(0xFFDBEAFE)
                                : const Color(0xFFD1FAE5),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: badge == 'Organic'
                                  ? const Color(0xFF1E40AF)
                                  : const Color(0xFF065F46),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    // Action Buttons with gradients and shadows
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildGradientButton(
                            label: widget.isAccepted ? 'Accepted' : 'Accept',
                            onTap: widget.isPending ? () {} : null,
                            colors: widget.isPending
                                ? [
                                    const Color(0xFF22C55E),
                                    const Color(0xFF16A34A),
                                  ]
                                : [
                                    const Color(0xFF9CA3AF),
                                    const Color(0xFF6B7280),
                                  ],
                            shadowColor: const Color(
                              0xFF22C55E,
                            ).withOpacity(0.3),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: _buildGradientButton(
                            label: 'Counter-offer',
                            onTap: widget.isPending ? () {} : null,
                            colors: widget.isPending
                                ? [
                                    const Color(0xFF3B82F6),
                                    const Color(0xFF2563EB),
                                  ]
                                : [
                                    const Color(0xFF9CA3AF),
                                    const Color(0xFF6B7280),
                                  ],
                            shadowColor: const Color(
                              0xFF3B82F6,
                            ).withOpacity(0.3),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: _buildCircularButton(
                            icon: Icons.close,
                            onTap: widget.isPending ? () {} : null,
                            color: widget.isPending
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF9CA3AF),
                            shadowColor: const Color(
                              0xFFEF4444,
                            ).withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Status Badge (absolute position, rotated)
              Positioned(
                top: 20,
                right: -20,
                child: Transform.rotate(
                  angle: 0.1, // Rotate slightly for a dynamic look
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: statusBadgeBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: statusBadgeTextColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required IconData icon,
    TextStyle? valueStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF4B5563)),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4B5563),
                ),
              ),
            ],
          ),
          Text(
            value,
            style:
                valueStyle ??
                const TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton({
    required String label,
    required VoidCallback? onTap,
    required List<Color> colors,
    required Color shadowColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          if (onTap != null)
            BoxShadow(
              color: shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback? onTap,
    required Color color,
    required Color shadowColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            if (onTap != null)
              BoxShadow(
                color: shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
