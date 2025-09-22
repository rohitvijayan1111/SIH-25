import 'package:flutter/material.dart';

enum ProcurementStatus { active, completed, cancelled, inProgress }

class Procurement {
  final String id;
  final String productId;
  final String productName;
  final String variety;
  final double quantityRequired;
  final double maxPricePerKg;
  final DateTime deadline;
  final DateTime createdAt;
  final ProcurementStatus status;
  final String? farmerId;
  final String? farmerName;
  final String deliveryLocation;
  final String? specialRequirements;
  final List<String> bids;
  final String? assignedBidId;
  final double? finalPrice;
  final DateTime? deliveryDate;

  Procurement({
    required this.id,
    required this.productId,
    required this.productName,
    required this.variety,
    required this.quantityRequired,
    required this.maxPricePerKg,
    required this.deadline,
    required this.createdAt,
    required this.status,
    required this.deliveryLocation,
    this.farmerId,
    this.farmerName,
    this.specialRequirements,
    this.bids = const [],
    this.assignedBidId,
    this.finalPrice,
    this.deliveryDate,
  });

  String get statusDisplay {
    switch (status) {
      case ProcurementStatus.active:
        return 'Active';
      case ProcurementStatus.completed:
        return 'Completed';
      case ProcurementStatus.cancelled:
        return 'Cancelled';
      case ProcurementStatus.inProgress:
        return 'In Progress';
    }
  }

  Color get statusColor {
    switch (status) {
      case ProcurementStatus.active:
        return const Color(0xFF4285F4);
      case ProcurementStatus.completed:
        return const Color(0xFF34A853);
      case ProcurementStatus.cancelled:
        return const Color(0xFFEA4335);
      case ProcurementStatus.inProgress:
        return const Color(0xFFFB8C00);
    }
  }

  bool get isOpenForBidding {
    return status == ProcurementStatus.active &&
        deadline.isAfter(DateTime.now());
  }

  int get daysLeft {
    return deadline.difference(DateTime.now()).inDays;
  }

  factory Procurement.fromJson(Map<String, dynamic> json) {
    return Procurement(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      variety: json['variety'],
      quantityRequired: json['quantityRequired'].toDouble(),
      maxPricePerKg: json['maxPricePerKg'].toDouble(),
      deadline: DateTime.parse(json['deadline']),
      createdAt: DateTime.parse(json['createdAt']),
      status: ProcurementStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ProcurementStatus.active,
      ),
      deliveryLocation: json['deliveryLocation'],
      farmerId: json['farmerId'],
      farmerName: json['farmerName'],
      specialRequirements: json['specialRequirements'],
      bids: List<String>.from(json['bids'] ?? []),
      assignedBidId: json['assignedBidId'],
      finalPrice: json['finalPrice']?.toDouble(),
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
    );
  }

  @override
  String toString() {
    return 'Procurement(id: $id, product: $productName, quantity: $quantityRequired, status: $status)';
  }
}
