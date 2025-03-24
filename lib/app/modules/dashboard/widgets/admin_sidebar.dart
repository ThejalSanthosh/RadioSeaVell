import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:radio_sea_well/app/modules/dashboard/widgets/menutitle.dart';
import 'package:radio_sea_well/app/routes/app_routes.dart';
import 'package:radio_sea_well/app/utils/responsive_layout.dart';

class AdminSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveLayout.isTablet(context) ? 90 : 250,
      color: Theme.of(context).primaryColor,
      child: ListView(
        children: [
          if (!ResponsiveLayout.isTablet(context))
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Seawell Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          MenuTile(
            onTap: () => Get.toNamed(Routes.DASHBOARD),
            icon: Icons.dashboard,
            title: 'Dashboard',
            isCollapsed: ResponsiveLayout.isTablet(context),
          ),
          MenuTile(
            onTap: () => Get.toNamed(Routes.PRODUCTS),
            icon: Icons.inventory,
            title: 'Products',
            isCollapsed: ResponsiveLayout.isTablet(context),
          ),
          MenuTile(
            onTap: () => Get.toNamed(Routes.EMPLOYEES),
            icon: Icons.people,
            title: 'Employees',
            isCollapsed: ResponsiveLayout.isTablet(context),
          ),
          MenuTile(
            onTap: () => Get.toNamed(Routes.VEHICLES),
            icon: Icons.directions_car,
            title: 'Vehicles',
            isCollapsed: ResponsiveLayout.isTablet(context),
          ),
        ],
      ),
    );
  }
}
