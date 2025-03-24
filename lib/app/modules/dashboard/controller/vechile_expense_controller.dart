import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/vechile_expense_model.dart';
import 'package:radio_sea_well/app/modules/employees/model/employee_model.dart';
import 'package:radio_sea_well/app/modules/vechiles/model/vechile_model.dart';


class VehicleExpenseController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  
  // Form controllers
  final amountController = TextEditingController();
  final odometerController = TextEditingController();
  final notesController = TextEditingController();
  
  // Observable variables
  var isLoading = true.obs;
  var isSubmitting = false.obs;
  var selectedVehicleId = ''.obs;
  var selectedEmployeeId = ''.obs;
  var expenseType = ''.obs;
  var expenseDate = DateTime.now().obs;
  
  // Filter variables
  var selectedFilterVehicleId = 'all'.obs;
  
  // Data lists
  var vehicles = <Vehicle>[].obs;
  var employees = <Employee>[].obs;
  var expenses = <VehicleExpense>[].obs;
  var filteredExpenses = <VehicleExpense>[].obs;
  
  // Maps for quick lookups
  final vehicleMap = <String, Vehicle>{}.obs;
  final employeeMap = <String, Employee>{}.obs;
  
  // Expense types
  final expenseTypes = [
    'Fuel',
    'Maintenance',
    'Repair',
    'Insurance',
    'Registration',
    'Toll',
    'Parking',
    'Other'
  ];
  
  @override
  void onInit() {
    super.onInit();
    fetchVehicles();
    fetchEmployees();
    fetchVehicleExpenses();
    expenseType.value = expenseTypes.first;
  }
  
  void fetchVehicles() {
    firestore.collection('vehicles').snapshots().listen((snapshot) {
      vehicles.value = snapshot.docs
          .map(
            (doc) => Vehicle.fromJson({'id': doc.id, ...doc.data()}),
          )
          .toList();
      
      // Create a map for quick lookups
      vehicleMap.clear();
      for (var vehicle in vehicles) {
        vehicleMap[vehicle.id] = vehicle;
      }
      
      // Set default value if available
      if (vehicles.isNotEmpty && selectedVehicleId.isEmpty) {
        selectedVehicleId.value = vehicles.first.id;
      }
    });
  }
  
  void fetchEmployees() {
    firestore.collection('employees').snapshots().listen((snapshot) {
      employees.value = snapshot.docs
          .map(
            (doc) => Employee.fromJson({'id': doc.id, ...doc.data()}),
          )
          .toList();
      
      // Create a map for quick lookups
      employeeMap.clear();
      for (var employee in employees) {
        employeeMap[employee.id] = employee;
      }
      
      // Set default value if available
      if (employees.isNotEmpty && selectedEmployeeId.isEmpty) {
        selectedEmployeeId.value = employees.first.id;
      }
    });
  }
  
  void fetchVehicleExpenses() {
    isLoading.value = true;
    
    firestore.collection('vehicleExpenses')
        .orderBy('date', descending: true) // Sort by date, newest first
        .snapshots()
        .listen((snapshot) {
      expenses.value = snapshot.docs
          .map(
            (doc) => VehicleExpense.fromJson({'id': doc.id, ...doc.data()}),
          )
          .toList();
      
      // Initialize filtered expenses
      filterExpenses();
      
      isLoading.value = false;
    }, onError: (error) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load expenses: ${error.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
    });
  }
  
  void filterExpenses() {
    if (selectedFilterVehicleId.value == 'all') {
      filteredExpenses.value = expenses;
    } else {
      filteredExpenses.value = expenses.where(
        (expense) => expense.vehicleId == selectedFilterVehicleId.value
      ).toList();
    }
  }
  
  Vehicle? getVehicleById(String id) {
    return vehicleMap[id];
  }
  
  Employee? getEmployeeById(String id) {
    return employeeMap[id];
  }
}