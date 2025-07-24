import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/employee_model.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/instock_product_model.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/outstock_summary_model.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/vehcile_instock_model.dart';

// class InstockController extends GetxController {
//   final firestore = FirebaseFirestore.instance;
//   final instockProducts = <InstockProduct>[].obs;
//   final vehicles = <VehicleInstock>[].obs;
//   final employees = <EmployeeModel>[].obs;
//   final outstocks = <OutstockSummary>[].obs;
//   final selectedType = 'All'.obs;

//   // Maps for quick lookups
//   final vehicleMap = <String, VehicleInstock>{}.obs;
//   final employeeMap = <String, EmployeeModel>{}.obs;

//   // Selection values
//   final selectedVehicleId = ''.obs;
//   final selectedEmployeeId = ''.obs;
//   final selectedPrice = 0.0.obs;
//   final quantity = 0.obs;
//   final maxOutstock = 0.obs;
//   final currentInstock = 0.obs;
//   final isLoading = false.obs;

//   // Add a computed total for instock display
//   final totalInstockQuantity = <double, int>{}.obs;

//   // Text controller for outstock quantity
//   final outstockController = TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchInstockProducts();
//     fetchVehicles();
//     fetchEmployees();
//     fetchOutstocks();
//   }

//   // Update the getFilteredData method to show vehicle stock from outstocks
//   List<InstockProduct> getFilteredData() {
//     switch (selectedType.value) {
//       case 'Instock':
//         // For instock view, we need to combine regular instock and returns
//         if (totalInstockQuantity.isEmpty) {
//           _calculateTotalInstockByPrice();
//         }

//         // Create a list of aggregated instock products
//         List<InstockProduct> aggregatedInstock = [];

//         // Get the most recent dateAdded for each price
//         Map<double, String> latestDates = {};

//         // Find the most recent date for each price
//         for (var product in instockProducts) {
//           if ((product.type == 'instock' || product.type == 'return') &&
//               product.quantity > 0) {
//             if (!latestDates.containsKey(product.price) ||
//                 DateTime.parse(
//                   product.dateAdded,
//                 ).isAfter(DateTime.parse(latestDates[product.price]!))) {
//               latestDates[product.price] = product.dateAdded;
//             }
//           }
//         }

//         // Create aggregated products with the most recent dates
//         totalInstockQuantity.forEach((price, quantity) {
//           if (quantity > 0) {
//             // Only add if quantity is greater than 0
//             aggregatedInstock.add(
//               InstockProduct(
//                 id: 'total-${price.toString()}', // Create a unique ID for UI purposes
//                 dateAdded:
//                     latestDates[price] ??
//                     DateTime.now()
//                         .toIso8601String(), // Use the latest date or current date if not found
//                 price: price,
//                 quantity: quantity,
//                 type: 'instock',
//                 vehicleId: '',
//                 employeeId: '',
//               ),
//             );
//           }
//         });

//         // Sort by dateAdded in descending order (latest first)
//         aggregatedInstock.sort(
//           (a, b) => DateTime.parse(
//             b.dateAdded,
//           ).compareTo(DateTime.parse(a.dateAdded)),
//         );

//         return aggregatedInstock;

//       case 'Vehicle Stock':
//         // Convert outstocks to InstockProduct format for display
//         var vehicleStockList =
//             outstocks
//                 .where(
//                   (outstock) => outstock.quantity > 0,
//                 ) // Filter out zero quantity items
//                 .map(
//                   (outstock) => InstockProduct(
//                     id: outstock.id,
//                     dateAdded:
//                         outstock.dateCreated, // Using dateCreated from outstock
//                     price: outstock.price,
//                     quantity: outstock.quantity,
//                     type: 'vehicle_stock',
//                     vehicleId: outstock.vehicleId,
//                     employeeId: outstock.employeeId,
//                   ),
//                 )
//                 .toList();

//         // Sort by dateAdded in descending order (latest first)
//         vehicleStockList.sort(
//           (a, b) => DateTime.parse(
//             b.dateAdded,
//           ).compareTo(DateTime.parse(a.dateAdded)),
//         );

//         return vehicleStockList;

//       case 'Return':
//         // Get all return products
//         var returnProducts =
//             instockProducts
//                 .where(
//                   (p) => p.type == 'return' && p.quantity > 0,
//                 ) // Only include returns with quantity > 0
//                 .toList();

//         // Sort by dateAdded in descending order (latest first)
//         returnProducts.sort(
//           (a, b) => DateTime.parse(
//             b.dateAdded,
//           ).compareTo(DateTime.parse(a.dateAdded)),
//         );

