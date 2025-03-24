import 'package:cloud_firestore/cloud_firestore.dart';

class OutstockModel {
  final DateTime date;
  final String storeName;
  final String vehicleId;
  final String vechilePlateNo;
  final String employeeName;
  final int quantity;
  final double paidAmount;
  final String paymentType;
  final double totalAmount;
  final double balanceAmount;
  final double previousBalance;
  final double currentBalance;
  final int price;

  OutstockModel({
    required this.date,
    required this.storeName,
    required this.vehicleId,
    required this.employeeName,
    required this.vechilePlateNo,
    required this.quantity,
    required this.paidAmount,
    required this.paymentType,
    required this.totalAmount,
    required this.balanceAmount,
    required this.previousBalance,
    required this.currentBalance,
    required this.price,
  });

  factory OutstockModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return OutstockModel(
      date: (data['timestamp'] as Timestamp).toDate(),
      storeName: data['storeName'] ?? '',
      vehicleId: data['vehicleId'] ?? '',

      employeeName: data['employeeName'] ?? '',
      vechilePlateNo: data['vehicleName'] ?? '',
      quantity: data['quantity'] ?? 0,
      paidAmount: (data['paidAmount'] ?? 0).toDouble(),
      paymentType: data['paymentType'] ?? '',
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      balanceAmount: (data['balanceAmount'] ?? 0).toDouble(),
      previousBalance: data['previousBalance'] ?? 0.0,
      currentBalance: data['balanceAmount'] ?? 0.0,
      price:data['price']??0,
    );
  }
}
