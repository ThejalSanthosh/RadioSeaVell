import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/transaction_model.dart';
import 'package:radio_sea_well/app/modules/products/model/product_model.dart';
import 'package:radio_sea_well/app/services/firebase_service.dart';

class DashboardController extends GetxController {
  final FirebaseService firebaseService = Get.find<FirebaseService>();

  final RxInt totalInstock = 0.obs;
  final RxInt totalOutstock = 0.obs;
  final RxDouble totalAmount = 0.0.obs;
  final RxDouble totalCredit = 0.0.obs;

  // New additionsfinal selectedStore = Rxn<String>(); // Keep as String for now
  final selectedStore = Rxn<String>(); // Keep as String for now

  final stores = <String>[].obs;
  final storeTransactions = <TransactionModel>[].obs;
  final totalStores = 0.obs;
  final RxInt totalErrors = 0.obs;

  var totalVehicleExpenses = 0.obs;
  var vehicleExpensesAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
    loadStores();
  }

  Future<void> addStore(Map<String, dynamic> storeData) async {
    try {
      await firebaseService.addStore(storeData);
      Get.snackbar(
        'Success',
        'Store added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      loadStores(); // Refresh the stores list
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add store',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

   Future<void> fetchDashboardData() async {
    // Fetch Products
    firebaseService.getProducts().listen((QuerySnapshot snapshot) {
      List<Product> products = snapshot.docs.map((doc) {
        return Product.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();
      calculateProductStats(products);
    });

    // Fetch Transactions
    FirebaseFirestore.instance
        .collection('transactions')
        .snapshots()
        .listen((snapshot) {
      calculateTransactionStats(snapshot.docs);
    });
     FirebaseFirestore.instance.collection('transactionUpdateHistory').get().then((snapshot) {
    totalErrors.value = snapshot.docs.length;
  });

  
      // Fetch vehicle expenses count and total amount
      final vehicleExpensesSnapshot = await FirebaseFirestore.instance.collection('vehicleExpenses').get();
      totalVehicleExpenses.value = vehicleExpensesSnapshot.docs.length;
      
      // Calculate total vehicle expenses amount
      double totalAmount = 0.0;
      for (var doc in vehicleExpensesSnapshot.docs) {
        totalAmount += (doc.data()['amount'] as num).toDouble();
      }
      vehicleExpensesAmount.value = totalAmount;
  }

  void calculateTransactionStats(List<DocumentSnapshot> transactions) {
    print('Transaction Documents Length: ${transactions.length}');
    
    // Calculate total outstock quantity
    totalOutstock.value = transactions.fold<int>(
        0, 
        (sum, doc) {
          final data = doc.data() as Map<String, dynamic>;
          final quantity = data['quantity'] as int? ?? 0;
          print('Transaction Quantity: $quantity');
          return sum + quantity;
        }
    );
    print('Total Outstock: ${totalOutstock.value}');

    // Calculate total paid amount and credit
    double totalPaid = 0.0;
    double totalBalance = 0.0;

    for (var transaction in transactions) {
      final data = transaction.data() as Map<String, dynamic>;
      final paid = (data['paidAmount'] as num).toDouble();
      final balance = (data['balanceAmount'] as num).toDouble();
      
      print('Paid Amount: $paid');
      print('Balance Amount: $balance');
      
      totalPaid += paid;
      totalBalance += balance;
    }

    totalAmount.value = totalPaid;
    totalCredit.value = totalBalance;
    
    print('Final Total Amount: ${totalAmount.value}');
    print('Final Total Credit: ${totalCredit.value}');
}

void calculateProductStats(List<Product> products) {
    print('Products Length: ${products.length}');
    
    totalInstock.value = products
        .where((p) => p.type == 'instock'|| p.type == 'return')
        .fold(0, (sum, p) {
          print('Product Quantity: ${p.quantity}');
          return sum + (p.quantity ?? 0);
        });
        
    print('Total Instock: ${totalInstock.value}');
}
  void loadStores() {
    firebaseService.getStores().listen((QuerySnapshot snapshot) {
      stores.value =
          snapshot.docs.map((doc) => doc.get('name') as String).toList();
      totalStores.value = stores.length;
    });
  }

void loadStoreTransactions() {
  if (selectedStore.value == null || selectedStore.value!.isEmpty) return;

  print("Selected store: ${selectedStore.value}"); // Add logging

  firebaseService.getStoreTransactions(selectedStore.value!).listen(
    (QuerySnapshot snapshot) {
      print("Received ${snapshot.docs.length} documents"); // Add logging
      
      storeTransactions.value = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        print("Document data: $data"); // Add logging
        
        return TransactionModel.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();
      
      print("Processed ${storeTransactions.value.length} transactions"); // Add logging
    },
  );
}


// Future<void> updateTransaction(String id, Map<String, dynamic> updatedData) async {
//   await firebaseService.updateTransaction(id, updatedData);
//   loadStoreTransactions();
// }
  
Future<void> updateTransaction(String id, Map<String, dynamic> updatedData) async {
  try {
    // Get the original transaction data before updating
    DocumentSnapshot originalDoc = await     FirebaseFirestore.instance
.collection('transactions').doc(id).get();
    Map<String, dynamic> originalData = originalDoc.data() as Map<String, dynamic>;
    
    // Extract the reason and remove it from the data to be updated
    String reason = updatedData['reason'] ?? 'No reason provided';
    updatedData.remove('reason');
    
    // Create update history record
    Map<String, dynamic> historyRecord = {
      'transactionId': id,
      'originalData': originalData,
      'updatedData': updatedData,
      'updatedBy':  'Admin',
      'updatedAt': FieldValue.serverTimestamp(),
      'storeName': originalData['storeName'] ?? '',
      'reason': reason,
    };
    
    // Add to update history collection
    await   FirebaseFirestore.instance
.collection('transactionUpdateHistory').add(historyRecord);
    
    // Update the original transaction
    await     FirebaseFirestore.instance
.collection('transactions').doc(id).update(updatedData);
    
    Get.snackbar(
      'Success',
      'Transaction updated successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  } catch (e) {
    print('Error updating transaction: $e');
    Get.snackbar(
      'Error',
      'Failed to update transaction: $e',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}


  Future<void> deleteTransaction(String id) async {
    await firebaseService.deleteTransaction(id);
    loadStoreTransactions();
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      final product = Product( 
        id: '',
        price: productData['price'].toDouble(),
        quantity: productData['quantity'],
        type: productData['type'],
        dateAdded: DateTime.parse(productData['dateAdded']),
      );
      
      await firebaseService.addProduct(product);
      
      Get.snackbar(
        'Success', 
        'Product added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2)
      );
      
      fetchDashboardData(); // Refresh dashboard data
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add product: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
    }
  }

  int calculateTotal(int quantity, int price) {
    return quantity * price;
  }
}
