
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:radio_sea_well/app/modules/vechiles/controller/vechile_controller.dart';

class VechileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VehiclesController());
  }
}