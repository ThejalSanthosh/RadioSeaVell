import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/products/controller/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
  }
}