//         return returnProducts;
//       default:
//         return instockProducts;
//     }
//   }

//   // Calculate total instock quantity by price
//   void _calculateTotalInstockByPrice() {
//     totalInstockQuantity.clear();

//     // Group products by price
//     for (var product in instockProducts) {
//       if (product.type == 'instock' || product.type == 'return') {
//         // Add to the total for this price
//         if (totalInstockQuantity.containsKey(product.price)) {
//           totalInstockQuantity[product.price] =
//               totalInstockQuantity[product.price]! + product.quantity;
//         } else {
//           totalInstockQuantity[product.price] = product.quantity;
//         }
//       }
//     }
//   }

//   void fetchInstockProducts() {
//     firestore.collection('products').snapshots().listen((snapshot) {
//       instockProducts.value =
//           snapshot.docs
//               .map(
//                 (doc) => InstockProduct.fromJson({
//                   'id': doc.id, // Pass the document ID
//                   ...doc.data(),
//                 }),
//               )
//               .toList();
//       updateCurrentInstock();
//       _calculateTotalInstockByPrice(); // Recalculate totals when data changes
//     });
//   }

//   void updateCurrentInstock() {
//     int total = 0;
//     for (var product in instockProducts) {
//       if (product.type == 'instock' || product.type == 'return') {
//         total += product.quantity;
//       } else if (product.type == 'vehicle_stock') {
//         total -= product.quantity;
//       }
//     }
//     currentInstock.value = total;
//   }

//   void fetchVehicles() {
//     firestore.collection('vehicles').snapshots().listen((snapshot) {
//       vehicles.value =
//           snapshot.docs
//               .map(
//                 (doc) => VehicleInstock.fromJson({'id': doc.id, ...doc.data()}),
//               )
//               .toList();

//       // Create a map for quick lookups
//       vehicleMap.clear();
//       for (var vehicle in vehicles) {
//         vehicleMap[vehicle.id] = vehicle;
//       }
//     });
//   }

//   void fetchEmployees() {
//     firestore.collection('employees').snapshots().listen((snapshot) {
//       employees.value =
//           snapshot.docs
//               .map(
//                 (doc) => EmployeeModel.fromJson({'id': doc.id, ...doc.data()}),
//               )
//               .toList();

//       // Create a map for quick lookups
//       employeeMap.clear();
//       for (var employee in employees) {
//         employeeMap[employee.id] = employee;
//       }
//     });
//   }

//   void fetchOutstocks() {
//     firestore.collection('outstocks').snapshots().listen((snapshot) {
//       outstocks.value =
//           snapshot.docs
//               .map(
//                 (doc) =>
//                     OutstockSummary.fromJson({'id': doc.id, ...doc.data()}),
//               )
//               .toList();
//     });
//   }

//   Future<void> processOutstock(
//     int quantity,
//     String vehicleId,
//     double price,
//   ) async {
//     if (quantity <= 0 || quantity > currentInstock.value) {
//       Get.snackbar(
//         'Error',
//         'Invalid quantity',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     try {
//       await firestore.runTransaction((transaction) async {
//         // Update instock
//         final instockDoc =
//             await firestore
//                 .collection('products')
//                 .where('price', isEqualTo: price)
//                 .where('type', isEqualTo: 'instock')
//                 .get();

//         if (instockDoc.docs.isNotEmpty) {
//           transaction.update(instockDoc.docs.first.reference, {
//             'quantity': FieldValue.increment(-quantity),
//           });
//         }

//         // Create vehicle stock record
//         transaction.set(firestore.collection('products').doc(), {
//           'dateAdded': DateTime.now().toIso8601String(),
//           'price': price,
//           'quantity': quantity,
//           'type': 'vehicle_stock',
//           'vehicleId': vehicleId,
//           'employeeId': selectedEmployeeId.value,
//         });
//       });

//       Get.snackbar(
//         'Success',
//         'Stock transferred to vehicle successfully',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );

//       _calculateTotalInstockByPrice(); // Recalculate after outstock
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to process outstock: ${e.toString()}',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   void updateMaxOutstock() {
//     isLoading.value = true;
//     maxOutstock.value = 0; // Reset before fetching

