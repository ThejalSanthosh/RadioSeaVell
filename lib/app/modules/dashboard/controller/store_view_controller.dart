import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/store_view_model.dart';

class StoreController extends GetxController {
  final stores = <StoreModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadStores();
  }

  void loadStores() {
    isLoading.value = true;

    FirebaseFirestore.instance
        .collection('stores')
        .orderBy('name')
        .snapshots()
        .listen((snapshot) {
          stores.value =
              snapshot.docs
                  .map((doc) => StoreModel.fromFirestore(doc))
                  .toList();
          isLoading.value = false;
        });
  }

  // Future<void> updateStore({
  //   required StoreModel store,
  //   required String name,
  //   required String address,
  //   required String district,
  //   required String phone,
  //   required String email,
  //   required double balanceAmount,
  //   required String reason,
  // }) async {
  //   if (reason.trim().isEmpty) {
  //     Get.snackbar(
  //       'Reason Required',
  //       'Please enter reason for updating store',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     return;
  //   }

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('stores')
  //         .doc(store.id)
  //         .update({
  //           'name': name.trim(),
  //           'address': address.trim(),
  //           'district': district.trim(),
  //           'phone': phone.trim(),
  //           'email': email.trim(),
  //           'balanceAmount': balanceAmount,
  //           'currentBalance': balanceAmount, // ✅ IMPORTANT
  //           'UpdatedAt': DateTime.now(),
  //         });

  //     await FirebaseFirestore.instance.collection('storeUpdateHistory').add({
  //       'storeId': store.id,
  //       'name': name.trim(),
  //       'address': address.trim(),
  //       'district': district.trim(),
  //       'phone': phone.trim(),
  //       'email': email.trim(),
  //       'oldBalance': store.balanceAmount,
  //       'newBalance': balanceAmount,
  //       'reason': reason.trim(),
  //       'updatedAt': DateTime.now(),
  //     });

  //     Get.back(); // ✅ close dialog only after success

  //     Get.snackbar(
  //       'Success',
  //       'Store updated successfully',
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to update store: $e',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   }
  // }


  Future<void> updateStore({
  required StoreModel store,
  required String name,
  required String address,
  required String district,
  required String phone,
  required String email,
  required double balanceAmount,
  required String reason,
}) async {
  if (reason.trim().isEmpty) {
    Get.snackbar(
      'Reason Required',
      'Please enter reason for updating store',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
    return; // ⛔ STOP update
  }

  try {
    final firestore = FirebaseFirestore.instance;

    // 1️⃣ UPDATE STORE (ALWAYS)
    await firestore.collection('stores').doc(store.id).update({
      'name': name.trim(),
      'address': address.trim(),
      'district': district.trim(),
      'phone': phone.trim(),
      'email': email.trim(),
      'balanceAmount': balanceAmount,
      'currentBalance': balanceAmount, // ✅ FIXED
      'UpdatedAt': DateTime.now(),
    });

    // 2️⃣ GET LATEST TRANSACTION (ONLY ONE)
    final txSnapshot = await firestore
        .collection('transactions')
        .where('storeId', isEqualTo: store.id)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    // 3️⃣ UPDATE ONLY IF TRANSACTION EXISTS
    if (txSnapshot.docs.isNotEmpty) {
      final txDoc = txSnapshot.docs.first;
      final txData = txDoc.data();

      final double previousBalance =
          (txData['previousBalance'] ?? 0).toDouble();

      await txDoc.reference.update({
        'previousBalance': previousBalance,
        'creditAmount': balanceAmount,
        'balanceAmount': balanceAmount,
        'isCredit': balanceAmount > 0,
        'UpdatedAt': DateTime.now(),
      });
    }

    // 4️⃣ STORE UPDATE HISTORY
    await firestore.collection('storeUpdateHistory').add({
      'storeId': store.id,
      'oldBalance': store.balanceAmount,
      'newBalance': balanceAmount,
      'name': name.trim(),
      'address': address.trim(),
      'district': district.trim(),
      'phone': phone.trim(),
      'reason': reason.trim(),
      'updatedAt': DateTime.now(),
    });
 Get.back();
    Get.snackbar(
      'Success',
      txSnapshot.docs.isEmpty
          ? 'Store updated (no transactions found)'
          : 'Store & latest transaction updated',
     backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  } catch (e) {
    Get.snackbar(
      'Error',
      'Failed to update store: $e',
       backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
}

}
