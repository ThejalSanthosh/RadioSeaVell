import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/outstock_controller.dart';
import 'package:radio_sea_well/app/modules/dashboard/view/outstock_dataTable_card.dart';

class OutstockScreen extends GetView<OutstockController> {
  final Color backgroundColor = const Color(0xFFF5F6FA);
  final Color primaryColor = const Color(0xFF2C3E50);
  final Color cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Outstock Details'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => showFromDatePicker(context),
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.fromDate.value != null
                                      ? DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(controller.fromDate.value!)
                                      : 'From Date',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primaryColor,
                                  ),
                                ),
                                Icon(Icons.calendar_today, color: primaryColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () => _showToDatePicker(context),
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.toDate.value != null
                                      ? DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(controller.toDate.value!)
                                      : 'To Date',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primaryColor,
                                  ),
                                ),
                                Icon(Icons.calendar_today, color: primaryColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        if (controller.districts.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return DropdownButtonFormField<String>(
                          dropdownColor: Colors.grey.shade300,
                          style: TextStyle(color: Colors.black),

                          decoration: InputDecoration(
                            labelText: 'Select District',
                            labelStyle: TextStyle(color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            filled: true,
                            fillColor: backgroundColor,
                          ),
                          value: controller.selectedDistrict.value,
                          items:
                              controller.districts
                                  .map(
                                    (district) => DropdownMenuItem(
                                      value: district,
                                      child: Text(district),
                                    ),
                                  )
                                  .toList(),
                          onChanged: controller.onDistrictChanged,
                        );
                      }),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Obx(() {
                        if (controller.filteredStores.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return DropdownButtonFormField<String>(
                          dropdownColor: Colors.grey.shade300,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Select Store',

                            labelStyle: TextStyle(color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            filled: true,
                            fillColor: backgroundColor,
                          ),
                          value: controller.selectedStore.value,
                          items:
                              controller.filteredStores
                                  .map(
                                    (store) => DropdownMenuItem(
                                      value: store,
                                      child: Text(store),
                                    ),
                                  )
                                  .toList(),
                          onChanged: controller.onStoreChanged,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => Stack(
                children: [
                  OutstockDataTable(),
                  if (controller.isLoading.value)
                    Container(
                      color: backgroundColor.withOpacity(0.7),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showFromDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.fromDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.onFromDateSelected(picked);
    }
  }

  void _showToDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.toDate.value ?? DateTime.now(),
      firstDate: controller.fromDate.value ?? DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.onToDateSelected(picked);
    }
  }
}
