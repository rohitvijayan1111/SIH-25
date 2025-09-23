import 'package:flutter/material.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeInAnimation;
  late final Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );

    _slideInAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
          ),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dummy data for the request details
    final request = Request(
      middlemanName: "John Doe",
      middlemanLocation: "Pune, India",
      middlemanRating: 4.5,
      produceName: "Tomatoes",
      quantity: 500,
      offeredPricePerKg: 25.0,
      status: RequestStatus.pending,
      submittedTimestamp: DateTime.now().subtract(const Duration(hours: 2)),
      deliveryTimeline: "Within 2 days",
      deliveryMethod: "Pickup from farm",
      comments:
          "Looking for fresh, high-quality tomatoes for my shop. Please respond soon.",
      avatarUrl: "https://placehold.co/100x100/A0C49D/FFFFFF?text=JD",
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF0F5F9), // Light blue-gray background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {},
        ),
        title: const Text(
          "Request Details",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Middleman Profile Section
              _buildAnimatedCard(child: _buildProfileSection(request)),
              const SizedBox(height: 16),

              // Request Info Section
              _buildAnimatedCard(
                delay: const Duration(milliseconds: 100),
                child: _buildInfoCard(
                  title: "Request Information",
                  children: [
                    _buildDetailRow(
                      "Produce:",
                      "${request.produceName} – ${request.quantity}kg",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Pricing Info Section
              _buildAnimatedCard(
                delay: const Duration(milliseconds: 200),
                child: _buildInfoCard(
                  title: "Pricing Information",
                  children: [
                    _buildDetailRow(
                      "Offered Price:",
                      "₹${request.offeredPricePerKg.toStringAsFixed(2)}/kg",
                    ),
                    _buildDetailRow(
                      "Total Offered Amount:",
                      "₹${(request.offeredPricePerKg * request.quantity).toStringAsFixed(2)}",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Status and Timestamp Section
              _buildAnimatedCard(
                delay: const Duration(milliseconds: 300),
                child: _buildStatusSection(request),
              ),
              const SizedBox(height: 16),

              // Delivery Details Section
              _buildAnimatedCard(
                delay: const Duration(milliseconds: 400),
                child: _buildInfoCard(
                  title: "Delivery Details",
                  children: [
                    _buildDetailRow("Timeline:", request.deliveryTimeline),
                    _buildDetailRow("Method:", request.deliveryMethod),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Comments Section
              if (request.comments != null) ...[
                _buildAnimatedCard(
                  delay: const Duration(milliseconds: 500),
                  child: _buildInfoCard(
                    title: "Notes",
                    children: [
                      Text(
                        request.comments!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Action Buttons
              _buildAnimatedCard(
                delay: const Duration(milliseconds: 600),
                child: _buildActionButtons(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCard({
    required Widget child,
    Duration delay = Duration.zero,
  }) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: SlideTransition(position: _slideInAnimation, child: child),
    );
  }

  Widget _buildProfileSection(Request request) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.green.shade100,
            backgroundImage: NetworkImage(request.avatarUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.middlemanName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  request.middlemanLocation,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      request.middlemanRating.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Divider(height: 16, color: Colors.black12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection(Request request) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatusBadge(request.status),
          Text(
            "Submitted ${_getFormattedTime(request.submittedTimestamp)}",
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(RequestStatus status) {
    String text;
    Color color;
    switch (status) {
      case RequestStatus.pending:
        text = "Pending";
        color = Colors.orange;
        break;
      case RequestStatus.accepted:
        text = "Accepted";
        color = Colors.green;
        break;
      case RequestStatus.declined:
        text = "Declined";
        color = Colors.red;
        break;
      case RequestStatus.countered:
        text = "Countered";
        color = Colors.blue;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  String _getFormattedTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} mins ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check, color: Colors.white),
            label: const Text(
              "Accept Request",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("Make Counter-offer"),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blue),
              foregroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("Decline"),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Request {
  final String middlemanName;
  final String middlemanLocation;
  final double middlemanRating;
  final String produceName;
  final int quantity;
  final double offeredPricePerKg;
  final RequestStatus status;
  final DateTime submittedTimestamp;
  final String deliveryTimeline;
  final String deliveryMethod;
  final String? comments;
  final String avatarUrl;

  Request({
    required this.middlemanName,
    required this.middlemanLocation,
    required this.middlemanRating,
    required this.produceName,
    required this.quantity,
    required this.offeredPricePerKg,
    required this.status,
    required this.submittedTimestamp,
    required this.deliveryTimeline,
    required this.deliveryMethod,
    this.comments,
    required this.avatarUrl,
  });
}

enum RequestStatus { pending, accepted, declined, countered }
