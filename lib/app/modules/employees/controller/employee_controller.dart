import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radio_sea_well/app/modules/employees/model/employee_model.dart';

class EmployeesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final employees = <Employee>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  // Form controllers
  final nameController = TextEditingController();
  final employeeIdController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  @override
  void onClose() {
    nameController.dispose();
    employeeIdController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void fetchEmployees() {
    isLoading.value = true;
    try {
      _firestore
          .collection('employees')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
            employees.value =
                snapshot.docs
                    .map(
                      (doc) => Employee.fromJson({...doc.data(), 'id': doc.id}),
                    )
                    .toList();
            isLoading.value = false;
          });
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to fetch employees',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> addEmployee() async {
    if (!validateForm()) return;

    isLoading.value = true;
    try {
      await _firestore.collection('employees').add({
        'name': nameController.text.trim(),
        'employeeId': employeeIdController.text.trim(),
        'phoneNo': phoneController.text.trim(),
        'createdAt': DateTime.now().toIso8601String(),
        'status': 'active',
      });

      clearForm();
      Get.back();
      Get.snackbar(
        'Success',
        'Employee added successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add employee',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateEmployee(String id) async {
    if (!validateForm()) return;

    isLoading.value = true;
    try {
      await _firestore.collection('employees').doc(id).update({
        'name': nameController.text.trim(),
        'employeeId': employeeIdController.text.trim(),
        'phone': phoneController.text.trim(),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      clearForm();
      Get.back();
      Get.snackbar(
        'Success',
        'Employee updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update employee',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      await _firestore.collection('employees').doc(id).delete();
      Get.snackbar(
        'Success',
        'Employee deleted successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete employee',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool validateForm() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Name is required',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }
    if (employeeIdController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Employee ID is required',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Phone number is required',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }
    return true;
  }

  void clearForm() {
    nameController.clear();
    employeeIdController.clear();
    phoneController.clear();
  }

  void setEmployeeData(Employee employee) {
    nameController.text = employee.name;
    employeeIdController.text = employee.employeeId;
    phoneController.text = employee.phoneNo ?? '';
  }

  List<Employee> get filteredEmployees =>
      employees.where((employee) {
        final query = searchQuery.value.toLowerCase();
        return employee.name.toLowerCase().contains(query) ||
            employee.employeeId.toLowerCase().contains(query) ||
            (employee.phoneNo?.toLowerCase().contains(query) ?? false);
      }).toList();
}
