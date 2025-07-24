import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:intl/intl.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/outstock_controller.dart';
import 'package:radio_sea_well/app/modules/dashboard/model/outstock_model.dart';

// class OutstockDataTable extends StatelessWidget {
//   final Color primaryColor = const Color(0xFF2C3E50);
//   final Color cardColor = Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return GetX<OutstockController>(
//       builder: (controller) {
//         return Container(
//           margin: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: cardColor,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           // Use Expanded to allow the table to take available vertical space
//           child: Scrollbar(
//             thumbVisibility: true,
//             trackVisibility: true,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   headingRowColor: MaterialStateProperty.all(
//                     const Color(0xFFF5F6FA),
//                   ),
//                   dataRowColor: MaterialStateProperty.all(Colors.white),
//                   columns: [
//                     DataColumn(
//                       label: Text(
//                         'Date',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Store',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Employee',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Vehicle',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Price',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Quantity',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Total',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Paid Amount',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Previous Credit',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Current Credit',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Payment',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                   rows:
//                       controller.filteredOutstockData
//                           .map(
//                             (item) => DataRow(
//                               cells: [
//                                 DataCell(
//                                   Text(
//                                     DateFormat('dd/MM/yyyy').format(item.date),
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Text(
//                                     item.storeName,
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Text(
//                                     item.employeeName,
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Text(
//                                     item.vechilePlateNo,
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Text(
//                                     item.price.toString(),
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Text(
//                                     item.quantity.toString(),
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Text(
//                                     '₹${item.totalAmount}',
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Text(
//                                     '₹${item.paidAmount}',
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Text(
//                                     '₹${item.previousBalance}',
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Text(
//                                     '₹${item.currentBalance}',
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Text(
//                                     item.paymentType,
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                           .toList(),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


// class OutstockDataTable extends StatelessWidget {
//   final Color primaryColor = const Color(0xFF2C3E50);
//   final Color cardColor = Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return GetX<OutstockController>(
//       builder: (controller) {
//         return Container(
//           margin: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: cardColor,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Scrollbar(
//             thumbVisibility: true,
//             trackVisibility: true,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   headingRowColor: MaterialStateProperty.all(
//                     const Color(0xFFF5F6FA),
//                   ),
//                   dataRowColor: MaterialStateProperty.all(Colors.white),
//                   columns: [
//                     DataColumn(
//                       label: Text(
//                         'Date',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Store',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Employee',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Vehicle',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Items Details',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Total Qty',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Total Amount',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Paid Amount',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Previous Credit',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Current Credit',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Payment Type',
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                   rows: controller.filteredOutstockData
//                       .map(
//                         (item) => DataRow(
//                           cells: [
//                             DataCell(
//                               Text(
//                                 DateFormat('dd/MM/yyyy').format(item.date),
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ),
//                             DataCell(
//                               Text(
//                                 item.storeName,
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ),
//                             DataCell(
//                               Text(
//                                 item.employeeName,
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ),
//                             DataCell(
//                               Text(
//                                 item.vechilePlateNo,
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ),
//                             DataCell(
//                               Container(
//                                 constraints: BoxConstraints(maxWidth: 300),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: item.items.asMap().entries.map((entry) {
//                                     int index = entry.key;
//                                     OutstockItem subItem = entry.value;
//                                     return Padding(
//                                       padding: const EdgeInsets.symmetric(vertical: 1),
//                                       child: Text(
//                                         'Item ${index + 1}: Qty ${subItem.quantity} × ₹${subItem.price} = ₹${subItem.amount}',
//                                         style: TextStyle(
//                                           color: primaryColor,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             ),
//                             DataCell(
//                               Text(
//                                 item.totalQuantity.toString(),
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ),
//                             DataCell(
//                               Text(
//                                 '₹${item.totalAmount}',
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ),
//                             DataCell(
//                               Text(
//                                 '₹${item.paidAmount}',
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ),
//                             DataCell(
//                               Text(
//                                 '₹${item.previousBalance}',
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ),
//                             DataCell(
//                               Text(
//                                 '₹${item.currentBalance}',
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ),
//                             DataCell(
//                               Text(
//                                 item.paymentType,
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }




class OutstockDataTable extends StatelessWidget {
  final Color primaryColor = const Color(0xFF2C3E50);
  final Color cardColor = Colors.white;
  final Color backgroundColor = const Color(0xFFF5F6FA);

  @override
  Widget build(BuildContext context) {
    return GetX<OutstockController>(
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.all(16),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(backgroundColor),
                  dataRowColor: MaterialStateProperty.all(Colors.white),
                  dataRowMinHeight: 80, // FIXED: Set minimum row height
                  dataRowMaxHeight: 120, // FIXED: Set maximum row height
                  columnSpacing: 20,
                  horizontalMargin: 12,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Store',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Employee',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Vehicle',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        width: 250, // FIXED: Set width for items column
                        child: Text(
                          'Items Details',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total Qty',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total Amount',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Paid Amount',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Previous Credit',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Current Credit',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Payment Type',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: controller.filteredOutstockData
                      .map(
                        (item) => DataRow(
                          cells: [
                            DataCell(
                              Text(
                                DateFormat('dd/MM/yyyy').format(item.date),
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.storeName,
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.employeeName,
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.vechilePlateNo,
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            // FIXED: Items details cell with proper scrolling
                            DataCell(
                              Container(
                                width: 250,
                                height: 100, // FIXED: Set fixed height
                                child: item.items.isEmpty
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
                                            children: item.items.asMap().entries.map((entry) {
                                              int index = entry.key;
                                              OutstockItem subItem = entry.value;
                                              return Container(
                                                margin: EdgeInsets.only(bottom: 4),
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: backgroundColor,
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(color: Colors.grey.shade300),
                                                ),
                                                child: Text(
                                                  'Item ${index + 1}: ${subItem.quantity} × ₹${subItem.price.toStringAsFixed(2)} = ₹${subItem.amount.toStringAsFixed(2)}',
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
                                item.totalQuantity.toString(),
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            DataCell(
                              Text(
                                '₹${item.totalAmount.toStringAsFixed(2)}',
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            DataCell(
                              Text(
                                '₹${item.paidAmount.toStringAsFixed(2)}',
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            DataCell(
                              Text(
                                

                                '₹${item.previousBalance.toStringAsFixed(2)}',
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            DataCell(
                              Text(
                                '₹${item.currentBalance.toStringAsFixed(2)}',
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.paymentType,
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}