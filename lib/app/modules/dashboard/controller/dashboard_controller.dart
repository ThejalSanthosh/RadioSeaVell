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
  final RxDouble totalCash = 0.0.obs;
final RxDouble totalUpi = 0.0.obs;


  // New additionsfinal selectedStore = Rxn<String>(); // Keep as String for now
  final selectedStore = Rxn<String>(); // Keep as String for now

  final stores = <String>[].obs;
  final storeTransactions = <TransactionModel>[].obs;
  final totalStores = 0.obs;
  final RxInt totalErrors = 0.obs;

  var totalVehicleExpenses = 0.obs;
  var vehicleExpensesAmount = 0.0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchDashboardData();
    loadStores();
    // await seedPriceMaster(priceMasterRadio);
    // await seedPriceMaster(priceMasterSavi);
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
      List<Product> products =
          snapshot.docs.map((doc) {
            return Product.fromJson({
              ...doc.data() as Map<String, dynamic>,
              'id': doc.id,
            });
          }).toList();
      calculateProductStats(products);
    });

    // Fetch Transactions
    FirebaseFirestore.instance.collection('transactions').snapshots().listen((
      snapshot,
    ) {
      calculateTransactionStats(snapshot.docs);
    });
    FirebaseFirestore.instance
        .collection('transactionUpdateHistory')
        .get()
        .then((snapshot) {
          totalErrors.value = snapshot.docs.length;
        });

    // Fetch vehicle expenses count and total amount
    final vehicleExpensesSnapshot =
        await FirebaseFirestore.instance.collection('vehicleExpenses').get();
    totalVehicleExpenses.value = vehicleExpensesSnapshot.docs.length;

    // Calculate total vehicle expenses amount
    double totalAmount = 0.0;
    for (var doc in vehicleExpensesSnapshot.docs) {
      totalAmount += (doc.data()['amount'] as num).toDouble();
    }
    vehicleExpensesAmount.value = totalAmount;
  }
  DateTime? _parseUpdatedAt(dynamic value) {
  if (value == null) return null;

  if (value is Timestamp) {
    return value.toDate();
  }

  if (value is String) {
    return DateTime.tryParse(value);
  }

  return null;
}

