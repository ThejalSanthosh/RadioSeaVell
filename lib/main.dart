import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:radio_sea_well/app/data/bindings/initial_bindings.dart';
import 'package:radio_sea_well/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:radio_sea_well/app/routes/app_pages.dart';
import 'package:radio_sea_well/app/theme/app_theme.dart';
import 'package:radio_sea_well/firebase_options.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Ensure this is defined correctly
  );
  //   final dashboardController = Get.put(DashboardController());
  // await dashboardController.initializeData();
runApp(
    GetMaterialApp(
      title: 'Seawell Management',
            initialBinding: InitialBinding(),

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );}
