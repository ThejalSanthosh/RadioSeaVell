import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/transaction_model.dart';

class TransactionTable extends StatelessWidget {
  final Color backgroundColor = const Color(0xFFF5F6FA);
  final Color primaryColor = const Color(0xFF2C3E50);
  final Color cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GetX<DashboardController>(
      builder: (controller) {
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
                      value: controller.selectedStore.value,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Select Store',
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
                      items:
                          controller.stores.map((storeName) {
                            return DropdownMenuItem(
                              value: storeName,
                              child: Text(storeName),
                            );
                          }).toList(),
                      onChanged: (storeName) {
                        if (storeName != null) {
                          controller.selectedStore.value = storeName;
                          controller.loadStoreTransactions();
                        }
                      },
                    ),
                  ),
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
      },
    );
  }

  Widget _buildTableContent(
    DashboardController controller,
    BuildContext context,
  ) {
    if (controller.selectedStore.value?.isEmpty ?? true) {
      return Center(
        child: Text(
          'Please select a store to view transactions',
          style: TextStyle(fontSize: 16, color: primaryColor.withOpacity(0.6)),
        ),
      );
    }

    if (controller.storeTransactions.isEmpty) {
      return Center(
        child: Text(
          'No transactions found for ${controller.selectedStore.value}',
          style: TextStyle(fontSize: 16, color: primaryColor.withOpacity(0.6)),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(backgroundColor),
        dataRowColor: MaterialStateProperty.all(cardColor),
        columns: _buildColumns(),
        rows: _buildRows(controller, context),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    final headers = [
      'Employee',
      'Vehicle',
      'Price',
      'Quantity',
      'Payment Type',
      'Total',
      'Paid',
      'Previous Credit',
      'Current Credit',
      'Date',
      'Updated At',
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
    DashboardController controller,
    BuildContext context,
  ) {
    return controller.storeTransactions.map((transaction) {
      return DataRow(
        cells: [
          DataCell(
            Text(
              transaction.employeeName,
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              transaction.vechilePlateNo,
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              '₹${transaction.price}',
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              transaction.quantity.toString(),
              style: TextStyle(color: primaryColor),
            ),
          ),

          DataCell(
            Text(
              transaction.paymentType,
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              '₹${transaction.totalAmount}',
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              '₹${transaction.paidAmount}',
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              '₹${transaction.previousBalance}',
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              '₹${transaction.currentBalance}',
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              DateFormat('dd/MM/yyyy').format(transaction.timestamp),
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              transaction.updatedAt.isEmpty
                  ? '-'
                  : DateFormat(
                    'dd/MM/yyyy',
                  ).format(DateTime.parse(transaction.updatedAt)),
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(_buildActionButtons(context, controller, transaction)),
        ],
      );
    }).toList();
  }

  Widget _buildActionButtons(
    BuildContext context,
    DashboardController controller,
    TransactionModel transaction,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () => _showEditDialog(context, transaction),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed:
              () => _showDeleteConfirmation(context, controller, transaction),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    DashboardController controller,
    TransactionModel transaction,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              'Confirm Delete',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Are you sure you want to delete this transaction?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  controller.deleteTransaction(transaction.id);
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }
void _showEditDialog(BuildContext context, TransactionModel transaction) {
  final employeeController = TextEditingController(text: transaction.employeeName);
  final vehicleController = TextEditingController(text: transaction.vechilePlateNo);
  final priceController = TextEditingController(text: transaction.price.toString());
  final quantityController = TextEditingController(text: transaction.quantity.toString());
  final totalAmountController = TextEditingController(text: transaction.totalAmount.toString());
  final paidAmountController = TextEditingController(text: transaction.paidAmount.toString());
  final previousCreditController = TextEditingController(text: transaction.previousBalance.toString());
  final currentCreditController = TextEditingController(text: transaction.currentBalance.toString());
  final reasonController = TextEditingController(); 

  final paymentTypes = ['Cash', 'UPI'];
  String selectedPaymentType = transaction.paymentType;
  if (!paymentTypes.contains(selectedPaymentType)) {
    selectedPaymentType = paymentTypes[0];
  }

  void calculateTotalAndCredit() {
    if (priceController.text.isNotEmpty && quantityController.text.isNotEmpty) {
      try {
        double price = double.parse(priceController.text);
        int quantity = int.parse(quantityController.text);
        double calculatedTotal = price * quantity;
        totalAmountController.text = calculatedTotal.toStringAsFixed(2);
      } catch (e) {
        // Handle calculation error
      }
    }
  }

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Edit Transaction', 
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 20)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(employeeController, 'Employee Name', Icons.person),
              SizedBox(height: 16),
              _buildTextField(vehicleController, 'Vehicle Number', Icons.directions_car),
              SizedBox(height: 16),
              _buildTextField(priceController, 'Price', Icons.currency_rupee, 
                onChanged: (_) => setState(() => calculateTotalAndCredit())),
              SizedBox(height: 16),
              _buildTextField(quantityController, 'Quantity', Icons.shopping_cart, 
                onChanged: (_) => setState(() => calculateTotalAndCredit())),
              SizedBox(height: 16),
              _buildTextField(totalAmountController, 'Total Amount', Icons.calculate, enabled: false),
              SizedBox(height: 16),
              _buildPaymentTypeDropdown(selectedPaymentType, paymentTypes, 
                (value) => setState(() => selectedPaymentType = value!)),
              SizedBox(height: 16),
              _buildTextField(paidAmountController, 'Paid Amount', Icons.payments),
              SizedBox(height: 16),
              _buildTextField(previousCreditController, 'Previous Credit', Icons.credit_score),
              SizedBox(height: 16),
              _buildTextField(currentCreditController, 'Current Credit', Icons.account_balance_wallet),
              SizedBox(height: 16,),
              TextField(
                controller: reasonController,
                maxLines: 3,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  labelText: 'Reason for Correction',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  prefixIcon: Icon(Icons.note_alt, color: primaryColor),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  hintText: 'Please explain why this transaction needs correction',
                ))
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              if (reasonController.text.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Please provide a reason for the correction',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }
              final updatedData = {
                'employeeName': employeeController.text,
                'vechilePlateNo': vehicleController.text,
                'price': double.parse(priceController.text),
                'quantity': int.parse(quantityController.text),
                'totalAmount': double.parse(totalAmountController.text),
                'paymentType': selectedPaymentType,
                'paidAmount': double.parse(paidAmountController.text),
                'previousBalance': double.parse(previousCreditController.text),
                'balanceAmount': double.parse(currentCreditController.text),
                'UpdatedAt': FieldValue.serverTimestamp(),
                                'reason': reasonController.text, 

              };
              
              final controller = Get.find<DashboardController>();
              controller.updateTransaction(transaction.id, updatedData);
              Navigator.pop(context);
            },
            child: Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}
Widget _buildTextField(
  TextEditingController controller, 
  String label, 
  IconData icon, 
  {bool enabled = true, 
  Function(String)? onChanged}
) {
  return TextField(
    controller: controller,
    enabled: enabled,
    keyboardType: TextInputType.text,
    onChanged: onChanged,
    style: TextStyle(color: Colors.black87),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[700]),
      prefixIcon: Icon(icon, color: primaryColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor),
      ),
      filled: !enabled,
      fillColor: enabled ? null : Colors.grey[100],
    ),
  );
}

Widget _buildPaymentTypeDropdown(
  String value, 
  List<String> items, 
  Function(String?) onChanged
) {
  return DropdownButtonFormField<String>(
    value: value,
    items: items.map((type) => DropdownMenuItem(
      value: type,
      child: Text(type),
    )).toList(),
    decoration: InputDecoration(
      labelText: 'Payment Type',
      labelStyle: TextStyle(color: Colors.grey[700]),
      prefixIcon: Icon(Icons.payment, color: primaryColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor),
      ),
    ),
    onChanged: onChanged,
  );
}
  // void _showEditDialog(BuildContext context, TransactionModel transaction) {
  //   final paidAmountController = TextEditingController(
  //     text: transaction.paidAmount.toString(),
  //   );

  //   showDialog(
  //     context: context,
  //     builder:
  //         (context) => AlertDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           title: Text(
  //             'Edit Transaction',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextField(
  //                 controller: paidAmountController,
  //                 style: TextStyle(color: Colors.black),

  //                 decoration: InputDecoration(
  //                   prefixIcon: Icon(Icons.payments, color: Colors.black),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                     borderSide: BorderSide(color: Colors.grey.shade300),
  //                   ),
  //                   enabledBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                     borderSide: BorderSide(color: Colors.grey.shade300),
  //                   ),
  //                   focusedBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                     borderSide: BorderSide(color: primaryColor),
  //                   ),
  //                   filled: true,
  //                   fillColor: backgroundColor,
  //                 ),
  //                 keyboardType: TextInputType.number,
  //               ),
  //             ],
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text('Cancel', style: TextStyle(color: Colors.white)),
  //             ),
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: primaryColor,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //               ),
  //               onPressed: () {
  //                 final controller = Get.find<DashboardController>();
  //                 final newPaidAmount = double.parse(paidAmountController.text);
  //                 controller.updateTransaction(transaction.id, newPaidAmount);
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('Save'),
  //             ),
  //           ],
  //         ),
  //   );
  // }
}
