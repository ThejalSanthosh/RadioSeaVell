class VehicleInstock {
  final String id;
  final String name;
  final String model;
  final String plateNumber;
  final String status;
  final String createdAt;

  VehicleInstock({
    required this.id,
    required this.name,
    required this.model,
    required this.plateNumber,
    required this.status,
    required this.createdAt,
  });

  factory VehicleInstock.fromJson(Map<String, dynamic> json) {
    return VehicleInstock(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      model: json['model'] ?? '',
      plateNumber: json['plateNumber'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}