import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}