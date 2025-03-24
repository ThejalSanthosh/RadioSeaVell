import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:intl/intl.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/outstock_controller.dart';

class OutstockDataTable extends StatelessWidget {
  final Color primaryColor = const Color(0xFF2C3E50);
  final Color cardColor = Colors.white;

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
          // Use Expanded to allow the table to take available vertical space
          child: Scrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                    const Color(0xFFF5F6FA),
                  ),
                  dataRowColor: MaterialStateProperty.all(Colors.white),
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
                      label: Text(
                        'Price',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Quantity',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total',
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
                        'Payment',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows:
                      controller.filteredOutstockData
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
                                DataCell(
                                  Text(
                                    item.price.toString(),
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    item.quantity.toString(),
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '₹${item.totalAmount}',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '₹${item.paidAmount}',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '₹${item.previousBalance}',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '₹${item.currentBalance}',
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
