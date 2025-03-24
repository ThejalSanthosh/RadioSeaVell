import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/outstock_model.dart';

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

    if (selectedDistrict.value != null && selectedDistrict.value != 'All') {
      FirebaseFirestore.instance
          .collection('stores')
          .where('district', isEqualTo: selectedDistrict.value)
          .get()
          .then((storeSnapshot) {
        List<String> storeIds = storeSnapshot.docs.map((doc) => doc.id).toList();
        query = query.where('storeId', whereIn: storeIds);
        executeQuery(query);
      });
    } else {
      executeQuery(query);
    }
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