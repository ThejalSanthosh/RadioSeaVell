// class OutstockSummary {
//   final String id;
//   final String dateCreated;
//   final String lastUpdated;
//   final String employeeId;
//   final double price;
//   final int quantity;
//   final String vehicleId;

//   OutstockSummary({
//     required this.id,
//     required this.dateCreated,
//     required this.lastUpdated,
//     required this.employeeId,
//     required this.price,
//     required this.quantity,
//     required this.vehicleId,
//   });

//   factory OutstockSummary.fromJson(Map<String, dynamic> json) {
//     return OutstockSummary(
//       id: json['id'] ?? '',
//       dateCreated: json['dateCreated'] ?? '',
//       lastUpdated: json['lastUpdated'] ?? '',
//       employeeId: json['employeeId'] ?? '',
//       price: (json['price'] ?? 0).toDouble(),
//       quantity: json['quantity'] ?? 0,
//       vehicleId: json['vehicleId'] ?? '',
//     );
//   }
// }

class OutstockSummary {
  final String id;
  final String dateCreated;
  final String price; // Changed to String
  final int quantity;
  final String vehicleId;
  final String employeeId;

  OutstockSummary({
    required this.id,
    required this.dateCreated,
    required this.price,
    required this.quantity,
    required this.vehicleId,
    required this.employeeId,
  });

  factory OutstockSummary.fromJson(Map<String, dynamic> json) {
    return OutstockSummary(
      id: json['id'] ?? '',
      dateCreated: json['dateCreated'] ?? DateTime.now().toIso8601String(),
      price: json['price']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      vehicleId: json['vehicleId'] ?? '',
      employeeId: json['employeeId'] ?? '',
    );
  }
}
