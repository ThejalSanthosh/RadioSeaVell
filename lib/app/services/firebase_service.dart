import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:radio_sea_well/app/modules/employees/model/employee_model.dart';
import 'package:radio_sea_well/app/modules/products/model/product_model.dart';
import 'package:radio_sea_well/app/modules/vechiles/model/vechile_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addProduct(Product product) async {
    try {
      // Check if product with same price exists
      QuerySnapshot existingProducts =
          await _firestore
              .collection('products')
              .where('price', isEqualTo: product.price)
              .where('type', isEqualTo: product.type)
              .get();

      if (existingProducts.docs.isNotEmpty) {
        // Update existing product quantity
        DocumentReference docRef = existingProducts.docs.first.reference;
        int currentQuantity = existingProducts.docs.first.get('quantity');
        await docRef.update({
          'quantity': currentQuantity + product.quantity,
          'dateAdded': DateTime.now().toIso8601String(),
        });
      } else {
        // Create new product document
        await _firestore.collection('products').add({
          'quantity': product.quantity,
          'price': product.price,
          'type': product.type,
          'dateAdded': product.dateAdded.toIso8601String(),
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product');
      print('Error adding product: $e');
    }
  }

  Future<void> addStore(Map<String, dynamic> storeData) {
    return _firestore.collection('stores').add(storeData);
  }

  Stream<QuerySnapshot> getProducts() {
    return _firestore.collection('products').snapshots();
  }

  // Employee operations
  Future<void> addEmployee(Employee employee) async {
    await _firestore.collection('employees').add(employee.toJson());
  }

  // Vehicle operations
  Future<void> addVehicle(Vehicle vehicle) async {
    await _firestore.collection('vehicles').add(vehicle.toJson());
  }

  Stream<QuerySnapshot> getStores() {
    return _firestore.collection('stores').snapshots();
  }

Stream<QuerySnapshot> getStoreTransactions(String storeName) {
  print("Fetching transactions for store: $storeName"); // Add logging
  return FirebaseFirestore.instance
      .collection('transactions')
      .where('storeName', isEqualTo: storeName)
      .orderBy('timestamp', descending: true)
      .snapshots();
}


  Future<void> updateTransaction(String id, Map<String, dynamic> data) {
    return _firestore.collection('transactions').doc(id).update(data);
  }

  Future<void> deleteTransaction(String id) {
    return _firestore.collection('transactions').doc(id).delete();
  }

  Stream<QuerySnapshot> getTransactions(String storeName) {
    return FirebaseFirestore.instance
        .collection('transactions')
        .where('storeName', isEqualTo: storeName)
        .snapshots();
  }
}
