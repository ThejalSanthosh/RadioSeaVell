class InstockProduct {
  final String id;  // Document ID from Firestore
  final String dateAdded;
  final double price;
  final int quantity;
  final String type;
  final String? vehicleId;
  final String? employeeId;

  InstockProduct({
    required this.id,
    required this.dateAdded,
    required this.price,
    required this.quantity,
    required this.type,
    this.vehicleId,
    this.employeeId,
  });

  factory InstockProduct.fromJson(Map<String, dynamic> json) {
    return InstockProduct(
      id: json['id'] ?? '',  
      dateAdded: json['dateAdded'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      type: json['type'] ?? '',
      vehicleId: json['vehicleId'] ?? '',
      employeeId: json['employeeId'] ?? '',
    );
  }
}

// Future<void> updateTransaction(String id, Map<String, dynamic> updatedData) async {
//   // Get the original transaction data before updating
//   DocumentSnapshot originalDoc = await _firestore.collection('transactions').doc(id).get();
//   Map<String, dynamic> originalData = originalDoc.data() as Map<String, dynamic>;
  
//   // Add user info who made the update (assuming you have auth)
//   String updatedBy = FirebaseAuth.instance.currentUser?.email ?? 'Unknown';
  
//   // Create update history record
//   Map<String, dynamic> historyRecord = {
//     'transactionId': id,
//     'originalData': originalData,
//     'updatedData': updatedData,
//     'updatedBy': updatedBy,
//     'updatedAt': FieldValue.serverTimestamp(),
//     'storeName': originalData['storeName'] ?? '',
//   };
  
//   // Add to update history collection
//   await _firestore.collection('transactionUpdateHistory').add(historyRecord);
  
//   // Update the original transaction
//   await _firestore.collection('transactions').doc(id).update(updatedData);
  
//   // Refresh the transactions list
//   loadStoreTransactions();
// }