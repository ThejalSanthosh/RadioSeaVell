import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/store_view_controller.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StoreController());
  }
}
