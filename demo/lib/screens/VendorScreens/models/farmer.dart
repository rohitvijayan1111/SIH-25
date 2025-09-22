import 'package:flutter/material.dart';
class Farmer {
  final String id;
  final String name;
  final String phone;
  final String location;
  final double rating;
  final int reviewCount;
  final String profileImage;
  final List<String> certifications;
  final bool isVerified;
  final DateTime joinDate;

  Farmer({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.profileImage,
    required this.certifications,
    required this.isVerified,
    required this.joinDate,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      location: json['location'],
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      profileImage: json['profileImage'],
      certifications: List<String>.from(json['certifications']),
      isVerified: json['isVerified'],
      joinDate: DateTime.parse(json['joinDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'location': location,
      'rating': rating,
      'reviewCount': reviewCount,
      'profileImage': profileImage,
      'certifications': certifications,
      'isVerified': isVerified,
      'joinDate': joinDate.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Farmer(id: $id, name: $name, location: $location, rating: $rating)';
  }
}