void calculateTransactionStats(List<DocumentSnapshot> transactions) {
  int outstockSum = 0;

  double cashSum = 0.0;
  double upiSum = 0.0;
  double paidSum = 0.0;

  // -------------------------------
  // Totals
  // -------------------------------
  for (var doc in transactions) {
    final data = doc.data() as Map<String, dynamic>;

    // ✅ Outstock quantity
    if (data['items'] is List) {
      for (var item in data['items']) {
        final qty = item['quantity'];
        if (qty is int) outstockSum += qty;
        if (qty is double) outstockSum += qty.toInt();
      }
    }

    // ✅ Payment split
    final payment = data['payment'] as Map<String, dynamic>? ?? {};
    final cash = (payment['cash'] ?? 0).toDouble();
    final upi = (payment['upi'] ?? 0).toDouble();

    cashSum += cash;
    upiSum += upi;
    paidSum += cash + upi;
  }

  totalOutstock.value = outstockSum;
  totalCash.value = cashSum;
  totalUpi.value = upiSum;
  totalAmount.value = paidSum;

  // -------------------------------
  // ✅ Latest credit per store (FIXED)
  // -------------------------------
  final Map<String, Map<String, dynamic>> latestByStore = {};

  for (var transaction in transactions) {
    final data = transaction.data() as Map<String, dynamic>;
    final storeId = data['storeId'] as String?;

    if (storeId == null) continue;

    final updatedAt = _parseUpdatedAt(data['UpdatedAt']);
    if (updatedAt == null) continue;

    if (!latestByStore.containsKey(storeId)) {
      latestByStore[storeId] = data;
    } else {
      final existing = latestByStore[storeId]!;
      final existingTime = _parseUpdatedAt(existing['UpdatedAt']);

      if (existingTime == null || updatedAt.isAfter(existingTime)) {
        latestByStore[storeId] = data;
      }
    }
  }

  totalCredit.value = latestByStore.values.fold(
    0.0,
    (sum, data) =>
        sum + ((data['balanceAmount'] as num?)?.toDouble() ?? 0.0),
  );
}


  void calculateProductStats(List<Product> products) {
    print('Products Length: ${products.length}');

    totalInstock.value = products
        .where((p) => p.type == 'instock' || p.type == 'return')
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

  final List<Map<String, dynamic>> priceMasterRadio = [
    {"priceLabel": "5-M", "packSize": 5, "category": "Radio", "price": 42},
    {"priceLabel": "5-B", "packSize": 5, "category": "Radio", "price": 42},
    {"priceLabel": "5-AI", "packSize": 5, "category": "Radio", "price": 42},

    {"priceLabel": "10-M", "packSize": 10, "category": "Radio", "price": 84},
    {"priceLabel": "10-AI", "packSize": 10, "category": "Radio", "price": 84},
    {"priceLabel": "10-SP", "packSize": 10, "category": "Radio", "price": 84},
    {"priceLabel": "10-B", "packSize": 10, "category": "Radio", "price": 84},

    {"priceLabel": "15-M", "packSize": 15, "category": "Radio", "price": 125},

    {"priceLabel": "20-M", "packSize": 20, "category": "Radio", "price": 170},
    {"priceLabel": "20-AI", "packSize": 20, "category": "Radio", "price": 170},
    {"priceLabel": "20-B-", "packSize": 20, "category": "Radio", "price": 170},

    {"priceLabel": "50-GM", "packSize": 50, "category": "Radio", "price": 300},
    {"priceLabel": "50-GN", "packSize": 50, "category": "Radio", "price": 300},
  ];

  final List<Map<String, dynamic>> priceMasterSavi = [
    {"priceLabel": "5-M-40", "packSize": 5, "category": "Savi", "price": 40},
    {"priceLabel": "5-B-40", "packSize": 5, "category": "Savi", "price": 40},
    {"priceLabel": "5-AI-40", "packSize": 5, "category": "Savi", "price": 40},

    {"priceLabel": "10-M-80", "packSize": 10, "category": "Savi", "price": 80},
    {"priceLabel": "10-AI-80", "packSize": 10, "category": "Savi", "price": 80},
    {"priceLabel": "10-B-80", "packSize": 10, "category": "Savi", "price": 80},

    {
      "priceLabel": "15-N-120",
      "packSize": 15,
      "category": "Savi",
      "price": 120,
    },

    {
      "priceLabel": "20-M-160",
      "packSize": 20,
      "category": "Savi",
      "price": 160,
    },
    {
      "priceLabel": "20-N-160",
      "packSize": 20,
      "category": "Savi",
      "price": 160,
    },
    {
      "priceLabel": "20-B-160",
      "packSize": 20,
      "category": "Savi",
      "price": 160,
    },

    {
      "priceLabel": "50-M-250",
      "packSize": 50,
      "category": "Savi",
      "price": 250,
    },
  ];

  Future<void> seedPriceMaster(List<Map<String, dynamic>> prices) async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    for (final item in prices) {
      final docRef = firestore.collection('priceMaster').doc();

      batch.set(docRef, {
        ...item,
        "isActive": true,
        "createdAt": FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
    print("✅ Price master seeded: ${prices.length} items");
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      final product = Product(
        id: '',
        price: productData['price'],
        priceLabel: productData['priceLabel'],
        category: productData['category'],
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
        duration: Duration(seconds: 2),
      );

      fetchDashboardData(); // Refresh dashboard data
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add product: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  int calculateTotal(int quantity, int price) {
    return quantity * price;
  }

  void loadStoreTransactions() async {
    if (selectedStore.value == null || selectedStore.value!.isEmpty) return;

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection('transactions')
              .where('storeName', isEqualTo: selectedStore.value)
              .orderBy('timestamp', descending: true)
              .get();

      storeTransactions.value =
          snapshot.docs
              .map((doc) => TransactionModel.fromFirestore(doc))
              .toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load transactions: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {}
  }

  // Update transaction method
  // Update transaction method with proper error handling
  void updateTransaction(
    String transactionId,
    Map<String, dynamic> updatedData,
  ) async {
    try {
      // Ensure UpdatedAt is properly set
      updatedData['UpdatedAt'] = FieldValue.serverTimestamp();

      await FirebaseFirestore.instance
          .collection('transactions')
          .doc(transactionId)
          .update(updatedData);

      Get.snackbar(
        'Success',
        'Transaction updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Reload transactions to reflect changes
      loadStoreTransactions();
    } catch (e) {
      print('Update error: $e'); // For debugging
      Get.snackbar(
        'Error',
        'Failed to update transaction: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

Future<void> deleteTransaction(String transactionId) async {
  final firestore = FirebaseFirestore.instance;

  try {
    await firestore.runTransaction((trx) async {
      final txRef = firestore.collection('transactions').doc(transactionId);
      final txSnap = await trx.get(txRef);

      if (!txSnap.exists) {
        throw Exception('Transaction not found');
      }

      final data = txSnap.data() as Map<String, dynamic>;

      final String vehicleId = data['vehicleId'];
      final String employeeId = data['employeeId'];
      final String storeId = data['storeId'];

      final double previousBalance =
          (data['previousBalance'] as num?)?.toDouble() ?? 0.0;

      final List items = data['items'] ?? [];

      // 🔁 1️⃣ RESTORE VEHICLE STOCK
      for (final item in items) {
        final String priceLabel = item['priceLabel'];
        final int quantity = item['quantity'];

        // ⚠️ Query must be OUTSIDE transaction → get refs first
        final qs = await firestore
            .collection('outstocks')
            .where('vehicleId', isEqualTo: vehicleId)
            .where('employeeId', isEqualTo: employeeId)
            .where('priceLabel', isEqualTo: priceLabel)
            .limit(1)
            .get();

        if (qs.docs.isNotEmpty) {
          trx.update(qs.docs.first.reference, {
            'quantity': FieldValue.increment(quantity),
            'lastUpdated': FieldValue.serverTimestamp(),
          });
        } else {
          final newRef = firestore.collection('outstocks').doc();
          trx.set(newRef, {
            'vehicleId': vehicleId,
            'employeeId': employeeId,
            'priceLabel': priceLabel,
            'quantity': quantity,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }

      // 🔁 2️⃣ RESTORE STORE CREDIT
      final storeRef = firestore.collection('stores').doc(storeId);
      trx.update(storeRef, {
        'balanceAmount': previousBalance,
        'lastUpdated': FieldValue.serverTimestamp(),
      });

      // ❌ 3️⃣ DELETE TRANSACTION
      trx.delete(txRef);
    });

    // ✅ 4️⃣ UPDATE UI IMMEDIATELY
    storeTransactions.removeWhere((t) => t.id == transactionId);

    Get.snackbar(
      'Success',
      'Transaction deleted and vehicle stock restored',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

  } catch (e) {
    Get.snackbar(
      'Error',
      'Delete failed: $e',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}


//   Future<void> deleteTransaction(String transactionId) async {
//     try {
//       await FirebaseFirestore.instance.runTransaction((trx) async {
//         final transactionRef = FirebaseFirestore.instance
//             .collection('transactions')
//             .doc(transactionId);

//         final snapshot = await trx.get(transactionRef);
//         if (!snapshot.exists) {
//           throw Exception('Transaction not found');
//         }

//         final data = snapshot.data() as Map<String, dynamic>;
//         final List items = data['items'] ?? [];

//         final String vehicleId = data['vehicleId'];
//         final String employeeId = data['employeeId'];

//         // 🔁 Restore stock to VEHICLE STOCK
//         for (var item in items) {
//           final String price = item['priceString'] ?? item['price'].toString();
//           final int quantity = item['quantity'];

//           final outstockQuery =
//               await FirebaseFirestore.instance
//                   .collection('outstocks')
//                   .where('vehicleId', isEqualTo: vehicleId)
//                   .where('employeeId', isEqualTo: employeeId)
//                   .where('price', isEqualTo: price)
//                   .limit(1)
//                   .get();

//           if (outstockQuery.docs.isNotEmpty) {
//             // ✅ Update existing vehicle stock
//             trx.update(outstockQuery.docs.first.reference, {
//               'quantity': FieldValue.increment(quantity),
//               'lastUpdated': DateTime.now().toIso8601String(),
//             });
//           } else {
//             // ✅ Create new vehicle stock entry
//             trx.set(FirebaseFirestore.instance.collection('outstocks').doc(), {
//               'vehicleId': vehicleId,
//               'employeeId': employeeId,
//               'price': price,
//               'quantity': quantity,
//               'dateCreated': DateTime.now().toIso8601String(),
//             });
//           }
//         }

//         // ❌ Delete the transaction
//         trx.delete(transactionRef);
//       });
//  storeTransactions.removeWhere((t) => t.id == transactionId);

//     Get.snackbar(
//       'Success',
//       'Transaction deleted and vehicle stock restored',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//     );

//     // Optional background refresh
//     // loadStoreTransactions();
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to delete transaction: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
}
