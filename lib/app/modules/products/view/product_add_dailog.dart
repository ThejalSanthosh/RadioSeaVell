import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:radio_sea_well/app/modules/products/controller/products_controller.dart';
import 'package:radio_sea_well/app/utils/responsive_layout.dart';

class ProductsView extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width:
            ResponsiveLayout.isMobile(context)
                ? Get.width * 0.9
                : Get.width * 0.5,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add New Product', style: Get.textTheme.titleLarge),

            SizedBox(height: 16),

            // Price Dropdown
            Obx(
              () => DropdownButton<int>(
                value: controller.selectedPrice.value,
                items:
                    controller.prices
                        .map(
                          (price) => DropdownMenuItem(
                            value: price,
                            child: Text('$price Rs'),
                          ),
                        )
                        .toList(),
                onChanged: (value) => controller.selectedPrice.value = value!,
              ),
            ),

            SizedBox(height: 16),

            // Quantity TextField
            TextField(
              controller: controller.quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Quantity',
                hintText:
                    'How many ${controller.selectedPrice.value} Rs products?',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // Total Amount Display
            Obx(
              () => Text(
                'Total Amount: ${controller.calculateTotal()} Rs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 24),

            ElevatedButton(
              onPressed: () => controller.saveProduct(),
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
