import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/employee_model.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/instock_product_model.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/outstock_summary_model.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/vehcile_instock_model.dart';


class InstockController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final instockProducts = <InstockProduct>[].obs;
  final vehicles = <VehicleInstock>[].obs;
  final employees = <EmployeeModel>[].obs;
  final outstocks = <OutstockSummary>[].obs;
  final selectedType = 'All'.obs;

  // Maps for quick lookups
  final vehicleMap = <String, VehicleInstock>{}.obs;
  final employeeMap = <String, EmployeeModel>{}.obs;

  // Selection values - change selectedPrice to String
  final selectedVehicleId = ''.obs;
  final selectedEmployeeId = ''.obs;
  final selectedPrice = ''.obs; // Changed from double to String
  final quantity = 0.obs;
  final maxOutstock = 0.obs;
  final currentInstock = 0.obs;
  final isLoading = false.obs;

  // Update total calculation to use String keys
  // final totalInstockQuantity = <String, int>{}.obs; // Changed from <double, int> to <String, int>
final totalInstockQuantity = <String, int>{}.obs; // key = label

  final outstockController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchInstockProducts();
    fetchVehicles();
    fetchEmployees();
    fetchOutstocks();
  }

  void fetchInstockProducts() {
    firestore.collection('products').snapshots().listen((snapshot) {
      instockProducts.value =
          snapshot.docs
              .map(
                (doc) => InstockProduct.fromJson({
                  'id': doc.id, // Pass the document ID
                  ...doc.data(),
                }),
              )
              .toList();
      updateCurrentInstock();
      _calculateTotalInstockByLabel();

      // _calculateTotalInstockByPrice(); // Recalculate totals when data changes
    });
  }

