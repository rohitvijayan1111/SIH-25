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
      duration: const Duration(milliseconds: 900),
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
      backgroundColor: const Color(0xFFF9FAFB), // Very light background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6A994E)),
          onPressed: () {},
        ),
        title: const Text(
          "Request Details",
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
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
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            delay.inMilliseconds / 900,
            (delay.inMilliseconds + 700) / 900,
            curve: Curves.easeIn,
          ),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  delay.inMilliseconds / 900,
                  (delay.inMilliseconds + 700) / 900,
                  curve: Curves.easeOut,
                ),
              ),
            ),
        child: child,
      ),
    );
  }

  Widget _buildProfileSection(Request request) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6A994E).withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFB4E4A4),
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 8,
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
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
            ),
          ),
          const Divider(height: 24, color: Colors.black12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF5E6B7A),
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF2C3E50),
                fontWeight: FontWeight.w600,
              ),
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 8,
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
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF8B9CB0),
              fontWeight: FontWeight.w500,
            ),
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
        color = const Color(0xFFFFA500);
        break;
      case RequestStatus.accepted:
        text = "Accepted";
        color = const Color(0xFF6A994E);
        break;
      case RequestStatus.declined:
        text = "Declined";
        color = const Color(0xFFE53935);
        break;
      case RequestStatus.countered:
        text = "Countered";
        color = const Color(0xFF0077C0);
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 13,
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
        _AnimatedButton(
          onTap: () {},
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_circle_outline, color: Colors.white),
              label: const Text(
                "Accept Request",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A994E),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                shadowColor: const Color(0xFF6A994E).withOpacity(0.3),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _AnimatedButton(
          onTap: () {},
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("Make Counter-offer"),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF0077C0), width: 2),
                foregroundColor: const Color(0xFF0077C0),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _AnimatedButton(
          onTap: () {},
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("Decline"),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE53935), width: 2),
                foregroundColor: const Color(0xFFE53935),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _AnimatedButton({required this.child, required this.onTap});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
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
