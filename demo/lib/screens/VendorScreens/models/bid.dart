import 'package:flutter/material.dart';

enum BidStatus { pending, accepted, rejected, countered, expired }

class Bid{
  final String id;
  final String procurementId;
  final String farmerId;
  final String farmerName;
  final String farmerLocation;
  final String farmerProfileImage;
  final double farmerRating;
  final int farmerReviewCount;
  final double quantityAvailable;
  final double pricePerKg;
  final double totalAmount;
  final DateTime deliveryDate;
  final DateTime bidDate;
  final BidStatus status;
  final String? notes;
  final List<String> certifications;
  final String? counterOfferNote;
  final double? counterOfferPrice;
  final DateTime? responseDeadline;
  final bool isNegotiable;
  final String transportMethod;
  final double distanceKm;

  Bid({
    required this.id,
    required this.procurementId,
    required this.farmerId,
    required this.farmerName,
    required this.farmerLocation,
    required this.farmerProfileImage,
    required this.farmerRating,
    required this.farmerReviewCount,
    required this.quantityAvailable,
    required this.pricePerKg,
    required this.totalAmount,
    required this.deliveryDate,
    required this.bidDate,
    required this.status,
    required this.transportMethod,
    required this.distanceKm,
    this.notes,
    this.certifications = const [],
    this.counterOfferNote,
    this.counterOfferPrice,
    this.responseDeadline,
    this.isNegotiable = true,
  });

  String get statusDisplay {
    switch (status) {
      case BidStatus.pending:
        return 'Pending';
      case BidStatus.accepted:
        return 'Accepted';
      case BidStatus.rejected:
        return 'Rejected';
      case BidStatus.countered:
        return 'Countered';
      case BidStatus.expired:
        return 'Expired';
    }
  }

  Color get statusColor {
    switch (status) {
      case BidStatus.pending:
        return const Color(0xFFFB8C00);
      case BidStatus.accepted:
        return const Color(0xFF34A853);
      case BidStatus.rejected:
        return const Color(0xFFEA4335);
      case BidStatus.countered:
        return const Color(0xFF4285F4);
      case BidStatus.expired:
        return const Color(0xFF9E9E9E);
    }
  }

  bool get isActive {
    return status == BidStatus.pending || status == BidStatus.countered;
  }

  String get deliveryTimeLeft {
    final now = DateTime.now();
    final difference = deliveryDate.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} left';
    } else {
      return 'Due today';
    }
  }

  String get distanceDisplay {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).toInt()}m away';
    }
    return '${distanceKm.toStringAsFixed(1)}km away';
  }

  @override
  String toString() {
    return 'Bid(id: $id, farmer: $farmerName, price: $pricePerKg/kg, status: $status)';
  }
}
