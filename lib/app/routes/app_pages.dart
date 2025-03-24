import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/dashboard/bindings/instock_binding.dart';
import 'package:radio_sea_well/app/modules/dashboard/bindings/outstock_binding.dart';
import 'package:radio_sea_well/app/modules/dashboard/bindings/update_historybinding.dart';
import 'package:radio_sea_well/app/modules/dashboard/view/dashboard_screen.dart';
import 'package:radio_sea_well/app/modules/dashboard/view/instock_screen.dart';
import 'package:radio_sea_well/app/modules/dashboard/view/outstock_screen.dart';
import 'package:radio_sea_well/app/modules/dashboard/view/piechart_salesreport_screen.dart';
import 'package:radio_sea_well/app/modules/dashboard/view/transaction_screen.dart';
import 'package:radio_sea_well/app/modules/dashboard/view/update_history_screen.dart';
import 'package:radio_sea_well/app/modules/dashboard/view/vehcile_expense_screen.dart';
import 'package:radio_sea_well/app/modules/employees/bindings/employee_bindings.dart';
import 'package:radio_sea_well/app/modules/employees/view/employee_view.dart';
import 'package:radio_sea_well/app/modules/products/bindings/product_binding.dart';
import 'package:radio_sea_well/app/modules/products/view/product_add_dailog.dart';
import 'package:radio_sea_well/app/modules/vechiles/bindings/vechile_binding.dart';
import 'package:radio_sea_well/app/modules/vechiles/view/vechile_view.dart';
import 'package:radio_sea_well/app/routes/app_routes.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';

class AppPages {
  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTS,
      page: () => ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.EMPLOYEES,
      page: () => EmployeesView(),
      binding: EmployeeBindings(),
    ),
    GetPage(
      name: Routes.VEHICLES,
      page: () => VehiclesView(),
      binding: VechileBinding(),
    ),
       GetPage(
      name: Routes.OUTSTOCK,
      page: () => OutstockScreen(),
      binding: OutstockBinding(),
    ),

    GetPage(
      name: Routes.TRANSACTIONS,
      page: () => TransactionScreen(),
      binding: DashboardBinding(),
    ),
     GetPage(
      name: Routes.INSTOCK,
      page: () => InstockScreen(),
      binding: InstockBinding(),
    ),
    GetPage(
  name: '/salesReport',
  page: () => SalesReportScreen(),
        binding: DashboardBinding(),

),
GetPage(
  name: Routes.LOGTRACKING,
  page: () => UpdateHistoryScreen(),
        binding: UpdateHistorybinding(),

),
 GetPage(
      name: Routes.VEHICLEEXPENSES,
      page: () => VehicleExpenseScreen(),
      binding: VechileBinding()
    ),
  ];
}
