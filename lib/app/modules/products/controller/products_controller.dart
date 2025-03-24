import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:radio_sea_well/app/modules/products/model/product_model.dart';
import 'package:radio_sea_well/app/services/firebase_service.dart';
class ProductController extends GetxController {
    final FirebaseService firebaseService = Get.find<FirebaseService>();

  final quantityController = TextEditingController();
  final selectedPrice = 5.obs;
  final prices = [5, 10, 15, 20, 25, 30].obs;

  String calculateTotal() {
    int quantity = int.tryParse(quantityController.text) ?? 0;
    return (quantity * selectedPrice.value).toString();
  }

 Future<void> saveProduct() async {
  if (quantityController.text.isEmpty) {
    Get.snackbar('Error', 'Please enter quantity');
    return;
  }

  try {
    final product = Product(
      id: '',
      price: selectedPrice.value.toDouble(),
      quantity: int.parse(quantityController.text),
      type: 'instock',
      dateAdded: DateTime.now(),
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
    await Future.delayed(Duration(seconds: 1));
    Get.back();
    
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

  @override
  void onClose() {
    quantityController.dispose();
    super.onClose();
  }
}