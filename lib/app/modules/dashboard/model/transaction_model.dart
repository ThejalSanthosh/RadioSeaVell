import 'package:cloud_firestore/cloud_firestore.dart';

// class TransactionModel {
//   final String id;
//   final String storeId;
//   final String employeeName;
//   final String employeeId;
//   final String vehicleId;
//   final String vechilePlateNo;

//   final double price;
//   final int quantity;
//   final double totalAmount;
//   final String paymentType;
//   final double paidAmount;
//   final double balanceAmount;
//   final DateTime timestamp;

//   final double previousBalance;
//   final double currentBalance;
//   final String updatedAt;

//   TransactionModel({
//     required this.id,
//     required this.storeId,
//     required this.employeeId,
//     required this.employeeName,
//     required this.vechilePlateNo,
//     required this.vehicleId,
//     required this.price,
//     required this.quantity,
//     required this.totalAmount,
//     required this.paymentType,
//     required this.paidAmount,
//     required this.balanceAmount,
//     required this.timestamp,

//     required this.previousBalance,
//     required this.currentBalance,
//     required this.updatedAt,
//   });

//   factory TransactionModel.fromJson(Map<String, dynamic> json) {
//    var updatedAt = json['UpdatedAt'];
//   String formattedDate = '';
  
//   if (updatedAt != null) {
//     if (updatedAt is Timestamp) {
//       formattedDate = updatedAt.toDate().toIso8601String();
//     } else if (updatedAt is String) {
//       formattedDate = updatedAt;
//     }
//   }
//     return TransactionModel(
//       id: json['id'] ?? '',
//       storeId: json['storeId'] ?? '',
//       employeeId: json['employeeId'] ?? '',
//       employeeName: json['employeeName'] ?? '',
//       vechilePlateNo: json['vehicleName'] ?? '',
//       vehicleId: json['vehicleId'] ?? '',
//       price: (json['price'] ?? 0).toDouble(),
//       quantity: json['quantity'] ?? 0,
//       totalAmount: (json['totalAmount'] ?? 0).toDouble(),
//       paymentType: json['paymentType'] ?? '',
//       paidAmount: (json['paidAmount'] ?? 0).toDouble(),
//       balanceAmount: (json['balanceAmount'] ?? 0).toDouble(),
//       timestamp: (json['timestamp'] as Timestamp).toDate(),
//       previousBalance: json['previousBalance'] ?? 0.0,
//       currentBalance: json['balanceAmount'] ?? 0.0,
//     updatedAt: formattedDate,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'storeId': storeId,
//       'employeeId': employeeId,
//       'vehicleId': vehicleId,
//       'price': price,
//       'quantity': quantity,
//       'totalAmount': totalAmount,
//       'paymentType': paymentType,
//       'paidAmount': paidAmount,
//       'balanceAmount': balanceAmount,
//       'timestamp': timestamp,
//     };
//   }
// }


class TransactionModel {
  final String id;
  final String employeeName;
  final String vechilePlateNo;
  final List<TransactionItem> items;
  final String paymentType;
  final double totalAmount;
  final double paidAmount;
  final double previousBalance;
  final double currentBalance;
  final DateTime timestamp;
  final String updatedAt;
  final String? reason;

  TransactionModel({
    required this.id,
    required this.employeeName,
    required this.vechilePlateNo,
    required this.items,
    required this.paymentType,
    required this.totalAmount,
    required this.paidAmount,
    required this.previousBalance,
    required this.currentBalance,
    required this.timestamp,
    required this.updatedAt,
    this.reason,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
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
      paymentType: data['paymentType'] ?? '',
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      paidAmount: (data['paidAmount'] ?? 0).toDouble(),
      previousBalance: (data['previousBalance'] ?? 0).toDouble(),
      currentBalance: (data['balanceAmount'] ?? data['currentBalance'] ?? 0).toDouble(),
      timestamp: parsedTimestamp,
      updatedAt: parsedUpdatedAt,
      reason: data['reason'],
    );
  }

  // Helper methods
  double get totalPrice => items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);
  String get itemsDisplay => items.asMap().entries.map((entry) {
    int index = entry.key;
    TransactionItem item = entry.value;
    return 'Item ${index + 1}: Qty ${item.quantity} × ₹${item.price} = ₹${item.amount}';
  }).join('\n');
}


class TransactionItem {
  final double price;
  final int quantity;
  final double amount;

  TransactionItem({
    required this.price,
    required this.quantity,
    required this.amount,
  });

  factory TransactionItem.fromMap(Map<String, dynamic> map) {
    return TransactionItem(
      price: (map['price'] ?? 0).toDouble(),
      quantity: (map['quantity'] ?? 0).toInt(),
      amount: (map['amount'] ?? 0).toDouble(),
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
