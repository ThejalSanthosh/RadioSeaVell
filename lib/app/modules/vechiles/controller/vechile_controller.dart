import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radio_sea_well/app/modules/vechiles/model/vechile_model.dart';

class VehiclesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final vehicles = <Vehicle>[].obs;
  final isLoading = false.obs;

  // Form controllers
  final nameController = TextEditingController();
  final modelController = TextEditingController();
  final plateNumberController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchVehicles();
  }

  @override
  void onClose() {
    nameController.dispose();
    modelController.dispose();
    plateNumberController.dispose();
    super.onClose();
  }

  void fetchVehicles() {
    isLoading.value = true;
    try {
      _firestore.collection('vehicles').snapshots().listen((snapshot) {
        vehicles.value =
            snapshot.docs
                .map((doc) => Vehicle.fromJson({...doc.data(), 'id': doc.id}))
                .toList();
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch vehicles');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addVehicle() async {
    if (!validateForm()) {
      return;
    }

    isLoading.value = true;
    try {
      await _firestore.collection('vehicles').add({
        'name': nameController.text.trim(),
        'model': modelController.text.trim(),
        'plateNumber': plateNumberController.text.trim(),
        'createdAt': DateTime.now().toIso8601String(),
        'status': 'active',
      });

      clearForm();
      Get.back();
      Get.snackbar(
        'Success',
        'Vehicle added successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add vehicle: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error adding vehicle: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateVehicle(String docId) async {
    if (!validateForm()) return;

    isLoading.value = true;
    try {
      await _firestore.collection('vehicles').doc(docId).update({
        'name': nameController.text,
        'model': modelController.text,
        'plateNumber': plateNumberController.text,
        'updatedAt': DateTime.now(),
      });

      clearForm();
      Get.back();
      Get.snackbar('Success', 'Vehicle updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update vehicle');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteVehicle(String docId) async {
    try {
      await _firestore.collection('vehicles').doc(docId).delete();
      Get.snackbar('Success', 'Vehicle deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete vehicle');
    }
  }

  bool validateForm() {
    if (nameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Vehicle name is required',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    if (modelController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Vehicle model is required',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    if (plateNumberController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Plate number is required',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  void clearForm() {
    nameController.clear();
    modelController.clear();
    plateNumberController.clear();
  }

  void setVehicleData(Vehicle vehicle) {
    nameController.text = vehicle.name;
    modelController.text = vehicle.model;
    plateNumberController.text = vehicle.plateNumber;
  }

  // Search functionality
  final searchQuery = ''.obs;

  List<Vehicle> get filteredVehicles =>
      vehicles.where((vehicle) {
        final query = searchQuery.value.toLowerCase();
        return vehicle.name.toLowerCase().contains(query) ||
            vehicle.plateNumber.toLowerCase().contains(query);
      }).toList();
}