void _calculateTotalInstockByLabel() {
  totalInstockQuantity.clear();

  for (var product in instockProducts) {
    if ((product.type == 'instock' || product.type == 'return') &&
        product.quantity > 0 &&
        product.label != null) {
      totalInstockQuantity[product.label!] =
          (totalInstockQuantity[product.label!] ?? 0) + product.quantity;
    }
  }
}

    void updateCurrentInstock() {
    int total = 0;
    for (var product in instockProducts) {
      if (product.type == 'instock' || product.type == 'return') {
        total += product.quantity;
      } else if (product.type == 'vehicle_stock') {
        total -= product.quantity;
      }
    }
    currentInstock.value = total;
  }
  void prepareForNewSelection() {
    resetForm();
    fetchVehicles();
    fetchOutstocks();
  }
  void fetchVehicles() {
    firestore.collection('vehicles').snapshots().listen((snapshot) {
      vehicles.value =
          snapshot.docs
              .map(
                (doc) => VehicleInstock.fromJson({'id': doc.id, ...doc.data()}),
              )
              .toList();

      // Create a map for quick lookups
      vehicleMap.clear();
      for (var vehicle in vehicles) {
        vehicleMap[vehicle.id] = vehicle;
      }
    });
  }

  void fetchEmployees() {
    firestore.collection('employees').snapshots().listen((snapshot) {
      employees.value =
          snapshot.docs
              .map(
                (doc) => EmployeeModel.fromJson({'id': doc.id, ...doc.data()}),
              )
              .toList();

      // Create a map for quick lookups
      employeeMap.clear();
      for (var employee in employees) {
        employeeMap[employee.id] = employee;
      }
    });
  }

  void fetchOutstocks() {
    firestore.collection('outstocks').snapshots().listen((snapshot) {
      outstocks.value =
          snapshot.docs
              .map(
                (doc) =>
                    OutstockSummary.fromJson({'id': doc.id, ...doc.data()}),
              )
              .toList();
    });
  }

  List<InstockProduct> getFilteredData() {
    switch (selectedType.value) {
      // case 'Instock':
      //   if (totalInstockQuantity.isEmpty) {
      //     _calculateTotalInstockByPrice();
      //   }
        
      //   List<InstockProduct> aggregatedInstock = [];
      //   Map<String, String> latestDates = {}; // Changed key type to String

      //   // Find the most recent date for each price
      //   for (var product in instockProducts) {
      //     if ((product.type == 'instock' || product.type == 'return') &&
      //         product.quantity > 0) {
      //       if (!latestDates.containsKey(product.price) ||
      //           DateTime.parse(product.dateAdded).isAfter(
      //               DateTime.parse(latestDates[product.price]!))) {
      //         latestDates[product.price] = product.dateAdded;
      //       }
      //     }
      //   }

      //   // Create aggregated products
      //   totalInstockQuantity.forEach((price, quantity) {
      //     if (quantity > 0) {
      //       aggregatedInstock.add(
      //         InstockProduct(
      //           id: 'total-$price',
      //           dateAdded: latestDates[price] ?? DateTime.now().toIso8601String(),
      //           price: price, // Now using String price
      //           quantity: quantity,
      //           type: 'instock',
      //           vehicleId: '',
      //           employeeId: '',

                
      //         ),
      //       );
      //     }
      //   });

      //   aggregatedInstock.sort(
      //     (a, b) => DateTime.parse(b.dateAdded).compareTo(DateTime.parse(a.dateAdded)),
      //   );
      //   return aggregatedInstock;

      case 'Instock':
  if (totalInstockQuantity.isEmpty) {
    _calculateTotalInstockByLabel();
  }

  List<InstockProduct> aggregatedInstock = [];
  Map<String, String> latestDates = {};

  // Track latest date per label
  for (var product in instockProducts) {
    if ((product.type == 'instock' || product.type == 'return') &&
        product.quantity > 0 &&
        product.label != null) {
      if (!latestDates.containsKey(product.label!) ||
          DateTime.parse(product.dateAdded).isAfter(
            DateTime.parse(latestDates[product.label!]!),
          )) {
        latestDates[product.label!] = product.dateAdded;
      }
    }
  }

  // Build aggregated rows WITH correct label & category
  totalInstockQuantity.forEach((label, quantity) {
    if (quantity > 0) {
      final source = instockProducts.firstWhere(
        (p) => p.label == label,
      );

      aggregatedInstock.add(
        InstockProduct(
          id: 'total-$label',
          dateAdded: latestDates[label] ?? source.dateAdded,
          price: source.price,          // correct price
          quantity: quantity,
          type: 'instock',
          vehicleId: '',
          employeeId: '',
          label: source.label,           // ✅ REQUIRED
          category: source.category,     // ✅ REQUIRED
        ),
      );
    }
  });

  aggregatedInstock.sort(
    (a, b) =>
        DateTime.parse(b.dateAdded).compareTo(DateTime.parse(a.dateAdded)),
  );

  return aggregatedInstock;


      case 'Vehicle Stock':
        var vehicleStockList = outstocks
            .where((outstock) => outstock.quantity > 0)
            .map((outstock) => InstockProduct(
                  id: outstock.id,
                  dateAdded: outstock.dateCreated,
                  price: outstock.price, // Make sure OutstockSummary.price is also String
                  quantity: outstock.quantity,
                  type: 'vehicle_stock',
                  vehicleId: outstock.vehicleId,
                  employeeId: outstock.employeeId,
                  label: outstock.priceLabel,
                  category: outstock.category

                ))
            .toList();

        vehicleStockList.sort(
          (a, b) => DateTime.parse(b.dateAdded).compareTo(DateTime.parse(a.dateAdded)),
        );
        return vehicleStockList;

         case 'Morning Stock':
      var morningStockList = instockProducts
          .where((p) => p.type == 'morning stock' && p.quantity > 0)
          .toList();
      morningStockList.sort(
        (a, b) => DateTime.parse(b.dateAdded).compareTo(DateTime.parse(a.dateAdded)),
      );
      return morningStockList;


      case 'Return':
        var returnProducts = instockProducts
            .where((p) => p.type == 'return' && p.quantity > 0)
            .toList();

        returnProducts.sort(
          (a, b) => DateTime.parse(b.dateAdded).compareTo(DateTime.parse(a.dateAdded)),
        );
        return returnProducts;

      default:
        return instockProducts;
    }
  }
 void updateMaxOutstock() {
  isLoading.value = true;
  maxOutstock.value = 0; // Reset before fetching
  
  if (selectedVehicleId.value.isNotEmpty &&
      selectedEmployeeId.value.isNotEmpty &&
      selectedPrice.value.isNotEmpty) { // Changed from > 0 to .isNotEmpty
    firestore
        .collection('outstocks')
        .where('vehicleId', isEqualTo: selectedVehicleId.value)
        .where('employeeId', isEqualTo: selectedEmployeeId.value)
        .where('priceLabel', isEqualTo: selectedPrice.value)
        .get()
        .then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            maxOutstock.value = snapshot.docs.first.get('quantity') ?? 0;
          } else {
            maxOutstock.value = 0;
          }
          isLoading.value = false;
        })
        .catchError((error) {
          print('Error fetching outstock data: $error');
          isLoading.value = false;
        });
  } else {
    isLoading.value = false;
  }
}

  // Update calculation method for String prices
  void _calculateTotalInstockByPrice() {
    totalInstockQuantity.clear();
    for (var product in instockProducts) {
      if (product.type == 'instock' || product.type == 'return') {
        if (totalInstockQuantity.containsKey(product.price)) {
          totalInstockQuantity[product.price] = 
              totalInstockQuantity[product.price]! + product.quantity;
        } else {
          totalInstockQuantity[product.price] = product.quantity;
        }
      }
    }
  }

  // Update processOutstock method
  Future<void> processOutstock(
    int quantity,
    String vehicleId,
    String priceLabel // Changed from double to String
  ) async {
    if (quantity <= 0 || quantity > currentInstock.value) {
      Get.snackbar(
        'Error',
        'Invalid quantity',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      await firestore.runTransaction((transaction) async {
        final instockDoc = await firestore
            .collection('products')
            .where('priceLabel', isEqualTo: priceLabel)
            .where('type', isEqualTo: 'instock')
            .get();

        if (instockDoc.docs.isNotEmpty) {
          transaction.update(instockDoc.docs.first.reference, {
            'quantity': FieldValue.increment(-quantity),
          });
        }

        transaction.set(firestore.collection('products').doc(), {
          'dateAdded': DateTime.now().toIso8601String(),
          'priceLabel': priceLabel,
          'quantity': quantity,
          'type': 'vehicle_stock',
          'vehicleId': vehicleId,
          'employeeId': selectedEmployeeId.value,
        });
      });

      Get.snackbar(
        'Success',
        'Stock transferred to vehicle successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // _calculateTotalInstockByPrice();

_calculateTotalInstockByLabel();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process outstock: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void updateMaxInstock() {
    isLoading.value = true;
    maxOutstock.value = 0;
    
    if (selectedVehicleId.value.isNotEmpty && selectedPrice.value.isNotEmpty) {
      firestore
          .collection('outstocks')
          .where('vehicleId', isEqualTo: selectedVehicleId.value)
          .where('priceLabel', isEqualTo: selectedPrice.value)
          .get()
          .then((snapshot) {
            int totalOutstock = 0;
            for (var doc in snapshot.docs) {
              totalOutstock += (doc.get('quantity') ?? 0) as int;
            }
            maxOutstock.value = totalOutstock;
            isLoading.value = false;
          })
          .catchError((error) {
            print('Error fetching outstock data: $error');
            isLoading.value = false;
          });
    } else {
      isLoading.value = false;
    }
  }

  // // Update dropdown for prices
  // List<DropdownMenuItem<String>> getAvailablePrices() { // Changed return type
  //   if (selectedVehicleId.value.isEmpty || selectedEmployeeId.value.isEmpty)
  //     return [];

  //   var prices = outstocks
  //       .where((outstock) =>
  //           outstock.vehicleId == selectedVehicleId.value &&
  //           outstock.employeeId == selectedEmployeeId.value &&
  //           outstock.quantity > 0)
  //       .map((outstock) => outstock.priceLabel)
  //       .toSet()
  //       .toList();

  //   // Sort prices by numeric value
  //   prices.sort((a, b) {
  //     final aNumeric = RegExp(r'\d+\.?\d*').firstMatch(a);
  //     final bNumeric = RegExp(r'\d+\.?\d*').firstMatch(b);
      
  //     if (aNumeric != null && bNumeric != null) {
  //       final aValue = double.tryParse(aNumeric.group(0)!) ?? 0;
  //       final bValue = double.tryParse(bNumeric.group(0)!) ?? 0;
  //       return aValue.compareTo(bValue);
  //     }
  //     return a.compareTo(b);
  //   });

  //   return prices
  //       .map((price) => DropdownMenuItem(
  //             value: price,
  //             child: Text('₹$price'), // Display the full price string
  //           ))
  //       .toList();
  // }

  List<DropdownMenuItem<String>> getAvailablePrices() {
  if (selectedVehicleId.value.isEmpty || selectedEmployeeId.value.isEmpty) {
    return [];
  }

  var prices = outstocks
      .where((outstock) =>
          outstock.vehicleId == selectedVehicleId.value &&
          outstock.employeeId == selectedEmployeeId.value &&
          outstock.quantity > 0)
      .map((outstock) => outstock.priceLabel)
      .toSet()
      .toList();

  prices.sort((a, b) {
    final aNum = int.tryParse(a.split('-').first) ?? 0;
    final bNum = int.tryParse(b.split('-').first) ?? 0;
    return aNum.compareTo(bNum);
  });

  return prices.map((label) => DropdownMenuItem<String>(
    value: label,
    child: Text(label),
  )).toList();
}


  Future<bool> addReturnedStock() async {
    if (quantity.value <= 0 || quantity.value > maxOutstock.value) {
      Get.snackbar(
        'Error',
        'Invalid return quantity',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    try {
      await firestore.runTransaction((transaction) async {
        final outstockDocs = await firestore
            .collection('outstocks')
            .where('vehicleId', isEqualTo: selectedVehicleId.value)
            .where('employeeId', isEqualTo: selectedEmployeeId.value)
            .where('priceLabel', isEqualTo: selectedPrice.value)
            .get();

        if (outstockDocs.docs.isNotEmpty) {
          transaction.update(outstockDocs.docs.first.reference, {
            'quantity': FieldValue.increment(-quantity.value),
            'lastUpdated': DateTime.now().toIso8601String(),
          });
        } else {
          throw Exception(
              'No outstock found for the selected vehicle, employee, and price');
        }
        final source = instockProducts.firstWhere(
  (p) => p.label == selectedPrice.value,
);


        transaction.set(firestore.collection('products').doc(), {
          'dateAdded': DateTime.now().toIso8601String(),
          'priceLabel': selectedPrice.value,
           'price': source.price,            // ✅ REQUIRED
  'category': source.category, 
          'quantity': quantity.value,
          'type': 'return',
          'vehicleId': selectedVehicleId.value,
          'employeeId': selectedEmployeeId.value,
        });
      });

      resetForm();
      // _calculateTotalInstockByPrice();
_calculateTotalInstockByLabel();

      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process return: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  void resetForm() {
    selectedVehicleId.value = '';
    selectedEmployeeId.value = '';
    selectedPrice.value = ''; // Changed from 0 to ''
    quantity.value = 0;
    maxOutstock.value = 0;
    outstockController.clear();
  }

  String getVehiclePlateNumber(String? vehicleId) {
    if (vehicleId == null || vehicleId.isEmpty) return '-';
    return vehicleMap[vehicleId]?.plateNumber ?? vehicleId;
  }

  String getEmployeeName(String? employeeId) {
    if (employeeId == null || employeeId.isEmpty) return '-';
    return employeeMap[employeeId]?.name ?? employeeId;
  }

  @override
  void onClose() {
    outstockController.dispose();
    super.onClose();
  }
}
