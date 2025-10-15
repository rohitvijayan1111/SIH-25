import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum OrderStatus {
  pending('Pending'),
  confirmed('Confirmed'),
  processing('Processing'),
  shipped('Shipped'),
  delivered('Delivered'),
  cancelled('Cancelled');

  const OrderStatus(this.displayName);
  final String displayName;

  Color get statusColor {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.processing:
        return Colors.purple;
      case OrderStatus.shipped:
        return Colors.indigo;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
} // ← This closing brace was missing!

class OrderItem {
  final String id;
  final String name;
  final String image;
  final double price;
  final int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    // ← Fixed Map type
    return OrderItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 0,
    );
  }

  double get totalPrice => price * quantity;
}

double parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

class Order {
  final String id;
  final String userId;
  final DateTime orderDate;
  final OrderStatus status;
  final double totalAmount;
  final String deliveryAddress;
  final List<OrderItem> items; // ← Fixed typing
  final DateTime? deliveredAt;
  final DateTime? estimatedDelivery;

  Order({
    required this.id,
    required this.userId,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.items,
    this.deliveredAt,
    this.estimatedDelivery,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    // ← Fixed Map type
    return Order(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      orderDate: DateTime.parse(
        json['order_date'] ?? DateTime.now().toIso8601String(),
      ),
      status: OrderStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      totalAmount: parseDouble(json['total_amount']),
      deliveryAddress: json['delivery_address'] ?? '',
      items:
          (json['items'] as List<dynamic>? ?? []) // ← Fixed casting
              .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
              .toList(),
      deliveredAt: json['delivered_at'] != null
          ? DateTime.parse(json['delivered_at'])
          : null,
      estimatedDelivery: json['estimated_delivery'] != null
          ? DateTime.parse(json['estimated_delivery'])
          : null,
    );
  }

  String get formattedDate {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(orderDate);
  }

  String get shortOrderId {
    return '#${id.substring(0, 8).toUpperCase()}';
  }

  int get itemCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
}
