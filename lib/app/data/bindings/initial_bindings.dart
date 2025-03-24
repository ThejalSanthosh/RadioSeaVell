import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:radio_sea_well/app/modules/employees/controller/employee_controller.dart';
import 'package:radio_sea_well/app/modules/products/controller/products_controller.dart';
import 'package:radio_sea_well/app/modules/vechiles/controller/vechile_controller.dart';
import 'package:radio_sea_well/app/services/firebase_service.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseService());
    Get.put(ProductController());
    Get.put(EmployeesController());
    Get.put(VehiclesController());
  }
}