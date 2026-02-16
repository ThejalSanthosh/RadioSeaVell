import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  final String id;
  final String name;
  final String address;
  final String district;
  final String phone;
  final String email;
  final double balanceAmount;
  final DateTime updatedAt;

  StoreModel({
    required this.id,
    required this.name,
    required this.address,
    required this.district,
    required this.phone,
    required this.email,
    required this.balanceAmount,
    required this.updatedAt,
  });

  factory StoreModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return StoreModel(
      id: doc.id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      district: data['district'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      balanceAmount: (data['balanceAmount'] ?? 0).toDouble(),
      updatedAt: data['UpdatedAt'] is Timestamp
          ? (data['UpdatedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