//     if (selectedVehicleId.value.isNotEmpty &&
//         selectedEmployeeId.value.isNotEmpty &&
//         selectedPrice.value > 0) {
//       firestore
//           .collection('outstocks')
//           .where('vehicleId', isEqualTo: selectedVehicleId.value)
//           .where('employeeId', isEqualTo: selectedEmployeeId.value)
//           .where('price', isEqualTo: selectedPrice.value)
//           .get()
//           .then((snapshot) {
//             if (snapshot.docs.isNotEmpty) {
//               maxOutstock.value = snapshot.docs.first.get('quantity') ?? 0;
//             } else {
//               maxOutstock.value = 0;
//             }
//             isLoading.value = false;
//           })
//           .catchError((error) {
//             print('Error fetching outstock data: $error');
//             isLoading.value = false;
//           });
//     } else {
//       isLoading.value = false;
//     }
//   }

//   void updateMaxInstock() {
//     isLoading.value = true;
//     maxOutstock.value = 0; // Reset before fetching

//     if (selectedVehicleId.value.isNotEmpty && selectedPrice.value > 0) {
//       firestore
//           .collection('outstocks')
//           .where('vehicleId', isEqualTo: selectedVehicleId.value)
//           .where('price', isEqualTo: selectedPrice.value)
//           .get()
//           .then((snapshot) {
//             int totalOutstock = 0;

//             // Sum up all quantities for this vehicle and price
//             for (var doc in snapshot.docs) {
//               totalOutstock += (doc.get('quantity') ?? 0) as int;
//             }

//             maxOutstock.value = totalOutstock;
//             isLoading.value = false;
//           })
//           .catchError((error) {
//             print('Error fetching outstock data: $error');
//             isLoading.value = false;
//           });
//     } else {
//       isLoading.value = false;
//     }
//   }
//   //  List<DropdownMenuItem<double>> getAvailablePrices() {
//   //   if (selectedVehicleId.value.isEmpty) return [];

//   //   // Filter prices from your existing outstocks list
//   //   var prices = outstocks
//   //       .where((outstock) => outstock.vehicleId == selectedVehicleId.value)
//   //       .map((outstock) => outstock.price)
//   //       .toSet()
//   //       .toList();

//   //   // Sort prices for better UX
//   //   prices.sort();

//   //   return prices
//   //       .map((price) => DropdownMenuItem(
//   //             value: price,
//   //             child: Text('₹${price.toStringAsFixed(2)}'),
//   //           ))
//   //       .toList();
//   // }
//   List<DropdownMenuItem<double>> getAvailablePrices() {
//     if (selectedVehicleId.value.isEmpty || selectedEmployeeId.value.isEmpty)
//       return [];

//     // Filter prices from your existing outstocks list
//     var prices =
//         outstocks
//             .where(
//               (outstock) =>
//                   outstock.vehicleId == selectedVehicleId.value &&
//                   outstock.employeeId == selectedEmployeeId.value &&
//                   outstock.quantity > 0,
//             ) // Only include items with quantity > 0
//             .map((outstock) => outstock.price)
//             .toSet()
//             .toList();

//     // Sort prices for better UX
//     prices.sort();

//     return prices
//         .map(
//           (price) => DropdownMenuItem(
//             value: price,
//             child: Text('₹${price.toStringAsFixed(2)}'),
//           ),
//         )
//         .toList();
//   }

//   Future<bool> addReturnedStock() async {
//     if (quantity.value <= 0 || quantity.value > maxOutstock.value) {
//       Get.snackbar(
//         'Error',
//         'Invalid return quantity',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return false;
//     }

//     try {
//       await firestore.runTransaction((transaction) async {
//         // Find the outstock document to update
//         final outstockDocs =
//             await firestore
//                 .collection('outstocks')
//                 .where('vehicleId', isEqualTo: selectedVehicleId.value)
//                 .where('employeeId', isEqualTo: selectedEmployeeId.value)
//                 .where('price', isEqualTo: selectedPrice.value)
//                 .get();

//         if (outstockDocs.docs.isNotEmpty) {
//           // Update the outstock quantity
//           transaction.update(outstockDocs.docs.first.reference, {
//             'quantity': FieldValue.increment(-quantity.value),
//             'lastUpdated': DateTime.now().toIso8601String(),
//           });
//         } else {
//           throw Exception(
//             'No outstock found for the selected vehicle, employee, and price',
//           );
//         }

//         // Create return record in products collection
//         transaction.set(firestore.collection('products').doc(), {
//           'dateAdded': DateTime.now().toIso8601String(),
//           'price': selectedPrice.value,
//           'quantity': quantity.value,
//           'type': 'return',
//           'vehicleId': selectedVehicleId.value,
//           'employeeId': selectedEmployeeId.value,
//         });
//       });

//       resetForm();
//       _calculateTotalInstockByPrice();
//       return true;
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to process return: ${e.toString()}',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return false;
//     }
//   }

