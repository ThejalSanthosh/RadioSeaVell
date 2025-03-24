
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/vechile_expense_controller.dart';

class VechileExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VehicleExpenseController());
  }
}