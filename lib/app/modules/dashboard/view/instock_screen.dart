import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/instock_controller.dart';

class InstockScreen extends StatelessWidget {
  final Color backgroundColor = const Color(0xFFF5F6FA);
  final Color primaryColor = const Color(0xFF2C3E50);
  final Color cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InstockController());

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Instock Details'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildTypeSelector(controller),
          Expanded(child: _buildDataTable(controller)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => _showReturnStockDialog(context, controller),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showReturnStockDialog(
    BuildContext context,
    InstockController controller,
  ) {
    controller.prepareForNewSelection();

    Get.dialog(
      AlertDialog(
        title: Text('Return Stock', style: TextStyle(color: Colors.white)),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Vehicle Dropdown
              DropdownButtonFormField<String>(
                decoration: _getInputDecoration('Select Vehicle'),
                value:
                    controller.selectedVehicleId.value.isEmpty
                        ? null
                        : controller.selectedVehicleId.value,
                items:
                    controller.vehicles
                        .map(
                          (vehicle) => DropdownMenuItem(
                            value: vehicle.id,
                            child: Text(vehicle.plateNumber),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  controller.selectedVehicleId.value = value ?? '';
                  controller.selectedEmployeeId.value =
                      ''; // Reset employee selection
                  controller.selectedPrice.value = "0";
                  controller.maxOutstock.value = 0;
                },
              ),
              SizedBox(height: 16),

              // Employee Dropdown
              DropdownButtonFormField<String>(
                decoration: _getInputDecoration('Select Employee'),
                value:
                    controller.selectedEmployeeId.value.isEmpty
                        ? null
                        : controller.selectedEmployeeId.value,
                items:
                    controller.employees
                        .map(
                          (employee) => DropdownMenuItem(
                            value: employee.id,
                            child: Text(employee.name),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  controller.selectedEmployeeId.value = value ?? '';
                  controller.selectedPrice.value = "0";
                  controller.maxOutstock.value = 0;
                },
              ),
              SizedBox(height: 16),

              // Price Dropdown
              DropdownButtonFormField<String>(
                // Changed from <double> to <String>
                decoration: _getInputDecoration('Select Price'),
                value:
                    controller
                            .selectedPrice
                            .value
                            .isEmpty // Changed condition
                        ? null
                        : controller.selectedPrice.value,
                items: controller.getAvailablePrices(),
                onChanged: (value) {
                  controller.selectedPrice.value =
                      value ?? ''; // Changed from 0 to ''
                  controller.updateMaxOutstock(); // Now update max outstock
                },
              ),
              SizedBox(height: 16),

              // Available Quantity Display
              controller.isLoading.value
                  ? CircularProgressIndicator()
                  : Text(
                    'Available Quantity: ${controller.maxOutstock.value}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              SizedBox(height: 16),

              // Return Quantity Input
              TextField(
                decoration: _getInputDecoration('Return Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    try {
                      controller.quantity.value = int.parse(value);
                    } catch (e) {
                      // Handle invalid input
                      controller.quantity.value = 0;
                    }
                  } else {
                    controller.quantity.value = 0;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed:
                  controller.quantity.value > 0 &&
                          controller.quantity.value <=
                              controller.maxOutstock.value &&
                          controller.selectedEmployeeId.value.isNotEmpty
                      ? () async {
                        if (await controller.addReturnedStock()) {
                          Get.back();
                          Get.snackbar(
                            'Success',
                            'Stock returned successfully',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        }
                      }
                      : null, // Disable button if quantity is invalid or employee not selected
              child: Text(
                'Return Stock',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: primaryColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildTypeSelector(InstockController controller) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTypeButton(controller, 'All'),
            _buildTypeButton(controller, 'Instock'),
            _buildTypeButton(controller, 'Morning Stock'),

            _buildTypeButton(controller, 'Vehicle Stock'),

            _buildTypeButton(controller, 'Return'),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(InstockController controller, String type) {
    return GestureDetector(
      onTap: () => controller.selectedType.value = type,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              controller.selectedType.value == type
                  ? primaryColor
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          type,
          style: TextStyle(
            color:
                controller.selectedType.value == type
                    ? Colors.white
                    : Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDataTable(InstockController controller) {
    return Obx(() {
      final filteredData = controller.getFilteredData();

      return Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child:
            filteredData.isEmpty
                ? Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                )
                : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 20,
                      headingRowColor: MaterialStateProperty.all(
                        Colors.grey[100],
                      ),
                      columns: [
                        DataColumn(
                          label: Text(
                            'Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Type',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Price',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Quantity',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Vehicle',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Employee',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                      rows:
                          filteredData.map((product) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    _formatDate(product.dateAdded),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight:
                                          controller.selectedType.value ==
                                                  'Instock'
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor(product.type),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _formatType(product.type),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '₹${product.price}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    product.quantity.toString(),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight:
                                          controller.selectedType.value ==
                                                  'Instock'
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    controller.getVehiclePlateNumber(
                                      product.vehicleId,
                                    ),
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    controller.getEmployeeName(
                                      product.employeeId,
                                    ),
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                ),
      );
    });
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatType(String type) {
    switch (type) {
      case 'instock':
        return 'In Stock';
      case 'vehicle_stock':
        return 'Vehicle';
      case 'return':
        return 'Return';
      default:
        return type.capitalize ?? type;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'instock':
        return Colors.green;
      case 'vehicle_stock':
        return Colors.blue;
      case 'return':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
