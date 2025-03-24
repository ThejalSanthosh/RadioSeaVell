
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/updateHistory_model.dart';

class UpdateHistoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final RxList<UpdateHistoryModel> updateHistory = <UpdateHistoryModel>[].obs;
  final RxList<UpdateHistoryModel> filteredHistory = <UpdateHistoryModel>[].obs;
  final RxList<String> stores = <String>[].obs;
  final RxList<String> employees = <String>[].obs;
  final RxString selectedStore = ''.obs;
  final RxString selectedEmployee = ''.obs;
  final RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadStores();
    loadEmployees();
    loadUpdateHistory();
  }
  
  Future<void> loadStores() async {
    try {
      final storesSnapshot = await _firestore.collection('stores').get();
      stores.value = storesSnapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      print('Error loading stores: $e');
    }
  }
  
  Future<void> loadEmployees() async {
    try {
      // Get unique employee names from transaction history
      final employeeSnapshot = await _firestore
          .collection('transactionUpdateHistory')
          .get();
          
      Set<String> uniqueEmployees = {};
      for (var doc in employeeSnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        if (data['originalData'] != null && 
            data['originalData']['employeeName'] != null) {
          uniqueEmployees.add(data['originalData']['employeeName']);
        }
      }
      
      employees.value = uniqueEmployees.toList()..sort();
    } catch (e) {
      print('Error loading employees: $e');
    }
  }
  
  Future<void> loadUpdateHistory() async {
    isLoading.value = true;
    try {
      final historySnapshot = await _firestore
          .collection('transactionUpdateHistory')
          .orderBy('updatedAt', descending: true)
          .get();
          
      updateHistory.value = historySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        
        // Extract changed fields by comparing original and updated data
        Map<String, dynamic> originalData = data['originalData'] ?? {};
        Map<String, dynamic> updatedData = data['updatedData'] ?? {};
        
        List<String> changedFields = [];
        updatedData.forEach((key, value) {
          // Check if the field exists in original data and has a different value
          if (originalData.containsKey(key) && originalData[key] != value) {
            changedFields.add(key);
          }
        });
        
        return UpdateHistoryModel(
          id: doc.id,
          transactionId: data['transactionId'] ?? '',
          storeName: data['storeName'] ?? '',
          employeeName: originalData['employeeName'] ?? 'Unknown',
          updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          originalData: originalData,
          updatedData: updatedData,
          changedFields: changedFields,
          reason: data['reason'] ?? 'No reason provided',
        );
      }).toList();
      
      filterUpdateHistory();
    } catch (e) {
      print('Error loading update history: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  void filterUpdateHistory() {
    filteredHistory.value = updateHistory;
    
    if (selectedStore.value.isNotEmpty) {
      filteredHistory.value = filteredHistory
          .where((history) => history.storeName == selectedStore.value)
          .toList();
    }
    
    if (selectedEmployee.value.isNotEmpty) {
      filteredHistory.value = filteredHistory
          .where((history) => history.employeeName == selectedEmployee.value)
          .toList();
    }
  }
  
  // Get error frequency by employee
  Map<String, int> getErrorsByEmployee() {
    Map<String, int> errorCount = {};
    for (var history in updateHistory) {
      if (errorCount.containsKey(history.employeeName)) {
        errorCount[history.employeeName] = errorCount[history.employeeName]! + 1;
      } else {
        errorCount[history.employeeName] = 1;
      }
    }
    return errorCount;
  }
  
  // Get most common error fields
  Map<String, int> getMostCommonErrors() {
    Map<String, int> fieldErrorCount = {};
    for (var history in updateHistory) {
      for (var field in history.changedFields) {
        if (fieldErrorCount.containsKey(field)) {
          fieldErrorCount[field] = fieldErrorCount[field]! + 1;
        } else {
          fieldErrorCount[field] = 1;
        }
      }
    }
    return fieldErrorCount;
  }
}