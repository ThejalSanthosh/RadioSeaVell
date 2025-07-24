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
                      items: controller.stores.map((storeName) {
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

    // FIXED: Proper scrollable table with fixed row height
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(backgroundColor),
            dataRowColor: MaterialStateProperty.all(cardColor),
            dataRowMinHeight: 80, // FIXED: Set minimum row height
            dataRowMaxHeight: 120, // FIXED: Set maximum row height
            columnSpacing: 20,
            horizontalMargin: 12,
            columns: _buildColumns(),
            rows: _buildRows(controller, context),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    final headers = [
      'Employee',
      'Vehicle',
      'Items Details',
      'Total Qty',
      'Payment Type',
      'Total Amount',
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
            label: Container(
              width: header == 'Items Details' ? 250 : null, // FIXED: Set width for items column
              child: Text(
                header,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
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
          // FIXED: Items details cell with proper scrolling
          DataCell(
            Container(
              width: 250,
              height: 100, // FIXED: Set fixed height
              child: transaction.items.isEmpty
                  ? Center(
                      child: Text(
                        'No items',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: transaction.items.asMap().entries.map((entry) {
                            int index = entry.key;
                            TransactionItem item = entry.value;
                            return Container(
                              margin: EdgeInsets.only(bottom: 4),
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                'Item ${index + 1}: ${item.quantity} × ₹${item.price.toStringAsFixed(2)} = ₹${item.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 11,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
            ),
          ),
          DataCell(
            Text(
              transaction.totalQuantity.toString(),
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
              '₹${transaction.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              '₹${transaction.paidAmount.toStringAsFixed(2)}',
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              '₹${transaction.previousBalance.toStringAsFixed(2)}',
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(
            Text(
              '₹${transaction.currentBalance.toStringAsFixed(2)}',
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
              _formatUpdatedAt(transaction.updatedAt),
              style: TextStyle(color: primaryColor),
            ),
          ),
          DataCell(_buildActionButtons(context, controller, transaction)),
        ],
      );
    }).toList();
  }

  // Helper method remains the same
  String _formatUpdatedAt(String updatedAt) {
    if (updatedAt.isEmpty) return '-';
    
    try {
      DateTime date = DateTime.parse(updatedAt);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return '-';
    }
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
          icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
          onPressed: () => _showEditDialog(context, transaction),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red, size: 20),
          onPressed: () => _showDeleteConfirmation(context, controller, transaction),
        ),
      ],
    );
  }

  // FIXED: Edit dialog with better scrolling
  void _showEditDialog(BuildContext context, TransactionModel transaction) {
    final employeeController = TextEditingController(text: transaction.employeeName);
    final vehicleController = TextEditingController(text: transaction.vechilePlateNo);
    final totalAmountController = TextEditingController(text: transaction.totalAmount.toString());
    final paidAmountController = TextEditingController(text: transaction.paidAmount.toString());
    final previousCreditController = TextEditingController(text: transaction.previousBalance.toString());
    final currentCreditController = TextEditingController(text: transaction.currentBalance.toString());
    final reasonController = TextEditingController();

    // Create controllers for each item
    List<Map<String, TextEditingController>> itemControllers = transaction.items.map((item) => {
      'price': TextEditingController(text: item.price.toString()),
      'quantity': TextEditingController(text: item.quantity.toString()),
      'amount': TextEditingController(text: item.amount.toString()),
    }).toList();

    final paymentTypes = ['Cash', 'UPI'];
    String selectedPaymentType = transaction.paymentType;
    if (!paymentTypes.contains(selectedPaymentType)) {
      selectedPaymentType = paymentTypes[0];
    }

    void calculateItemAmount(int index) {
      try {
        double price = double.parse(itemControllers[index]['price']!.text);
        int quantity = int.parse(itemControllers[index]['quantity']!.text);
        double amount = price * quantity;
        itemControllers[index]['amount']!.text = amount.toStringAsFixed(2);
        
        // Calculate total amount
        double total = 0;
        for (var controllers in itemControllers) {
          try {
            total += double.parse(controllers['amount']!.text);
          } catch (e) {
            // Handle parsing error
          }
        }
        totalAmountController.text = total.toStringAsFixed(2);
      } catch (e) {
        // Handle calculation error
      }
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            'Edit Transaction',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8, // FIXED: Set dialog width
            height: MediaQuery.of(context).size.height * 0.7, // FIXED: Set dialog height
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(employeeController, 'Employee Name', Icons.person),
                  SizedBox(height: 16),
                  _buildTextField(vehicleController, 'Vehicle Number', Icons.directions_car),
                  SizedBox(height: 16),
                  
                  // Items Section
                  Text(
                    'Items:',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  // FIXED: Items container with max height
                  Container(
                    constraints: BoxConstraints(maxHeight: 300),
                    child: SingleChildScrollView(
                      child: Column(
                        children: itemControllers.asMap().entries.map((entry) {
                          int index = entry.key;
                          var controllers = entry.value;
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: 16),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Item ${index + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        controllers['price']!,
                                        'Price',
                                        Icons.currency_rupee,
                                        onChanged: (_) => setState(() => calculateItemAmount(index)),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: _buildTextField(
                                        controllers['quantity']!,
                                        'Quantity',
                                        Icons.shopping_cart,
                                        onChanged: (_) => setState(() => calculateItemAmount(index)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                _buildTextField(
                                  controllers['amount']!,
                                  'Amount',
                                  Icons.calculate,
                                  enabled: false,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  _buildTextField(totalAmountController, 'Total Amount', Icons.calculate, enabled: false),
                  SizedBox(height: 16),
                  _buildPaymentTypeDropdown(
                    selectedPaymentType, 
                    paymentTypes,
                    (value) => setState(() => selectedPaymentType = value!)
                  ),
                  SizedBox(height: 16),
                  _buildTextField(paidAmountController, 'Paid Amount', Icons.payments),
                  SizedBox(height: 16),
                  _buildTextField(previousCreditController, 'Previous Credit', Icons.credit_score),
                  SizedBox(height: 16),
                  _buildTextField(currentCreditController, 'Current Credit', Icons.account_balance_wallet),
                  SizedBox(height: 16),
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
                    ),
                  ),
                ],
              ),
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

                // Validate all fields before updating
                try {
                  // Validate employee name
                  if (employeeController.text.trim().isEmpty) {
                    throw Exception('Employee name cannot be empty');
                  }

                  // Validate vehicle number
                  if (vehicleController.text.trim().isEmpty) {
                    throw Exception('Vehicle number cannot be empty');
                  }

                  // Validate items data
                  List<Map<String, dynamic>> itemsData = [];
                  for (int i = 0; i < itemControllers.length; i++) {
                    var controllers = itemControllers[i];
                    
                    double price = double.parse(controllers['price']!.text);
                    int quantity = int.parse(controllers['quantity']!.text);
                    double amount = double.parse(controllers['amount']!.text);
                    
                    if (price <= 0) {
                      throw Exception('Price for Item ${i + 1} must be greater than 0');
                    }
                    if (quantity <= 0) {
                      throw Exception('Quantity for Item ${i + 1} must be greater than 0');
                    }
                    
                    itemsData.add({
                      'price': price,
                      'quantity': quantity,
                      'amount': amount,
                    });
                  }

                  // Validate amounts
                  double totalAmount = double.parse(totalAmountController.text);
                  double paidAmount = double.parse(paidAmountController.text);
                  double previousBalance = double.parse(previousCreditController.text);
                  double currentBalance = double.parse(currentCreditController.text);

                  if (totalAmount < 0) {
                    throw Exception('Total amount cannot be negative');
                  }
                  if (paidAmount < 0) {
                    throw Exception('Paid amount cannot be negative');
                  }

                  final updatedData = {
                    'employeeName': employeeController.text.trim(),
                    'vechilePlateNo': vehicleController.text.trim(),
                    'items': itemsData,
                    'totalAmount': totalAmount,
                    'paymentType': selectedPaymentType,
                    'paidAmount': paidAmount,
                    'previousBalance': previousBalance,
                    'balanceAmount': currentBalance,
                    'reason': reasonController.text.trim(),
                    // Don't manually set UpdatedAt here, let the controller handle it
                  };

                  final controller = Get.find<DashboardController>();
                  controller.updateTransaction(transaction.id, updatedData);
                  Navigator.pop(context);
                  
                } catch (e) {
                  Get.snackbar(
                    'Validation Error',
                    e.toString().replaceAll('Exception: ', ''),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    DashboardController controller,
    TransactionModel transaction,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          'Confirm Delete',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to delete this transaction?\n\nEmployee: ${transaction.employeeName}\nVehicle: ${transaction.vechilePlateNo}\nTotal: ₹${transaction.totalAmount}',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
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
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    {bool enabled = true, Function(String)? onChanged}
  ) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: label.contains('Price') || 
                   label.contains('Amount') || 
                   label.contains('Quantity') || 
                   label.contains('Credit')
          ? TextInputType.number
          : TextInputType.text,
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
}


// class TransactionTable extends StatelessWidget {
//   final Color backgroundColor = const Color(0xFFF5F6FA);
//   final Color primaryColor = const Color(0xFF2C3E50);
//   final Color cardColor = Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return GetX<DashboardController>(
//       builder: (controller) {
//         return Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.all(16),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: cardColor,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: DropdownButtonFormField<String>(
//                       dropdownColor: Colors.grey.shade300,
//                       value: controller.selectedStore.value,
//                       style: TextStyle(color: Colors.black),
//                       decoration: InputDecoration(
//                         labelText: 'Select Store',
//                         labelStyle: TextStyle(color: primaryColor),
//                         prefixIcon: Icon(Icons.store, color: primaryColor),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: primaryColor),
//                         ),
//                         filled: true,
//                         fillColor: backgroundColor,
//                       ),
//                       items: controller.stores.map((storeName) {
//                         return DropdownMenuItem(
//                           value: storeName,
//                           child: Text(storeName),
//                         );
//                       }).toList(),
//                       onChanged: (storeName) {
//                         if (storeName != null) {
//                           controller.selectedStore.value = storeName;
//                           controller.loadStoreTransactions();
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: cardColor,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: _buildTableContent(controller, context),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildTableContent(
//     DashboardController controller,
//     BuildContext context,
//   ) {
//     if (controller.selectedStore.value?.isEmpty ?? true) {
//       return Center(
//         child: Text(
//           'Please select a store to view transactions',
//           style: TextStyle(fontSize: 16, color: primaryColor.withOpacity(0.6)),
//         ),
//       );
//     }


//     if (controller.storeTransactions.isEmpty) {
//       return Center(
//         child: Text(
//           'No transactions found for ${controller.selectedStore.value}',
//           style: TextStyle(fontSize: 16, color: primaryColor.withOpacity(0.6)),
//         ),
//       );
//     }

//     return Scrollbar(
//       thumbVisibility: true,
//       trackVisibility: true,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//             headingRowColor: MaterialStateProperty.all(backgroundColor),
//             dataRowColor: MaterialStateProperty.all(cardColor),
//             columns: _buildColumns(),
//             rows: _buildRows(controller, context),
//           ),
//         ),
//       ),
//     );
//   }

// List<DataColumn> _buildColumns() {
//   final headers = [
//     'Employee',
//     'Vehicle',
//     'Items Details',
//     'Total Qty',
//     'Payment Type',
//     'Total Amount',
//     'Paid',
//     'Previous Credit',
//     'Current Credit',
//     'Date',
//     'Updated At',
//     'Actions',
//   ];

//   return headers
//       .map(
//         (header) => DataColumn(
//           label: Text(
//             header,
//             style: TextStyle(
//               color: primaryColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       )
//       .toList();
// }
// List<DataRow> _buildRows(
//   DashboardController controller,
//   BuildContext context,
// ) {
//   return controller.storeTransactions.map((transaction) {
//     return DataRow(
//       cells: [
//         DataCell(
//           Text(
//             transaction.employeeName,
//             style: TextStyle(color: primaryColor),
//           ),
//         ),
//         DataCell(
//           Text(
//             transaction.vechilePlateNo,
//             style: TextStyle(color: primaryColor),
//           ),
//         ),
//         DataCell(
//           Container(
//             constraints: BoxConstraints(maxWidth: 300),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: transaction.items.asMap().entries.map((entry) {
//                 int index = entry.key;
//                 TransactionItem item = entry.value;
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 1),
//                   child: Text(
//                     'Item ${index + 1}: Qty ${item.quantity} × ₹${item.price} = ₹${item.amount}',
//                     style: TextStyle(
//                       color: primaryColor,
//                       fontSize: 12,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//         DataCell(
//           Text(
//             transaction.totalQuantity.toString(),
//             style: TextStyle(color: primaryColor),
//           ),
//         ),
//         DataCell(
//           Text(
//             transaction.paymentType,
//             style: TextStyle(color: primaryColor),
//           ),
//         ),
//         DataCell(
//           Text(
//             '₹${transaction.totalAmount}',
//             style: TextStyle(color: primaryColor),
//           ),
//         ),
//         DataCell(
//           Text(
//             '₹${transaction.paidAmount}',
//             style: TextStyle(color: primaryColor),
//           ),
//         ),
//         DataCell(
//           Text(
//             '₹${transaction.previousBalance}',
//             style: TextStyle(color: primaryColor),
//           ),
//         ),
//         DataCell(
//           Text(
//             '₹${transaction.currentBalance}',
//             style: TextStyle(color: primaryColor),
//           ),
//         ),
//         DataCell(
//           Text(
//             DateFormat('dd/MM/yyyy').format(transaction.timestamp),
//             style: TextStyle(color: primaryColor),
//           ),
//         ),
//         DataCell(
//           Text(
//             _formatUpdatedAt(transaction.updatedAt),
//             style: TextStyle(color: primaryColor),
//           ),
//         ),
//         DataCell(_buildActionButtons(context, controller, transaction)),
//       ],
//     );
//   }).toList();
// }

// // Add this helper method
// String _formatUpdatedAt(String updatedAt) {
//   if (updatedAt.isEmpty) return '-';
  
//   try {
//     DateTime date = DateTime.parse(updatedAt);
//     return DateFormat('dd/MM/yyyy').format(date);
//   } catch (e) {
//     return '-';
//   }
// }


//   Widget _buildActionButtons(
//     BuildContext context,
//     DashboardController controller,
//     TransactionModel transaction,
//   ) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.edit, color: Colors.blue),
//           onPressed: () => _showEditDialog(context, transaction),
//         ),
//         IconButton(
//           icon: const Icon(Icons.delete, color: Colors.red),
//           onPressed:
//               () => _showDeleteConfirmation(context, controller, transaction),
//         ),
//       ],
//     );
//   }
// void _showDeleteConfirmation(
//   BuildContext context,
//   DashboardController controller,
//   TransactionModel transaction,
// ) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       title: Text(
//         'Confirm Delete',
//         style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
//       ),
//       content: Text(
//         'Are you sure you want to delete this transaction?\n\nEmployee: ${transaction.employeeName}\nVehicle: ${transaction.vechilePlateNo}\nTotal: ₹${transaction.totalAmount}',
//         style: TextStyle(color: Colors.black87),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.red,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           onPressed: () {
//             controller.deleteTransaction(transaction.id);
//             Navigator.pop(context);
//           },
//           child: const Text('Delete', style: TextStyle(color: Colors.white)),
//         ),
//       ],
//     ),
//   );
// }

//   void _showEditDialog(BuildContext context, TransactionModel transaction) {
//   final employeeController = TextEditingController(text: transaction.employeeName);
//   final vehicleController = TextEditingController(text: transaction.vechilePlateNo);
//   final totalAmountController = TextEditingController(text: transaction.totalAmount.toString());
//   final paidAmountController = TextEditingController(text: transaction.paidAmount.toString());
//   final previousCreditController = TextEditingController(text: transaction.previousBalance.toString());
//   final currentCreditController = TextEditingController(text: transaction.currentBalance.toString());
//   final reasonController = TextEditingController();

//   // Create controllers for each item
//   List<Map<String, TextEditingController>> itemControllers = transaction.items.map((item) => {
//     'price': TextEditingController(text: item.price.toString()),
//     'quantity': TextEditingController(text: item.quantity.toString()),
//     'amount': TextEditingController(text: item.amount.toString()),
//   }).toList();

//   final paymentTypes = ['Cash', 'UPI'];
//   String selectedPaymentType = transaction.paymentType;
//   if (!paymentTypes.contains(selectedPaymentType)) {
//     selectedPaymentType = paymentTypes[0];
//   }

//   void calculateItemAmount(int index) {
//     try {
//       double price = double.parse(itemControllers[index]['price']!.text);
//       int quantity = int.parse(itemControllers[index]['quantity']!.text);
//       double amount = price * quantity;
//       itemControllers[index]['amount']!.text = amount.toStringAsFixed(2);

//       void calculateTotalAmount() {
//     double total = 0;
//     for (var controllers in itemControllers) {
//       try {
//         total += double.parse(controllers['amount']!.text);
//       } catch (e) {
//         // Handle parsing error
//       }
//     }
//     totalAmountController.text = total.toStringAsFixed(2);
//   }

//       calculateTotalAmount();
//     } catch (e) {
//       // Handle calculation error
//     }
//   }

  
//   showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (context, setState) => AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         title: Text('Edit Transaction',
//             style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 20)),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildTextField(employeeController, 'Employee Name', Icons.person),
//               SizedBox(height: 16),
//               _buildTextField(vehicleController, 'Vehicle Number', Icons.directions_car),
//               SizedBox(height: 16),
              
//               // Items Section
//               Text(
//                 'Items:',
//                 style: TextStyle(
//                   color: primaryColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               SizedBox(height: 8),
              
//               ...itemControllers.asMap().entries.map((entry) {
//                 int index = entry.key;
//                 var controllers = entry.value;
                
//                 return Container(
//                   margin: EdgeInsets.only(bottom: 16),
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade300),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Item ${index + 1}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: primaryColor,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildTextField(
//                               controllers['price']!,
//                               'Price',
//                               Icons.currency_rupee,
//                               onChanged: (_) => setState(() => calculateItemAmount(index)),
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: _buildTextField(
//                               controllers['quantity']!,
//                               'Quantity',
//                               Icons.shopping_cart,
//                               onChanged: (_) => setState(() => calculateItemAmount(index)),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       _buildTextField(
//                         controllers['amount']!,
//                         'Amount',
//                         Icons.calculate,
//                         enabled: false,
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
              
//               _buildTextField(totalAmountController, 'Total Amount', Icons.calculate, enabled: false),
//               SizedBox(height: 16),
//               _buildPaymentTypeDropdown(selectedPaymentType, paymentTypes,
//                   (value) => setState(() => selectedPaymentType = value!)),
//               SizedBox(height: 16),
//               _buildTextField(paidAmountController, 'Paid Amount', Icons.payments),
//               SizedBox(height: 16),
//               _buildTextField(previousCreditController, 'Previous Credit', Icons.credit_score),
//               SizedBox(height: 16),
//               _buildTextField(currentCreditController, 'Current Credit', Icons.account_balance_wallet),
//               SizedBox(height: 16),
//               TextField(
//                 controller: reasonController,
//                 maxLines: 3,
//                 style: TextStyle(color: Colors.black87),
//                 decoration: InputDecoration(
//                   labelText: 'Reason for Correction',
//                   labelStyle: TextStyle(color: Colors.grey[700]),
//                   prefixIcon: Icon(Icons.note_alt, color: primaryColor),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: Colors.grey[300]!),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: primaryColor),
//                   ),
//                   hintText: 'Please explain why this transaction needs correction',
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: primaryColor,
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             ),
//                        onPressed: () {
//               if (reasonController.text.isEmpty) {
//                 Get.snackbar(
//                   'Error',
//                   'Please provide a reason for the correction',
//                   snackPosition: SnackPosition.BOTTOM,
//                   backgroundColor: Colors.red,
//                   colorText: Colors.white,
//                 );
//                 return;
//               }

//               // Validate all fields before updating
//               try {
//                 // Validate employee name
//                 if (employeeController.text.trim().isEmpty) {
//                   throw Exception('Employee name cannot be empty');
//                 }

//                 // Validate vehicle number
//                 if (vehicleController.text.trim().isEmpty) {
//                   throw Exception('Vehicle number cannot be empty');
//                 }

//                 // Validate items data
//                 List<Map<String, dynamic>> itemsData = [];
//                 for (int i = 0; i < itemControllers.length; i++) {
//                   var controllers = itemControllers[i];
                  
//                   double price = double.parse(controllers['price']!.text);
//                   int quantity = int.parse(controllers['quantity']!.text);
//                   double amount = double.parse(controllers['amount']!.text);
                  
//                   if (price <= 0) {
//                     throw Exception('Price for Item ${i + 1} must be greater than 0');
//                   }
//                   if (quantity <= 0) {
//                     throw Exception('Quantity for Item ${i + 1} must be greater than 0');
//                   }
                  
//                   itemsData.add({
//                     'price': price,
//                     'quantity': quantity,
//                     'amount': amount,
//                   });
//                 }

//                 // Validate amounts
//                 double totalAmount = double.parse(totalAmountController.text);
//                 double paidAmount = double.parse(paidAmountController.text);
//                 double previousBalance = double.parse(previousCreditController.text);
//                 double currentBalance = double.parse(currentCreditController.text);

//                 if (totalAmount < 0) {
//                   throw Exception('Total amount cannot be negative');
//                 }
//                 if (paidAmount < 0) {
//                   throw Exception('Paid amount cannot be negative');
//                 }

//                 final updatedData = {
//                   'employeeName': employeeController.text.trim(),
//                   'vechilePlateNo': vehicleController.text.trim(),
//                   'items': itemsData,
//                   'totalAmount': totalAmount,
//                   'paymentType': selectedPaymentType,
//                   'paidAmount': paidAmount,
//                   'previousBalance': previousBalance,
//                   'balanceAmount': currentBalance,
//                   'reason': reasonController.text.trim(),
//                   // Don't manually set UpdatedAt here, let the controller handle it
//                 };

//                 final controller = Get.find<DashboardController>();
//                 controller.updateTransaction(transaction.id, updatedData);
//                 Navigator.pop(context);
                
//               } catch (e) {
//                 Get.snackbar(
//                   'Validation Error',
//                   e.toString().replaceAll('Exception: ', ''),
//                   snackPosition: SnackPosition.BOTTOM,
//                   backgroundColor: Colors.red,
//                   colorText: Colors.white,
//                 );
//               }
//             },
//             child: Text('Save', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     ),
//   );
// }



// Widget _buildTextField(
//   TextEditingController controller,
//   String label,
//   IconData icon,
//   {bool enabled = true,
//    Function(String)? onChanged}) {
//   return TextField(
//     controller: controller,
//     enabled: enabled,
//     keyboardType: label.contains('Price') || label.contains('Amount') || label.contains('Quantity') || label.contains('Credit')
//         ? TextInputType.number
//         : TextInputType.text,
//     onChanged: onChanged,
//     style: TextStyle(color: Colors.black87),
//     decoration: InputDecoration(
//       labelText: label,
//       labelStyle: TextStyle(color: Colors.grey[700]),
//       prefixIcon: Icon(icon, color: primaryColor),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: Colors.grey[300]!),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: primaryColor),
//       ),
//       filled: !enabled,
//       fillColor: enabled ? null : Colors.grey[100],
//     ),
//   );
// }

// Widget _buildPaymentTypeDropdown(
//   String value,
//   List<String> items,
//   Function(String?) onChanged) {
//   return DropdownButtonFormField<String>(
//     value: value,
//     items: items.map((type) => DropdownMenuItem(
//       value: type,
//       child: Text(type),
//     )).toList(),
//     decoration: InputDecoration(
//       labelText: 'Payment Type',
//       labelStyle: TextStyle(color: Colors.grey[700]),
//       prefixIcon: Icon(Icons.payment, color: primaryColor),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: Colors.grey[300]!),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: primaryColor),
//       ),
//     ),
//     onChanged: onChanged,
//   );
// }

// Widget _buildTextField(
//   TextEditingController controller, 
//   String label, 
//   IconData icon, 
//   {bool enabled = true, 
//   Function(String)? onChanged}
// ) {
//   return TextField(
//     controller: controller,
//     enabled: enabled,
//     keyboardType: TextInputType.text,
//     onChanged: onChanged,
//     style: TextStyle(color: Colors.black87),
//     decoration: InputDecoration(
//       labelText: label,
//       labelStyle: TextStyle(color: Colors.grey[700]),
//       prefixIcon: Icon(icon, color: primaryColor),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: Colors.grey[300]!),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: primaryColor),
//       ),
//       filled: !enabled,
//       fillColor: enabled ? null : Colors.grey[100],
//     ),
//   );
// }

// Widget _buildPaymentTypeDropdown(
//   String value, 
//   List<String> items, 
//   Function(String?) onChanged
// ) {
//   return DropdownButtonFormField<String>(
//     value: value,
//     items: items.map((type) => DropdownMenuItem(
//       value: type,
//       child: Text(type),
//     )).toList(),
//     decoration: InputDecoration(
//       labelText: 'Payment Type',
//       labelStyle: TextStyle(color: Colors.grey[700]),
//       prefixIcon: Icon(Icons.payment, color: primaryColor),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: Colors.grey[300]!),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: primaryColor),
//       ),
//     ),
//     onChanged: onChanged,
//   );
// }
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
// }
