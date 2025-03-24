import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/vechile_expense_controller.dart';

class VehicleExpenseScreen extends StatelessWidget {
  const VehicleExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VehicleExpenseController());

    // App colors
    final Color backgroundColor = const Color(0xFFF5F6FA);
    final Color primaryColor = const Color(0xFF2C3E50);
    final Color cardColor = Colors.white;
    final Color textColor = const Color(0xFF2C3E50);
    final Color accentColor = const Color(0xFF3498DB);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Vehicle Expenses',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: accentColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          );
        }

        return Column(
          children: [
            // Filter dropdown
            Container(
              padding: const EdgeInsets.all(16),
              color: cardColor,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Filter by Vehicle:',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.white,
                      ),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        value: controller.selectedFilterVehicleId.value,
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text('Select Vehicle'),
                        items: [
                          DropdownMenuItem<String>(
                            value: 'all',
                            child: Text(
                              'All Vehicles',
                              style: TextStyle(color: textColor),
                            ),
                          ),
                          ...controller.vehicles.map(
                            (vehicle) => DropdownMenuItem(
                              value: vehicle.id,
                              child: Text(
                                vehicle.plateNumber,
                                style: TextStyle(color: textColor),
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedFilterVehicleId.value = value;
                            controller.filterExpenses();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Expense list
            Expanded(
              child:
                  controller.filteredExpenses.isEmpty
                      ? Center(
                        child: Text(
                          'No expenses found',
                          style: TextStyle(color: textColor, fontSize: 16),
                        ),
                      )
                      : ListView.builder(
                        itemCount: controller.filteredExpenses.length,
                        itemBuilder: (context, index) {
                          final expense = controller.filteredExpenses[index];

                          return Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Row(
                                children: [
                                  Text(
                                    expense.vehiclePlateNo,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '₹${expense.amount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.category,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        expense.expenseType,
                                        style: TextStyle(color: primaryColor),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        expense.formattedDate,
                                        style: TextStyle(color: primaryColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        expense.employeeName,
                                        style: TextStyle(color: primaryColor),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.speed,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '${expense.odometerReading} km',
                                        style: TextStyle(color: primaryColor),
                                      ),
                                    ],
                                  ),
                                  if (expense.notes != null &&
                                      expense.notes!.isNotEmpty) ...[
                                    SizedBox(height: 8),
                                    Text(
                                      'Notes: ${expense.notes}',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        );
      }),
    );
  }
}
