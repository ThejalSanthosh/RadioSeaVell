import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:radio_sea_well/app/modules/dashboard/view/transaction_card.dart';
import 'package:radio_sea_well/app/modules/dashboard/widgets/stats_card.dart';
import 'package:radio_sea_well/app/routes/app_routes.dart';
import 'package:radio_sea_well/app/utils/responsive_layout.dart'
    show ResponsiveLayout;

class DashboardView extends GetView<DashboardController> {
  final Color backgroundColor = const Color(0xFFF5F6FA);
  final Color primaryColor = const Color(0xFF2C3E50);
  final Color cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(
                ResponsiveLayout.isMobile(context) ? 16 : 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(),
                    const SizedBox(height: 24),
                    buildFinancialSummary(),
                    const SizedBox(height: 24),
                    buildStatsGrid(context),
                    if (controller.selectedStore.value != null &&
                        controller.selectedStore.value!.isNotEmpty)
                      buildTransactionSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: buildSpeedDial(context),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Radio Seeval',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          buildDateDisplay(),
        ],
      ),
    );
  }

  Widget buildDateDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        DateFormat('dd-MM-yyyy').format(DateTime.now()),
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildFinancialSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.money, color: const Color(0xFF27AE60)),
                    const SizedBox(width: 8),
                    Text(
                      'Total Amount',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Text(
                    '₹${controller.totalAmount.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 50, width: 1, color: Colors.grey.withOpacity(0.3)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Icon(Icons.credit_card, color: const Color(0xFFE74C3C)),
                      const SizedBox(width: 8),
                      Text(
                        'Total Credit',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Obx(
                    () => Text(
                      '₹${controller.totalCredit.value.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatsGrid(BuildContext context) {
    return Obx(
      () => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount:
            ResponsiveLayout.isDesktop(context)
                ? 3
                : ResponsiveLayout.isTablet(context)
                ? 2
                : 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: ResponsiveLayout.isMobile(context) ? 1.5 : 1.8,
        children: [
          StatsCard(
            title: 'Total Instock',
            value: controller.totalInstock.value.toString(),
            icon: Icons.inventory,
            gradient: const LinearGradient(
              colors: [Color(0xFF3498DB), Color(0xFF2980B9)],
            ),
            onTap: () => Get.toNamed('/inStock'),
          ),
          StatsCard(
            title: 'Total Outstock',
            value: controller.totalOutstock.value.toString(),
            icon: Icons.local_shipping,
            gradient: const LinearGradient(
              colors: [Color(0xFFE67E22), Color(0xFFD35400)],
            ),
            onTap: () => Get.toNamed('/outStock'),
          ),
          StatsCard(
            title: 'Store Transactions',
            value: controller.totalStores.value.toString(),
            icon: Icons.store,
            gradient: const LinearGradient(
              colors: [Color(0xFF9B59B6), Color(0xFF8E44AD)],
            ),
            onTap: () => Get.toNamed('/transactions'),
          ),
          StatsCard(
            title: 'Updated Logs',
            value: controller.totalErrors.value.toString(),
            icon: Icons.error_outline,
            gradient: const LinearGradient(
              colors: [Color(0xFF27AE60), Color(0xFF2ECC71)],
            ),
            onTap: () => Get.toNamed('/logTracking'),
          ),
          StatsCard(
            title: 'Expenses Amount',
            value:
                '₹${controller.vehicleExpensesAmount.value.toStringAsFixed(2)}',
            icon: Icons.attach_money,
            gradient: const LinearGradient(
              colors: [Color(0xFFF39C12), Color(0xFFD35400)],
            ),
            onTap: () => Get.toNamed('/vehicleExpenses'),
          ),

          //       StatsCard(
          //   title: 'Total Sales',
          //   value: '₹${controller.totalAmount.value.toStringAsFixed(2)}',
          //   icon: Icons.attach_money,
          //   gradient: const LinearGradient(
          //     colors: [Color(0xFF1ABC9C), Color(0xFF16A085)],
          //   ),
          //   onTap: () => Get.toNamed('/salesReport'),
          // ),
        ],
      ),
    );
  }

  Widget buildTransactionSection() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(24),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions for ${controller.selectedStore.value}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => controller.selectedStore.value = '',
                icon: const Icon(Icons.close),
                label: const Text('Clear'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TransactionTable(),
        ],
      ),
    );
  }

  Widget buildSpeedDial(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: Theme.of(context).primaryColor,
      spacing: 3,
      childPadding: const EdgeInsets.all(5),
      spaceBetweenChildren: 4,
      renderOverlay: true,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.inventory),
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          label: 'Add Product',
          onTap: () => showAddProductDialog(context),
        ),
        SpeedDialChild(
          child: const Icon(Icons.store),
          backgroundColor: Colors.green[600],
          foregroundColor: Colors.white,
          label: 'Add Store',
          onTap: () => showAddStoreDialog(context),
        ),
        SpeedDialChild(
          child: const Icon(Icons.people),
          backgroundColor: Colors.orange[600],
          foregroundColor: Colors.white,
          label: 'Add Employee',
          onTap: () => Get.toNamed(Routes.EMPLOYEES),
        ),
        SpeedDialChild(
          child: const Icon(Icons.directions_car),
          backgroundColor: Colors.purple[600],
          foregroundColor: Colors.white,
          label: 'Add Vehicle',
          onTap: () => Get.toNamed(Routes.VEHICLES),
        ),
      ],
    );
  }

  // void showAddProductDialog(BuildContext context) {
  //   final quantityController = TextEditingController();
  //   final selectedPrice = 42.obs;
  //   final prices = [42, 84, 125, 170, 300];

  //   showDialog(
  //     context: context,
  //     builder:
  //         (context) => AlertDialog(
  //           title: const Text('Add New Product'),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           content: Container(
  //             width: 400,
  //             padding: const EdgeInsets.all(16),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Container(
  //                   padding: const EdgeInsets.symmetric(vertical: 8),
  //                   child: DropdownButtonFormField<int>(
  //                     decoration: InputDecoration(
  //                       labelText: 'Select Price',
  //                       labelStyle: TextStyle(color: Colors.grey[600]),
  //                       prefixIcon: Icon(
  //                         Icons.currency_rupee,
  //                         color: Colors.grey[600],
  //                       ),
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey[300]!),
  //                       ),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: Colors.grey[300]!),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide(color: primaryColor),
  //                       ),
  //                       filled: true,
  //                       fillColor: Colors.grey[50],
  //                     ),
  //                     value: selectedPrice.value,
  //                     items:
  //                         prices
  //                             .map(
  //                               (price) => DropdownMenuItem(
  //                                 value: price,
  //                                 child: Text('₹$price'),
  //                               ),
  //                             )
  //                             .toList(),
  //                     onChanged: (value) => selectedPrice.value = value!,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 buildTextField(
  //                   controller: quantityController,
  //                   label: 'Quantity',
  //                   icon: Icons.inventory,
  //                   keyboardType: TextInputType.number,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text('Cancel'),
  //               style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 controller.addProduct({
  //                   'price': selectedPrice.value,
  //                   'quantity': int.parse(quantityController.text),
  //                   'type': 'instock',
  //                   'dateAdded': DateTime.now().toIso8601String(),
  //                 });
  //                 Navigator.pop(context);
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.blue[600],
  //                 padding: const EdgeInsets.symmetric(
  //                   horizontal: 24,
  //                   vertical: 12,
  //                 ),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //               ),
  //               child: const Text('Save'),
  //             ),
  //           ],
  //         ),
  //   );
  // }

  void showAddProductDialog(BuildContext context) {
    final quantityController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Product'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Container(
              width: 400,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(
                    controller: priceController,
                    label: 'Price (e.g., 42-M)',
                    icon: Icons.currency_rupee,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    controller: quantityController,
                    label: 'Quantity',
                    icon: Icons.inventory,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate inputs before saving
                  if (priceController.text.isEmpty ||
                      quantityController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please fill in all fields',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                    );
                    return;
                  }

                  try {
                    final priceInput = priceController.text.trim();
                    final quantity = int.parse(quantityController.text);

                    // Validate price format (should contain a dash)
                    // if (!priceInput.contains('-')) {
                    //   Get.snackbar(
                    //     'Error',
                    //     'Price format should be like "42-M"',
                    //     backgroundColor: Colors.red,
                    //     colorText: Colors.white,
                    //     snackPosition: SnackPosition.TOP,
                    //   );
                    //   return;
                    // }

                    // Extract numeric part for validation
                    final priceParts = priceInput.split('-');
                    // if (priceParts.length != 2 ||
                    //     priceParts[0].isEmpty ||
                    //     priceParts[1].isEmpty) {
                    //   Get.snackbar(
                    //     'Error',
                    //     'Price format should be like "42-M"',
                    //     backgroundColor: Colors.red,
                    //     colorText: Colors.white,
                    //     snackPosition: SnackPosition.TOP,
                    //   );
                    //   return;
                    // }

                    final numericPrice = double.parse(priceParts[0]);

                    if (numericPrice <= 0 || quantity <= 0) {
                      Get.snackbar(
                        'Error',
                        'Price and quantity must be greater than 0',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                      );
                      return;
                    }

                    controller.addProduct({
                      'price':
                          priceInput, // Store the full price string (e.g., "42-M")
                      'quantity': quantity,
                      'type': 'instock',
                      'dateAdded': DateTime.now().toIso8601String(),
                    });
                    Navigator.pop(context);
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      'Please enter valid price format (e.g., 42-M) and quantity',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  void showAddStoreDialog(BuildContext context) {
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final districtController = TextEditingController();
    final creditBalanceController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Store'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Container(
              width: 400,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(
                    controller: nameController,
                    label: 'Store Name',
                    icon: Icons.store,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    controller: phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    controller: addressController,
                    label: 'Address',
                    icon: Icons.location_on,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    controller: districtController,
                    label: 'Line',
                    icon: Icons.location_city,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    controller: emailController,
                    label: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),
                  buildTextField(
                    controller: creditBalanceController,
                    label: 'Credit Balance (Optional)',
                    icon: Icons.account_balance_wallet,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
              ),
              ElevatedButton(
                onPressed:
                    () => handleStoreSave(
                      context,
                      nameController,
                      addressController,
                      districtController,
                      phoneController,
                      emailController,
                      creditBalanceController,
                    ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[600]!),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }

  // void handleStoreSave(
  //   BuildContext context,
  //   TextEditingController nameController,
  //   TextEditingController addressController,
  //   TextEditingController districtController,
  //   TextEditingController phoneController,
  //   TextEditingController emailController,
  // ) {
  //   if (nameController.text.isEmpty ||
  //       phoneController.text.isEmpty ||
  //       addressController.text.isEmpty ||
  //       districtController.text.isEmpty) {
  //     Get.snackbar(
  //       'Error',
  //       'Please fill in all required fields.',
  //       backgroundColor: Colors.red[400],
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //       margin: const EdgeInsets.all(16),
  //     );
  //     return;
  //   }

  //   controller.addStore({
  //     'name': nameController.text,
  //     'address': addressController.text,
  //     'district': districtController.text,
  //     'phone': phoneController.text,
  //     'email': emailController.text,
  //     'created_at': DateTime.now(),
  //   });
  //   Navigator.pop(context);
  // }

  void handleStoreSave(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController addressController,
    TextEditingController districtController,
    TextEditingController phoneController,
    TextEditingController emailController,
    TextEditingController creditBalanceController,
  ) {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        districtController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all required fields.',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    // Parse credit balance, default to 0.0 if empty or invalid
    double creditBalance = 0.0;
    if (creditBalanceController.text.isNotEmpty) {
      creditBalance = double.tryParse(creditBalanceController.text) ?? 0.0;
    }

    controller.addStore({
      'name': nameController.text,
      'address': addressController.text,
      'district': districtController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'balanceAmount': creditBalance,
      'UpdatedAt': DateTime.now(),
    });

    Navigator.pop(context);
  }
}
