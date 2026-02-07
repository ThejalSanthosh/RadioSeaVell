import 'package:cloud_firestore/cloud_firestore.dart';



class TransactionModel {
  final String id;
  final String employeeName;
  final String vechilePlateNo;
  final List<TransactionItem> items;
  final double totalAmount;
  final double paidAmount;
  final double previousBalance;
  final double currentBalance;
  final DateTime timestamp;
  final String updatedAt;
  final String? reason;
  final double cashAmount;
final double upiAmount;


  TransactionModel({
    required this.id,
    required this.employeeName,
    required this.vechilePlateNo,
    required this.items,
    required this.totalAmount,
    required this.paidAmount,
    required this.previousBalance,
    required this.currentBalance,
    required this.timestamp,
    required this.updatedAt,
    this.reason,
     required this.cashAmount,
  required this.upiAmount,

  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final payment = data['payment'] as Map<String, dynamic>? ?? {};
  final cash = (payment['cash'] ?? 0).toDouble();
  final upi  = (payment['upi'] ?? 0).toDouble();

    // Parse items array
    List<TransactionItem> itemsList = [];
    if (data['items'] != null) {
      itemsList = (data['items'] as List)
          .map((item) => TransactionItem.fromMap(item))
          .toList();
    } else {
      // Fallback for old data structure
      itemsList = [
        TransactionItem(
          price: (data['price'] ?? 0).toDouble(),
          quantity: (data['quantity'] ?? 0).toInt(),
          amount: (data['price'] ?? 0).toDouble() * (data['quantity'] ?? 0).toInt(),
              priceLabel: data['priceLabel'] ?? '', // ✅ ADD

        )
      ];
    }

    // Safe date parsing
    DateTime parsedTimestamp;
    try {
      if (data['timestamp'] is Timestamp) {
        parsedTimestamp = (data['timestamp'] as Timestamp).toDate();
      } else if (data['timestamp'] is String) {
        parsedTimestamp = DateTime.parse(data['timestamp']);
      } else {
        parsedTimestamp = DateTime.now();
      }
    } catch (e) {
      parsedTimestamp = DateTime.now();
    }

    // Safe updatedAt parsing
    String parsedUpdatedAt = '';
    try {
      if (data['UpdatedAt'] != null) {
        if (data['UpdatedAt'] is Timestamp) {
          parsedUpdatedAt = (data['UpdatedAt'] as Timestamp).toDate().toIso8601String();
        } else if (data['UpdatedAt'] is String) {
          parsedUpdatedAt = data['UpdatedAt'];
        }
      }
    } catch (e) {
      parsedUpdatedAt = '';
    }

    return TransactionModel(
      id: doc.id,
      employeeName: data['employeeName'] ?? '',
      vechilePlateNo: data['vehicleName'] ?? data['vechilePlateNo'] ?? '',
      items: itemsList,
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      paidAmount: (data['paidAmount'] ?? 0).toDouble(),
      previousBalance: (data['previousBalance'] ?? 0).toDouble(),
      currentBalance: (data['balanceAmount'] ?? data['currentBalance'] ?? 0).toDouble(),
      timestamp: parsedTimestamp,
      updatedAt: parsedUpdatedAt,
      reason: data['reason'],
       cashAmount: cash,
    upiAmount: upi,
      
    );

    
  }
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

  // Helper methods
  double get totalPrice => items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);
  // String get itemsDisplay => items.asMap().entries.map((entry) {
  //   int index = entry.key;
  //   TransactionItem item = entry.value;
  //   return 'Item ${index + 1}: Qty ${item.quantity} × ₹${item.price} = ₹${item.amount}';
  // }).join('\n');

  String get itemsDisplay => items.asMap().entries.map((entry) {
  int index = entry.key;
  TransactionItem item = entry.value;
  return 'Item ${index + 1}: ${item.priceLabel} | '
      'Qty ${item.quantity} × ₹${item.price} = ₹${item.amount}';
}).join('\n');

}


class TransactionItem {
  final double price;
  final int quantity;
  final double amount;
  final String priceLabel;

  TransactionItem({
    required this.price,
    required this.quantity,
    required this.amount,
            required this.priceLabel,

  });

  factory TransactionItem.fromMap(Map<String, dynamic> map) {
    return TransactionItem(
      price: (map['price'] ?? 0).toDouble(),
      quantity: (map['quantity'] ?? 0).toInt(),
      amount: (map['amount'] ?? 0).toDouble(),
       priceLabel: map['priceLabel'] ?? '', 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'quantity': quantity,
      'amount': amount,
    };
  }
}
