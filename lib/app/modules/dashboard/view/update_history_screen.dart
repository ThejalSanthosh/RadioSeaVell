import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:intl/intl.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/update_history_controller.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/updateHistory_model.dart';

class UpdateHistoryScreen extends StatelessWidget {
  const UpdateHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Employee Error Tracking'),
        elevation: 0,
        backgroundColor: const Color(0xFF2C3E50),
      ),
      body: GetX<UpdateHistoryController>(
        init: UpdateHistoryController(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return ErrorListContent(controller: controller);
        },
      ),
    );
  }
}

class ErrorListContent extends StatelessWidget {
  final UpdateHistoryController controller;
  final Color backgroundColor = const Color(0xFFF5F6FA);
  final Color primaryColor = const Color(0xFF2C3E50);
  final Color cardColor = Colors.white;

  ErrorListContent({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
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
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.grey.shade300,
                  value:
                      controller.selectedStore.value.isEmpty
                          ? null
                          : controller.selectedStore.value,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Filter by Store',
                    labelStyle: TextStyle(color: primaryColor),
                    prefixIcon: Icon(Icons.store, color: primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    filled: true,
                    fillColor: backgroundColor,
                  ),
                  items: [
                    DropdownMenuItem(value: '', child: Text('All Stores')),
                    ...controller.stores.map((storeName) {
                      return DropdownMenuItem(
                        value: storeName,
                        child: Text(storeName),
                      );
                    }).toList(),
                  ],
                  onChanged: (storeName) {
                    controller.selectedStore.value = storeName ?? '';
                    controller.filterUpdateHistory();
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.grey.shade300,
                  value:
                      controller.selectedEmployee.value.isEmpty
                          ? null
                          : controller.selectedEmployee.value,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Filter by Employee',
                    labelStyle: TextStyle(color: primaryColor),
                    prefixIcon: Icon(Icons.person, color: primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    filled: true,
                    fillColor: backgroundColor,
                  ),
                  items: [
                    DropdownMenuItem(value: '', child: Text('All Employees')),
                    ...controller.employees.map((employeeName) {
                      return DropdownMenuItem(
                        value: employeeName,
                        child: Text(employeeName),
                      );
                    }).toList(),
                  ],
                  onChanged: (employeeName) {
                    controller.selectedEmployee.value = employeeName ?? '';
                    controller.filterUpdateHistory();
                  },
                ),
              ),
              SizedBox(width: 16),
              // ElevatedButton.icon(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: primaryColor,
              //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              //   onPressed: () => controller.loadUpdateHistory(),
              //   icon: Icon(Icons.refresh, color: Colors.white),
              //   label: Text('Refresh', style: TextStyle(color: Colors.white)),
              // ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
            child: _buildTableContent(controller, context),
          ),
        ),
      ],
    );
  }

  Widget _buildTableContent(
    UpdateHistoryController controller,
    BuildContext context,
  ) {
    if (controller.filteredHistory.isEmpty) {
      return Center(
        child: Text(
          'No error records found',
          style: TextStyle(fontSize: 16, color: primaryColor.withOpacity(0.6)),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(backgroundColor),
          dataRowColor: MaterialStateProperty.all(cardColor),
          columns: _buildColumns(),
          rows: _buildRows(controller, context),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    final headers = [
      'Employee',
      'Store',
      'Date Corrected',
      'Error Fields',
      'Actions',
    ];

    return headers
        .map(
          (header) => DataColumn(
            label: Text(
              header,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
        .toList();
  }

  List<DataRow> _buildRows(
    UpdateHistoryController controller,
    BuildContext context,
  ) {
    return controller.filteredHistory.map((history) {
      return DataRow(
        cells: [
          DataCell(
            Text(history.employeeName, style: TextStyle(color: primaryColor)),
          ),
          DataCell(
            Text(history.storeName, style: TextStyle(color: primaryColor)),
          ),
          DataCell(
            Text(
              DateFormat('dd/MM/yyyy HH:mm').format(history.updatedAt),
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              history.changedFields.join(', '),
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            IconButton(
              icon: const Icon(Icons.visibility, color: Colors.blue),
              onPressed: () => _showDetailsDialog(context, history),
            ),
          ),
        ],
      );
    }).toList();
  }

  void _showDetailsDialog(BuildContext context, UpdateHistoryModel history) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              'Error Details',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: Container(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem('Employee', history.employeeName),
                    _buildDetailItem('Store', history.storeName),
                    _buildDetailItem('Transaction ID', history.transactionId),
                    _buildDetailItem(
                      'Date Corrected',
                      DateFormat('dd/MM/yyyy HH:mm').format(history.updatedAt),
                    ),
                    _buildDetailItem('Correction Reason', history.reason),
                    Divider(height: 24, color: Colors.grey[300]),
                    Text(
                      'Error Details:',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...history.changedFields.map((field) {
                      var originalValue = history.originalData[field] ?? 'N/A';
                      var correctedValue = history.updatedData[field] ?? 'N/A';

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              field,
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.red[50],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Incorrect: $originalValue',
                                      style: TextStyle(color: Colors.red[700]),
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward, color: Colors.grey),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.green[50],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Corrected: $correctedValue',
                                      style: TextStyle(
                                        color: Colors.green[700],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('Close', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: primaryColor))),
        ],
      ),
    );
  }
}
