class Product {
  final String id;
  final int quantity;
  final dynamic price;
  final DateTime dateAdded;
  final String type;
  final String? vehicleId; // Non-nullable
  final String? employeeId; // Non-nullable

  Product({
    required this.id,
    required this.quantity,
    required this.price,
    required this.dateAdded,
    required this.type,
    this.vehicleId,
    this.employeeId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'quantity': quantity,
    'price': price,
    'dateAdded': dateAdded.toIso8601String(),
    'type': type,
    'vehicleId': vehicleId,
    'employeeId': employeeId,
  };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] ?? '',
    quantity: (json['quantity'] ?? 0).toInt(),
      price: json['price'], 
    dateAdded: DateTime.parse(
      json['dateAdded'] ?? DateTime.now().toIso8601String(),
    ),
    type: json['type'] ?? 'instock',
    vehicleId: json['vehicleId'] ?? '',
    employeeId: json['employeeId'] ?? '',
  );
}
