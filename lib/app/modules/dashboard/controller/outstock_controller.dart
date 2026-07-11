import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/outstock_model.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class OutstockController extends GetxController {
  final fromDate = Rxn<DateTime>();
  final toDate = Rxn<DateTime>();
  final selectedDistrict = RxnString();
  final selectedStore = RxnString();
  final filteredOutstockData = <OutstockModel>[].obs;
  final districts = <String>[].obs;
  final filteredStores = <String>[].obs;
  final isLoading = true.obs;
  final RxDouble totalAmount = 0.0.obs;
  final RxDouble totalCash = 0.0.obs;
  final RxDouble totalUpi = 0.0.obs;
  final RxDouble totalCredit = 0.0.obs;
  final vehicles = <String>[].obs;
  final selectedVehicle = RxnString();
  @override
  void onInit() {
    super.onInit();
    districts.value = ['All'];
    filteredStores.value = ['All'];
    selectedDistrict.value = 'All';
    selectedStore.value = 'All';
    fromDate.value = DateTime.now();
    toDate.value = DateTime.now();
    loadDistricts();
    loadVehicles();
    loadOutstockData();
  }

  void onVehicleChanged(String? vehicle) {
    selectedVehicle.value = vehicle;
    loadOutstockData();
  }

  void loadVehicles() {
    FirebaseFirestore.instance.collection('vehicles').get().then((snapshot) {
      Set<String> uniqueVehicles = {'All'};

      for (var doc in snapshot.docs) {
        final data = doc.data();

        // ✅ Correct field from your DB
        final plate = data['plateNumber'];

        if (plate != null && plate.toString().trim().isNotEmpty) {
          uniqueVehicles.add(plate.toString());
        }
      }

      vehicles.value = uniqueVehicles.toList();
      selectedVehicle.value = 'All';
    });
  }
  //   void calculateTotals(List<OutstockModel> list) {
  //   double amount = 0;
  //   double cash = 0;
  //   double upi = 0;

  //   for (final item in list) {
  //     amount += item.totalAmount;

  //     // payment is already parsed in model
  //     cash += item.cashAmount;
  //     upi += item.upiAmount;
  //   }

  //   totalAmount.value = amount;
  //   totalCash.value = cash;
  //   totalUpi.value = upi;
  // }

  // Future<void> exportToExcelWeb() async {
  //   try {
  //     final excel = Excel.createExcel();

  //     // Use default sheet
  //     final Sheet sheet = excel['Sheet1'];

  //     // Header Row
  //     sheet.appendRow([
  //       TextCellValue('Date'),
  //       TextCellValue('Store'),
  //       TextCellValue('Item Details'),
  //       TextCellValue('Total Amount'),
  //       TextCellValue('Paid Amount'),
  //       TextCellValue('Previous Credit'),
  //       TextCellValue('Current Credit'),
  //       TextCellValue('Cash'),
  //       TextCellValue('UPI'),
  //     ]);

  //     final data = filteredOutstockData.toList();

  //     final double excelTotalAmount = data.fold(
  //       0.0,
  //       (sum, item) => sum + item.totalAmount,
  //     );
  //     final double excelPreviousCredit = data.fold(
  //       0.0,
  //       (sum, item) => sum + item.previousBalance,
  //     );

  //     final Map<String, int> itemTotals = {};

  //     for (final item in data) {
  //       for (final subItem in item.items) {
  //         itemTotals[subItem.priceLabel] =
  //             (itemTotals[subItem.priceLabel] ?? 0) + subItem.quantity;
  //       }
  //       final itemsDetails = item.items
  //           .map((subItem) {
  //             return '${subItem.priceLabel} - Qty: ${subItem.quantity}';
  //           })
  //           .join(', ');
  //       sheet.appendRow([
  //         TextCellValue(
  //           "${item.date.day}/${item.date.month}/${item.date.year}",
  //         ),
  //         TextCellValue(item.storeName),
  //         TextCellValue(itemsDetails),
  //         DoubleCellValue(item.totalAmount),
  //         DoubleCellValue(item.paidAmount),
  //         DoubleCellValue(item.previousBalance),
  //         DoubleCellValue(item.currentBalance),
  //         DoubleCellValue(item.cashAmount),
  //         DoubleCellValue(item.upiAmount),
  //       ]);
  //     }

  //     // Empty row
  //     sheet.appendRow([TextCellValue('')]);

  //     // Totals row
  //     sheet.appendRow([
  //       TextCellValue('TOTALS'),
  //       TextCellValue(''),
  //       TextCellValue(''),
  //       DoubleCellValue(excelTotalAmount),
  //       DoubleCellValue(totalCash.value + totalUpi.value),
  //       DoubleCellValue(excelPreviousCredit),
  //       DoubleCellValue(totalCredit.value),
  //       DoubleCellValue(totalCash.value),
  //       DoubleCellValue(totalUpi.value),
  //     ]);
  //     sheet.appendRow([TextCellValue('ITEM TOTALS')]);

  //     itemTotals.forEach((itemName, qty) {
  //       sheet.appendRow([TextCellValue(itemName), IntCellValue(qty)]);
  //     });
  //     print("Rows Created: ${sheet.maxRows}");

  //     final bytes = excel.encode();

  //     if (bytes == null) {
  //       print("Excel Encode Failed");
  //       return;
  //     }

  //     final Uint8List uint8List = Uint8List.fromList(bytes);

  //     final blob = html.Blob([
  //       uint8List,
  //     ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

  //     final url = html.Url.createObjectUrlFromBlob(blob);

  //     final anchor =
  //         html.AnchorElement(href: url)
  //           ..setAttribute(
  //             "download",
  //             "Outstock_Report_${DateTime.now().millisecondsSinceEpoch}.xlsx",
  //           )
  //           ..click();

  //     html.Url.revokeObjectUrl(url);

  //     Get.snackbar(
  //       "Success",
  //       "Excel downloaded successfully",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } catch (e, stackTrace) {
  //     print("Excel Export Error: $e");
  //     print(stackTrace);

  //     Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

  Future<void> exportToExcelWeb() async {
    try {
      final excel = Excel.createExcel();
      final Sheet sheet = excel['Sheet1'];

      final data = filteredOutstockData.toList();

      // Collect unique size headers (5,10,15...)
      final Set<String> headerSet = {};
      final Map<String, int> itemTotals = {};

      for (final item in data) {
        for (final subItem in item.items) {
          final match = RegExp(r'\d+').firstMatch(subItem.priceLabel);

          if (match == null) continue;

          final header = match.group(0)!;

          headerSet.add(header);

          itemTotals[header] = (itemTotals[header] ?? 0) + subItem.quantity;
        }
      }

      final headers =
          headerSet.toList()..sort((a, b) {
            return (int.tryParse(a) ?? 0).compareTo(int.tryParse(b) ?? 0);
          });
      // Header Row
      sheet.appendRow([
        TextCellValue('Date'),
        TextCellValue('Store'),

        ...headers.map((e) => TextCellValue(e)),

        TextCellValue('Total Amount'),
        TextCellValue('Paid Amount'),
        TextCellValue('Previous Credit'),
        TextCellValue('Current Credit'),
        TextCellValue('Cash'),
        TextCellValue('UPI'),
      ]);

      final double excelTotalAmount = data.fold(
        0.0,
        (sum, item) => sum + item.totalAmount,
      );

      final double excelPreviousCredit = data.fold(
        0.0,
        (sum, item) => sum + item.previousBalance,
      );

      // Store rows
      // Store rows
      for (final item in data) {
        final Map<String, int> qtyMap = {};

        for (final subItem in item.items) {
          final match = RegExp(r'\d+').firstMatch(subItem.priceLabel);

          if (match == null) continue;

          final key = match.group(0)!;

          qtyMap[key] = (qtyMap[key] ?? 0) + subItem.quantity;
        }

        sheet.appendRow([
          TextCellValue(
            "${item.date.day}/${item.date.month}/${item.date.year}",
          ),
          TextCellValue(item.storeName),

          ...headers.map((header) => IntCellValue(qtyMap[header] ?? 0)),

          DoubleCellValue(item.totalAmount),
          DoubleCellValue(item.paidAmount),
          DoubleCellValue(item.previousBalance),
          DoubleCellValue(item.currentBalance),
          DoubleCellValue(item.cashAmount),
          DoubleCellValue(item.upiAmount),
        ]);
      }

      // Empty Row
      sheet.appendRow([TextCellValue('')]);

      // Totals Row
      sheet.appendRow([
        TextCellValue('TOTALS'),
        TextCellValue(''),

        ...headers.map((header) => IntCellValue(itemTotals[header] ?? 0)),

        DoubleCellValue(excelTotalAmount),
        DoubleCellValue(totalCash.value + totalUpi.value),
        DoubleCellValue(excelPreviousCredit),
        DoubleCellValue(totalCredit.value),
        DoubleCellValue(totalCash.value),
        DoubleCellValue(totalUpi.value),
      ]);

      print("Rows Created: ${sheet.maxRows}");

      final bytes = excel.encode();

      if (bytes == null) {
        print("Excel Encode Failed");
        return;
      }

      final Uint8List uint8List = Uint8List.fromList(bytes);

      final blob = html.Blob([
        uint8List,
      ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..setAttribute(
          "download",
          "Outstock_Report_${DateTime.now().millisecondsSinceEpoch}.xlsx",
        )
        ..click();

      html.Url.revokeObjectUrl(url);

      Get.snackbar(
        "Success",
        "Excel downloaded successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, stackTrace) {
      print("Excel Export Error: $e");
      print(stackTrace);

      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void calculateTotals(List<OutstockModel> list) {
    double amount = 0;
    double cash = 0;
    double upi = 0;

    // 🔹 For credit → keep latest per store
    final Map<String, OutstockModel> latestByStore = {};

    for (final item in list) {
      amount += item.paidAmount;
      cash += item.cashAmount;
      upi += item.upiAmount;

      final storeKey = item.storeName; // or storeId if you have it

      if (!latestByStore.containsKey(storeKey)) {
        latestByStore[storeKey] = item;
      } else {
        final existing = latestByStore[storeKey]!;
        if (item.date.isAfter(existing.date)) {
          latestByStore[storeKey] = item;
        }
      }
    }

    final credit = latestByStore.values.fold<double>(
      0.0,
      (sum, item) => sum + item.currentBalance,
    );

    totalAmount.value = amount;
    totalCash.value = cash;
    totalUpi.value = upi;
    totalCredit.value = credit;
  }

  void loadDistricts() {
    FirebaseFirestore.instance.collection('stores').get().then((snapshot) {
      Set<String> uniqueDistricts = {'All'};
      uniqueDistricts.addAll(
        snapshot.docs.map((doc) => doc.data()['district'] as String),
      );
      districts.value = uniqueDistricts.toList();
    });
  }

  void onFromDateSelected(DateTime date) {
    fromDate.value = date;
    if (toDate.value != null && toDate.value!.isBefore(date)) {
      toDate.value = date;
    }
    loadOutstockData();
  }

  void onToDateSelected(DateTime date) {
    toDate.value = date;
    loadOutstockData();
  }

  void onDistrictChanged(String? district) {
    selectedDistrict.value = district;
    updateFilteredStores();
    loadOutstockData();
  }

  void onStoreChanged(String? store) {
    selectedStore.value = store;
    loadOutstockData();
  }

  void loadOutstockData() {
    isLoading.value = true;

    if (selectedDistrict.value != null && selectedDistrict.value != 'All') {
      FirebaseFirestore.instance
          .collection('stores')
          .where('district', isEqualTo: selectedDistrict.value)
          .get()
          .then((storeSnapshot) {
            List<String> storeIds =
                storeSnapshot.docs.map((doc) => doc.id).toList();

            // Check if storeIds exceed Firestore's whereIn limit of 30
            if (storeIds.length > 30) {
              _executeQueryWithChunkedStoreIds(storeIds);
            } else {
              Query query = _buildBaseQuery();
              query = query.where('storeId', whereIn: storeIds);
              executeQuery(query);
            }
          });
    } else {
      Query query = _buildBaseQuery();
      executeQuery(query);
    }
  }

  Query _buildBaseQuery() {
    Query query = FirebaseFirestore.instance.collection('transactions');

    if (fromDate.value != null && toDate.value != null) {
      DateTime startDate = DateTime(
        fromDate.value!.year,
        fromDate.value!.month,
        fromDate.value!.day,
      );
      DateTime endDate = DateTime(
        toDate.value!.year,
        toDate.value!.month,
        toDate.value!.day,
      ).add(const Duration(days: 1));

      query = query
          .where('timestamp', isGreaterThanOrEqualTo: startDate)
          .where('timestamp', isLessThan: endDate);
    }

    return query;
  }

  void _executeQueryWithChunkedStoreIds(List<String> storeIds) async {
    List<OutstockModel> allResults = [];

    // Split storeIds into chunks of 30
    List<List<String>> chunks = _chunkList(storeIds, 30);

    for (List<String> chunk in chunks) {
      Query query = _buildBaseQuery();
      query = query.where('storeId', whereIn: chunk);

      if (selectedStore.value != null && selectedStore.value != 'All') {
        query = query.where('storeName', isEqualTo: selectedStore.value);
      }

      if (selectedVehicle.value != null && selectedVehicle.value != 'All') {
        query = query.where('vehicleName', isEqualTo: selectedVehicle.value);
      }

      query = query.orderBy('timestamp', descending: true);

      QuerySnapshot snapshot = await query.get();
      List<OutstockModel> chunkResults =
          snapshot.docs.map((doc) => OutstockModel.fromFirestore(doc)).toList();

      allResults.addAll(chunkResults);
    }

    // Sort all results by timestamp descending (assuming timestamp is a DateTime field)
    allResults.sort((a, b) {
      // If your OutstockModel has a different timestamp field name, replace 'timestamp' below
      if (a.date != null && b.date != null) {
        return b.date!.compareTo(a.date!);
      }
      return 0;
    });

    filteredOutstockData.value = allResults;
    calculateTotals(allResults);

    isLoading.value = false;
  }

  // void executeQuery(Query query) {
  //   if (selectedStore.value != null && selectedStore.value != 'All') {
  //     query = query.where('storeName', isEqualTo: selectedStore.value);
  //   }
  //   query = query.orderBy('timestamp', descending: true);
  //   query.snapshots().listen((snapshot) {
  //     filteredOutstockData.value = snapshot.docs
  //         .map((doc) => OutstockModel.fromFirestore(doc))
  //         .toList();

  //     isLoading.value = false;
  //   });
  // }

  void executeQuery(Query query) {
    if (selectedStore.value != null && selectedStore.value != 'All') {
      query = query.where('storeName', isEqualTo: selectedStore.value);
    }
    if (selectedVehicle.value != null && selectedVehicle.value != 'All') {
      query = query.where('vehicleName', isEqualTo: selectedVehicle.value);
    }

    query = query.orderBy('timestamp', descending: true);

    query.snapshots().listen((snapshot) {
      final List<OutstockModel> list =
          snapshot.docs.map((doc) => OutstockModel.fromFirestore(doc)).toList();

      //  Update table data
      filteredOutstockData.value = list;

      //  Recalculate totals
      calculateTotals(list);

      isLoading.value = false;
    });

    query.snapshots().listen((snapshot) {
      print("Documents: ${snapshot.docs.length}");

      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        print("${data['storeName']} | vehicle=${data['vehicleName']}");
      }
    });
  }

  // Helper method to split a list into chunks of specified size
  List<List<T>> _chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(
          i,
          i + chunkSize > list.length ? list.length : i + chunkSize,
        ),
      );
    }
    return chunks;
  }

  void updateFilteredStores() {
    if (selectedDistrict.value == null || selectedDistrict.value == 'All') {
      FirebaseFirestore.instance.collection('stores').get().then((snapshot) {
        filteredStores.value = [
          'All',
          ...snapshot.docs.map((doc) => doc.data()['name'] as String),
        ];
        selectedStore.value = 'All';
      });
      return;
    }

    FirebaseFirestore.instance
        .collection('stores')
        .where('district', isEqualTo: selectedDistrict.value)
        .get()
        .then((snapshot) {
          filteredStores.value = [
            'All',
            ...snapshot.docs.map((doc) => doc.data()['name'] as String),
          ];
          selectedStore.value = 'All';
        });
  }

  Future<void> exportCreditBalanceExcel() async {
    try {
      final excel = Excel.createExcel();
      final Sheet sheet = excel['Sheet1'];

      // Header
      sheet.appendRow([
        TextCellValue('Line'),
        TextCellValue('Store'),
        TextCellValue('Last Sale Date'),
        TextCellValue('Current Credit'),
      ]);

      final storesSnapshot =
          await FirebaseFirestore.instance.collection('stores').get();

      double totalCredit = 0;

      for (final doc in storesSnapshot.docs) {
        final data = doc.data();

        final credit =
            ((data['currentBalance'] ?? data['balanceAmount'] ?? 0) as num)
                .toDouble();

        // Skip stores with no credit
        if (credit <= 0) continue;

        totalCredit += credit;

        final line = data['district']?.toString() ?? '';

        final storeName = data['name']?.toString() ?? '';

        String formattedDate = '';

        final lastTransactionDate =
            data['lastTransactionDate']?.toString() ?? '';

        if (lastTransactionDate.isNotEmpty) {
          try {
            final date = DateTime.parse(lastTransactionDate);

            formattedDate =
                "${date.day.toString().padLeft(2, '0')}/"
                "${date.month.toString().padLeft(2, '0')}/"
                "${date.year}";
          } catch (e) {
            formattedDate = lastTransactionDate;
          }
        }
        sheet.appendRow([
          TextCellValue(line),
          TextCellValue(storeName),
          TextCellValue(formattedDate),
          DoubleCellValue(credit),
        ]);
      }

      // Empty row
      sheet.appendRow([TextCellValue('')]);

      // Total row
      sheet.appendRow([
        TextCellValue(''),
        TextCellValue('TOTAL CREDIT'),
        TextCellValue(''),
        DoubleCellValue(totalCredit),
      ]);

      // Remove default empty sheet
      try {
        excel.delete('Sheet1');
      } catch (_) {}

      final bytes = excel.encode();

      if (bytes == null) {
        Get.snackbar("Error", "Failed to generate Excel");
        return;
      }

      final Uint8List uint8List = Uint8List.fromList(bytes);

      final blob = html.Blob([
        uint8List,
      ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..setAttribute(
          "download",
          "Credit_Balance_Report_${DateTime.now().millisecondsSinceEpoch}.xlsx",
        )
        ..click();

      html.Url.revokeObjectUrl(url);

      Get.snackbar(
        "Success",
        "Credit Balance Report Downloaded",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, stackTrace) {
      print("Credit Export Error: $e");
      print(stackTrace);

      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
