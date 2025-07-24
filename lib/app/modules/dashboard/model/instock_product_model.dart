// class InstockProduct {
//   final String id; // Document ID from Firestore
//   final String dateAdded;
//   final dynamic price;
//   final int quantity;
//   final String type;
//   final String? vehicleId;
//   final String? employeeId;

//   InstockProduct({
//     required this.id,
//     required this.dateAdded,
//     required this.price,
//     required this.quantity,
//     required this.type,
//     this.vehicleId,
//     this.employeeId,
//   });

//   factory InstockProduct.fromJson(Map<String, dynamic> json) {
//     return InstockProduct(
//       id: json['id'] ?? '',
//       dateAdded: json['dateAdded'] ?? '',
//       price: (json['price']) ?? "",
//       quantity: json['quantity'] ?? 0,
//       type: json['type'] ?? '',
//       vehicleId: json['vehicleId'] ?? '',
//       employeeId: json['employeeId'] ?? '',
//     );
//   }
// }


class InstockProduct {
  final String id;
  final String dateAdded;
  final String price; // Changed from double to String
  final int quantity;
  final String type;
  final String vehicleId;
  final String employeeId;

  InstockProduct({
    required this.id,
    required this.dateAdded,
    required this.price,
    required this.quantity,
    required this.type,
    required this.vehicleId,
    required this.employeeId,
  });

  factory InstockProduct.fromJson(Map<String, dynamic> json) {
    return InstockProduct(
      id: json['id'] ?? '',
      dateAdded: json['dateAdded'] ?? DateTime.now().toIso8601String(),
      price: json['price']?.toString() ?? '', // Convert to string
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      type: json['type'] ?? '',
      vehicleId: json['vehicleId'] ?? '',
      employeeId: json['employeeId'] ?? '',
    );
  }

  // Helper method to get numeric part of price
  double get numericPrice {
    final numericPart = RegExp(r'\d+\.?\d*').firstMatch(price);
    return numericPart != null ? double.tryParse(numericPart.group(0)!) ?? 0.0 : 0.0;
  }

  // Helper method to get suffix part of price
  String get priceSuffix {
    final numericPart = RegExp(r'\d+\.?\d*').firstMatch(price);
    if (numericPart != null) {
      return price.replaceFirst(numericPart.group(0)!, '').trim();
    }
    return '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateAdded': dateAdded,
      'price': price,
      'quantity': quantity,
      'type': type,
      'vehicleId': vehicleId,
      'employeeId': employeeId,
    };
  }
}
