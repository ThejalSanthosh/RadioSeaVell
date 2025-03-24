import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_sea_well/app/modules/vechiles/controller/vechile_controller.dart';
import 'package:radio_sea_well/app/modules/vechiles/model/vechile_model.dart';

class VehiclesView extends GetView<VehiclesController> {
  final Color backgroundColor = const Color(0xFFF5F6FA);
  final Color primaryColor = const Color(0xFF2C3E50);
  final Color cardColor = Colors.white;
  final Color textColor = const Color(0xFF2C3E50);
  final Color accentColor = const Color(0xFF3498DB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                _buildSearchBar(),
                Expanded(child: _buildVehiclesList()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddVehicleDialog(context),
        backgroundColor: accentColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Vehicles Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        onChanged: (value) => controller.searchQuery.value = value,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: 'Search vehicles...',
          hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
          prefixIcon: Icon(Icons.search, color: textColor),
          filled: true,
          fillColor: cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: accentColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildVehiclesList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: accentColor));
      }

      return Container(
        margin: const EdgeInsets.all(24),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.filteredVehicles.length,
          itemBuilder: (context, index) {
            final vehicle = controller.filteredVehicles[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(20),
                title: Text(
                  vehicle.name,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '${vehicle.model} - ${vehicle.plateNumber}',
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: accentColor),
                      onPressed: () => _showEditVehicleDialog(context, vehicle),
                      tooltip: 'Edit Vehicle',
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Color(0xFFE74C3C)),
                      onPressed: () => _showDeleteConfirmation(vehicle.id),
                      tooltip: 'Delete Vehicle',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildDialogTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: primaryColor),
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentColor),
        ),
        filled: true,
        fillColor: backgroundColor,
      ),
    );
  }

  void _showAddVehicleDialog(BuildContext context) {
    controller.clearForm();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Add New Vehicle',
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDialogTextField(
                    controller: controller.nameController,
                    label: 'Vehicle Name',
                    icon: Icons.directions_car,
                  ),
                  const SizedBox(height: 16),
                  _buildDialogTextField(
                    controller: controller.modelController,
                    label: 'Model',
                    icon: Icons.category,
                  ),
                  const SizedBox(height: 16),
                  _buildDialogTextField(
                    controller: controller.plateNumberController,
                    label: 'Plate Number',
                    icon: Icons.pin,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.addVehicle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Obx(
                  () =>
                      controller.isLoading.value
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                ),
              ),
            ],
          ),
    );
  }

  void _showEditVehicleDialog(BuildContext context, Vehicle vehicle) {
    controller.setVehicleData(vehicle);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Edit Vehicle', style: TextStyle(color: Colors.white)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDialogTextField(
                    controller: controller.nameController,
                    label: 'Vehicle Name',
                    icon: Icons.directions_car,
                  ),
                  const SizedBox(height: 16),
                  _buildDialogTextField(
                    controller: controller.modelController,
                    label: 'Model',
                    icon: Icons.category,
                  ),
                  const SizedBox(height: 16),
                  _buildDialogTextField(
                    controller: controller.plateNumberController,
                    label: 'Plate Number',
                    icon: Icons.pin,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.updateVehicle(vehicle.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _showDeleteConfirmation(String vehicleId) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Vehicle', style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          'Are you sure you want to delete this vehicle?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.deleteVehicle(vehicleId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE74C3C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
