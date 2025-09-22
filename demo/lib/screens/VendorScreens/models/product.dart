enum ProductCategory {
  fruits,
  vegetables,
  grains,
  pulses,
  spices,
  dairy,
  other,
}

enum ProductGrade { gradeA, gradeB, gradeC, premium }

class Product {
  final String id;
  final String name;
  final ProductCategory category;
  final String variety;
  final String description;
  final String imageUrl;
  final ProductGrade grade;
  final double pricePerKg;
  final String unit;
  final int shelfLifeDays;
  final List<String> storageRequirements;
  final bool isOrganic;
  final String? originState;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.variety,
    required this.description,
    required this.imageUrl,
    required this.grade,
    required this.pricePerKg,
    required this.unit,
    required this.shelfLifeDays,
    required this.storageRequirements,
    required this.isOrganic,
    this.originState,
  });

  String get categoryName {
    switch (category) {
      case ProductCategory.fruits:
        return 'Fruits';
      case ProductCategory.vegetables:
        return 'Vegetables';
      case ProductCategory.grains:
        return 'Grains';
      case ProductCategory.pulses:
        return 'Pulses';
      case ProductCategory.spices:
        return 'Spices';
      case ProductCategory.dairy:
        return 'Dairy';
      case ProductCategory.other:
        return 'Other';
    }
  }

  String get gradeDisplay {
    switch (grade) {
      case ProductGrade.gradeA:
        return 'Grade A';
      case ProductGrade.gradeB:
        return 'Grade B';
      case ProductGrade.gradeC:
        return 'Grade C';
      case ProductGrade.premium:
        return 'Premium';
    }
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: ProductCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => ProductCategory.other,
      ),
      variety: json['variety'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      grade: ProductGrade.values.firstWhere(
        (e) => e.name == json['grade'],
        orElse: () => ProductGrade.gradeA,
      ),
      pricePerKg: json['pricePerKg'].toDouble(),
      unit: json['unit'],
      shelfLifeDays: json['shelfLifeDays'],
      storageRequirements: List<String>.from(json['storageRequirements']),
      isOrganic: json['isOrganic'],
      originState: json['originState'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category.name,
      'variety': variety,
      'description': description,
      'imageUrl': imageUrl,
      'grade': grade.name,
      'pricePerKg': pricePerKg,
      'unit': unit,
      'shelfLifeDays': shelfLifeDays,
      'storageRequirements': storageRequirements,
      'isOrganic': isOrganic,
      'originState': originState,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, variety: $variety, price: $pricePerKg/$unit)';
  }
}
