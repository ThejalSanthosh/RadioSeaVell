import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/outstock_model.dart';

// class OutstockController extends GetxController {
//   final fromDate = Rxn<DateTime>();
//   final toDate = Rxn<DateTime>();
//   final selectedDistrict = RxnString();
//   final selectedStore = RxnString();
//   final filteredOutstockData = <OutstockModel>[].obs;
//   final districts = <String>[].obs;
//   final filteredStores = <String>[].obs;
//   final isLoading = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     districts.value = ['All'];
//     filteredStores.value = ['All'];
//     selectedDistrict.value = 'All';
//     selectedStore.value = 'All';
//     fromDate.value = DateTime.now();
//     toDate.value = DateTime.now();
//     loadDistricts();
//     loadOutstockData();
//   }

//   void loadDistricts() {
//     FirebaseFirestore.instance.collection('stores').get().then((snapshot) {
//       Set<String> uniqueDistricts = {'All'};
//       uniqueDistricts.addAll(
//         snapshot.docs.map((doc) => doc.data()['district'] as String),
//       );
//       districts.value = uniqueDistricts.toList();
//     });
//   }

//   void onFromDateSelected(DateTime date) {
//     fromDate.value = date;
//     if (toDate.value != null && toDate.value!.isBefore(date)) {
//       toDate.value = date;
//     }
//     loadOutstockData();
//   }

//   void onToDateSelected(DateTime date) {
//     toDate.value = date;
//     loadOutstockData();
//   }

//   void onDistrictChanged(String? district) {
//     selectedDistrict.value = district;
//     updateFilteredStores();
//     loadOutstockData();
//   }

//   void onStoreChanged(String? store) {
//     selectedStore.value = store;
//     loadOutstockData();
//   }

//   void loadOutstockData() {
//     isLoading.value = true;
//     Query query = FirebaseFirestore.instance.collection('transactions');

//     if (fromDate.value != null && toDate.value != null) {
//       DateTime startDate = DateTime(
//         fromDate.value!.year,
//         fromDate.value!.month,
//         fromDate.value!.day,
//       );
//       DateTime endDate = DateTime(
//         toDate.value!.year,
//         toDate.value!.month,
//         toDate.value!.day,
//       ).add(const Duration(days: 1));

//       query = query
//           .where('timestamp', isGreaterThanOrEqualTo: startDate)
//           .where('timestamp', isLessThan: endDate);
//     }

//     if (selectedDistrict.value != null && selectedDistrict.value != 'All') {
//       FirebaseFirestore.instance
//           .collection('stores')
//           .where('district', isEqualTo: selectedDistrict.value)
//           .get()
//           .then((storeSnapshot) {
//         List<String> storeIds = storeSnapshot.docs.map((doc) => doc.id).toList();
//         query = query.where('storeId', whereIn: storeIds);
//         executeQuery(query);
//       });
//     } else {
//       executeQuery(query);
//     }
//   }

//   void executeQuery(Query query) {
//     if (selectedStore.value != null && selectedStore.value != 'All') {
//       query = query.where('storeName', isEqualTo: selectedStore.value);
//     }

//     query = query.orderBy('timestamp', descending: true);

//     query.snapshots().listen((snapshot) {
//       filteredOutstockData.value = snapshot.docs
//           .map((doc) => OutstockModel.fromFirestore(doc))
//           .toList();
//       isLoading.value = false;
//     });
//   }

//   void updateFilteredStores() {
//     if (selectedDistrict.value == null || selectedDistrict.value == 'All') {
//       FirebaseFirestore.instance.collection('stores').get().then((snapshot) {
//         filteredStores.value = [
//           'All',
//           ...snapshot.docs.map((doc) => doc.data()['name'] as String),
//         ];
//         selectedStore.value = 'All';
//       });
//       return;
//     }

//     FirebaseFirestore.instance
//         .collection('stores')
//         .where('district', isEqualTo: selectedDistrict.value)
//         .get()
//         .then((snapshot) {
//           filteredStores.value = [
//             'All',
//             ...snapshot.docs.map((doc) => doc.data()['name'] as String),
//           ];
//           selectedStore.value = 'All';
//         });
//   }
// }

class OutstockController extends GetxController {
  final fromDate = Rxn<DateTime>();
  final toDate = Rxn<DateTime>();
  final selectedDistrict = RxnString();
  final selectedStore = RxnString();
  final filteredOutstockData = <OutstockModel>[].obs;
  final districts = <String>[].obs;
  final filteredStores = <String>[].obs;
  final isLoading = true.obs;

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
    loadOutstockData();
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
        List<String> storeIds = storeSnapshot.docs.map((doc) => doc.id).toList();
        
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
      
      query = query.orderBy('timestamp', descending: true);
      
      QuerySnapshot snapshot = await query.get();
      List<OutstockModel> chunkResults = snapshot.docs
          .map((doc) => OutstockModel.fromFirestore(doc))
          .toList();
      
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
    isLoading.value = false;
  }

  void executeQuery(Query query) {
    if (selectedStore.value != null && selectedStore.value != 'All') {
      query = query.where('storeName', isEqualTo: selectedStore.value);
    }
    query = query.orderBy('timestamp', descending: true);
    query.snapshots().listen((snapshot) {
      filteredOutstockData.value = snapshot.docs
          .map((doc) => OutstockModel.fromFirestore(doc))
          .toList();
      isLoading.value = false;
    });
  }

  // Helper method to split a list into chunks of specified size
  List<List<T>> _chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
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
}
