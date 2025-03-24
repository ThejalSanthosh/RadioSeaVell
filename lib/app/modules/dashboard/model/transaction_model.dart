import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String storeId;
  final String employeeName;
  final String employeeId;
  final String vehicleId;
  final String vechilePlateNo;

  final double price;
  final int quantity;
  final double totalAmount;
  final String paymentType;
  final double paidAmount;
  final double balanceAmount;
  final DateTime timestamp;

  final double previousBalance;
  final double currentBalance;
  final String updatedAt;

  TransactionModel({
    required this.id,
    required this.storeId,
    required this.employeeId,
    required this.employeeName,
    required this.vechilePlateNo,
    required this.vehicleId,
    required this.price,
    required this.quantity,
    required this.totalAmount,
    required this.paymentType,
    required this.paidAmount,
    required this.balanceAmount,
    required this.timestamp,

    required this.previousBalance,
    required this.currentBalance,
    required this.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
   var updatedAt = json['UpdatedAt'];
  String formattedDate = '';
  
  if (updatedAt != null) {
    if (updatedAt is Timestamp) {
      formattedDate = updatedAt.toDate().toIso8601String();
    } else if (updatedAt is String) {
      formattedDate = updatedAt;
    }
  }
    return TransactionModel(
      id: json['id'] ?? '',
      storeId: json['storeId'] ?? '',
      employeeId: json['employeeId'] ?? '',
      employeeName: json['employeeName'] ?? '',
      vechilePlateNo: json['vehicleName'] ?? '',
      vehicleId: json['vehicleId'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      paymentType: json['paymentType'] ?? '',
      paidAmount: (json['paidAmount'] ?? 0).toDouble(),
      balanceAmount: (json['balanceAmount'] ?? 0).toDouble(),
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      previousBalance: json['previousBalance'] ?? 0.0,
      currentBalance: json['balanceAmount'] ?? 0.0,
    updatedAt: formattedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'employeeId': employeeId,
      'vehicleId': vehicleId,
      'price': price,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'paymentType': paymentType,
      'paidAmount': paidAmount,
      'balanceAmount': balanceAmount,
      'timestamp': timestamp,
    };
  }
}
