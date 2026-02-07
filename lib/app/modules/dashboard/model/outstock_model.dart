import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String priceString;
  final String priceLabel;
  final double cashAmount;
  final double upiAmount;

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
    required this.priceLabel,

    required this.priceString,
    required this.cashAmount,
    required this.upiAmount,
  });

  factory OutstockModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final payment = data['payment'] as Map<String, dynamic>? ?? {};

    final cash = (payment['cash'] ?? 0).toDouble();
    final upi = (payment['upi'] ?? 0).toDouble();

    // Parse items array
    List<OutstockItem> itemsList = [];
    if (data['items'] != null) {
      itemsList =
          (data['items'] as List)
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
      priceString: data['paymentType'] ?? '',
      priceLabel: data['priceLabel'] ?? '', // ✅ ADD
      cashAmount: cash,
      upiAmount: upi,
    );
  }

  // Helper methods to get totals
  double get totalPrice =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);
  String get itemsDisplay =>
      items.map((item) => '${item.quantity}x@₹${item.price}').join(', ');
  String get paymentDisplay {
    if (cashAmount > 0 && upiAmount > 0) {
      return 'Cash ₹${cashAmount.toStringAsFixed(0)} + '
          'UPI ₹${upiAmount.toStringAsFixed(0)}';
    }
    if (cashAmount > 0) {
      return 'Cash ₹${cashAmount.toStringAsFixed(0)}';
    }
    if (upiAmount > 0) {
      return 'UPI ₹${upiAmount.toStringAsFixed(0)}';
    }
    return 'Credit';
  }
}

class OutstockItem {
  final double price;
  final int quantity;
  final double amount;
  final String priceLabel;
  OutstockItem({
    required this.price,
    required this.quantity,
    required this.amount,
    required this.priceLabel,
  });

  factory OutstockItem.fromMap(Map<String, dynamic> map) {
    return OutstockItem(
      price: (map['price'] ?? 0).toDouble(),
      quantity: (map['quantity'] ?? 0).toInt(),
      amount: (map['amount'] ?? 0).toDouble(),
      priceLabel: map['priceLabel'] ?? "",
    );
  }
}
