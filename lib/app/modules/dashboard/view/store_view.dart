import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/store_view_controller.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/store_view_model.dart';
import 'package:radio_sea_well/app/utils/constants.dart';

class StoresView extends GetView<StoreController> {
  final Color bg = Colors.white;
  final Color text = Colors.black;
  final Color primaryColor = const Color(0xFF2C3E50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Stores'),
        backgroundColor: primaryColor,
        foregroundColor: bg,
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.stores.isEmpty) {
          return const Center(child: Text('No stores found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.stores.length,
          itemBuilder: (context, index) {
            final store = controller.stores[index];

            return Card(
              color: bg,
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(
                  store.name,
                  style: TextStyle(color: text, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Line: ${store.district}\n'
                  'Credit: ₹${store.balanceAmount.toStringAsFixed(2)}',
                  style: TextStyle(color: text),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showEditDialog(context, store),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  // ---------------- EDIT DIALOG ----------------
  void _showEditDialog(BuildContext context, StoreModel store) {
    final name = TextEditingController(text: store.name);
    final address = TextEditingController(text: store.address);
    final district = TextEditingController(text: store.district);
    final phone = TextEditingController(text: store.phone);
    final email = TextEditingController(text: store.email);
    final balance = TextEditingController(text: store.balanceAmount.toString());
    final reason = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: bg,
            title: Text(
              'Update Store',
              style: TextStyle(color: text, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  _tf(name, 'Store Name'),
                  _tf(phone, 'Phone'),
                  _tf(address, 'Address'),
                  _tf(district, 'Line'),
                  _tf(email, 'Email'),
                  _tf(
                    balance,
                    'Credit Balance',
                    keyboard: TextInputType.number,
                  ),
                  _tf(reason, 'Reason (mandatory)', maxLines: 3),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: Get.back,
                child: Text('Cancel', style: TextStyle(color: text)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  controller.updateStore(
                    store: store,
                    name: name.text,
                    address: address.text,
                    district: district.text,
                    phone: phone.text,
                    email: email.text,
                    balanceAmount: double.tryParse(balance.text) ?? 0,
                    reason: reason.text,
                  );
                },
              ),
            ],
          ),
    );
  }

  Widget _tf(
    TextEditingController c,
    String label, {
    TextInputType? keyboard,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        maxLines: maxLines,
        keyboardType: keyboard,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
