class Vehicle {
  final String id;
  final String name;
  final String model;
  final String plateNumber;

  Vehicle({
    required this.id,
    required this.name,
    required this.model,
    required this.plateNumber,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'model': model,
    'plateNumber': plateNumber,
  };

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json['id'],
    name: json['name'],
    model: json['model'],
    plateNumber: json['plateNumber'],
  );
}