//   void resetForm() {
//     selectedVehicleId.value = '';
//     selectedEmployeeId.value = '';
//     selectedPrice.value = 0;
//     quantity.value = 0;
//     maxOutstock.value = 0;
//     outstockController.clear();
//   }

//   void prepareForNewSelection() {
//     resetForm();
//     fetchVehicles();
//     fetchOutstocks();
//   }

//   // Helper methods to get names instead of IDs
//   String getVehiclePlateNumber(String? vehicleId) {
//     if (vehicleId == null || vehicleId.isEmpty) return '-';
//     return vehicleMap[vehicleId]?.plateNumber ?? vehicleId;
//   }

//   String getEmployeeName(String? employeeId) {
//     if (employeeId == null || employeeId.isEmpty) return '-';
//     return employeeMap[employeeId]?.name ?? employeeId;
//   }

//   @override
//   void onClose() {
//     outstockController.dispose();
//     super.onClose();
//   }
// }

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
  final totalInstockQuantity = <String, int>{}.obs; // Changed from <double, int> to <String, int>

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
      _calculateTotalInstockByPrice(); // Recalculate totals when data changes
    });
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
      case 'Instock':
        if (totalInstockQuantity.isEmpty) {
          _calculateTotalInstockByPrice();
        }
        
        List<InstockProduct> aggregatedInstock = [];
        Map<String, String> latestDates = {}; // Changed key type to String

        // Find the most recent date for each price
        for (var product in instockProducts) {
          if ((product.type == 'instock' || product.type == 'return') &&
              product.quantity > 0) {
            if (!latestDates.containsKey(product.price) ||
                DateTime.parse(product.dateAdded).isAfter(
                    DateTime.parse(latestDates[product.price]!))) {
              latestDates[product.price] = product.dateAdded;
            }
          }
        }

        // Create aggregated products
        totalInstockQuantity.forEach((price, quantity) {
          if (quantity > 0) {
            aggregatedInstock.add(
              InstockProduct(
                id: 'total-$price',
                dateAdded: latestDates[price] ?? DateTime.now().toIso8601String(),
                price: price, // Now using String price
                quantity: quantity,
                type: 'instock',
                vehicleId: '',
                employeeId: '',
              ),
            );
          }
        });

        aggregatedInstock.sort(
          (a, b) => DateTime.parse(b.dateAdded).compareTo(DateTime.parse(a.dateAdded)),
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
        .where('price', isEqualTo: selectedPrice.value)
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
    String price, // Changed from double to String
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
            .where('price', isEqualTo: price)
            .where('type', isEqualTo: 'instock')
            .get();

        if (instockDoc.docs.isNotEmpty) {
          transaction.update(instockDoc.docs.first.reference, {
            'quantity': FieldValue.increment(-quantity),
          });
        }

        transaction.set(firestore.collection('products').doc(), {
          'dateAdded': DateTime.now().toIso8601String(),
          'price': price,
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
      _calculateTotalInstockByPrice();
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
          .where('price', isEqualTo: selectedPrice.value)
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

  // Update dropdown for prices
  List<DropdownMenuItem<String>> getAvailablePrices() { // Changed return type
    if (selectedVehicleId.value.isEmpty || selectedEmployeeId.value.isEmpty)
      return [];

    var prices = outstocks
        .where((outstock) =>
            outstock.vehicleId == selectedVehicleId.value &&
            outstock.employeeId == selectedEmployeeId.value &&
            outstock.quantity > 0)
        .map((outstock) => outstock.price)
        .toSet()
        .toList();

    // Sort prices by numeric value
    prices.sort((a, b) {
      final aNumeric = RegExp(r'\d+\.?\d*').firstMatch(a);
      final bNumeric = RegExp(r'\d+\.?\d*').firstMatch(b);
      
      if (aNumeric != null && bNumeric != null) {
        final aValue = double.tryParse(aNumeric.group(0)!) ?? 0;
        final bValue = double.tryParse(bNumeric.group(0)!) ?? 0;
        return aValue.compareTo(bValue);
      }
      return a.compareTo(b);
    });

    return prices
        .map((price) => DropdownMenuItem(
              value: price,
              child: Text('₹$price'), // Display the full price string
            ))
        .toList();
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
            .where('price', isEqualTo: selectedPrice.value)
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

        transaction.set(firestore.collection('products').doc(), {
          'dateAdded': DateTime.now().toIso8601String(),
          'price': selectedPrice.value,
          'quantity': quantity.value,
          'type': 'return',
          'vehicleId': selectedVehicleId.value,
          'employeeId': selectedEmployeeId.value,
        });
      });

      resetForm();
      _calculateTotalInstockByPrice();
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
