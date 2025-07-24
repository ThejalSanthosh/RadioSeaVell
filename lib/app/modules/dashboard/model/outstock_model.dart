import 'package:cloud_firestore/cloud_firestore.dart';

// class OutstockModel {
//   final DateTime date;
//   final String storeName;
//   final String vehicleId;
//   final String vechilePlateNo;
//   final String employeeName;
//   final int quantity;
//   final double paidAmount;
//   final String paymentType;
//   final double totalAmount;
//   final double balanceAmount;
//   final double previousBalance;
//   final double currentBalance;
//   final int price;

//   OutstockModel({
//     required this.date,
//     required this.storeName,
//     required this.vehicleId,
//     required this.employeeName,
//     required this.vechilePlateNo,
//     required this.quantity,
//     required this.paidAmount,
//     required this.paymentType,
//     required this.totalAmount,
//     required this.balanceAmount,
//     required this.previousBalance,
//     required this.currentBalance,
//     required this.price,
//   });

//   factory OutstockModel.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return OutstockModel(
//       date: (data['timestamp'] as Timestamp).toDate(),
//       storeName: data['storeName'] ?? '',
//       vehicleId: data['vehicleId'] ?? '',

//       employeeName: data['employeeName'] ?? '',
//       vechilePlateNo: data['vehicleName'] ?? '',
//       quantity: data['quantity'] ?? 0,
//       paidAmount: (data['paidAmount'] ?? 0).toDouble(),
//       paymentType: data['paymentType'] ?? '',
//       totalAmount: (data['totalAmount'] ?? 0).toDouble(),
//       balanceAmount: (data['balanceAmount'] ?? 0).toDouble(),
//       previousBalance: data['previousBalance'] ?? 0.0,
//       currentBalance: data['balanceAmount'] ?? 0.0,
//       price:data['price']??0,
//     );
//   }
// }


class OutstockModel {
  final DateTime date;
  final String storeName;
  final String employeeName;
  final String vechilePlateNo;
  final List<OutstockItem> items; // Changed to list of items
  final double totalAmount;
  final double paidAmount;
  final double previousBalance;
  final double currentBalance;
  final String paymentType;

  OutstockModel({
    required this.date,
    required this.storeName,
    required this.employeeName,
    required this.vechilePlateNo,
    required this.items,
    required this.totalAmount,
    required this.paidAmount,
    required this.previousBalance,
    required this.currentBalance,
    required this.paymentType,
  });

  factory OutstockModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    // Parse items array
    List<OutstockItem> itemsList = [];
    if (data['items'] != null) {
      itemsList = (data['items'] as List)
          .map((item) => OutstockItem.fromMap(item))
          .toList();
    }

    return OutstockModel(
      date: (data['timestamp'] as Timestamp).toDate(),
      storeName: data['storeName'] ?? '',
      employeeName: data['employeeName'] ?? '',
      vechilePlateNo: data['vehicleName'] ?? '',
      items: itemsList,
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      paidAmount: (data['paidAmount'] ?? 0).toDouble(),
      previousBalance: (data['previousBalance'] ?? 0).toDouble(),
      currentBalance: (data['balanceAmount'] ?? 0).toDouble(),
      paymentType: data['paymentType'] ?? '',
    );
  }

  // Helper methods to get totals
  double get totalPrice => items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);
  String get itemsDisplay => items.map((item) => '${item.quantity}x@₹${item.price}').join(', ');
}

class OutstockItem {
  final double price;
  final int quantity;
  final double amount;

  OutstockItem({
    required this.price,
    required this.quantity,
    required this.amount,
  });

  factory OutstockItem.fromMap(Map<String, dynamic> map) {
    return OutstockItem(
      price: (map['price'] ?? 0).toDouble(),
      quantity: (map['quantity'] ?? 0).toInt(),
      amount: (map['amount'] ?? 0).toDouble(),
    );
  }
}
