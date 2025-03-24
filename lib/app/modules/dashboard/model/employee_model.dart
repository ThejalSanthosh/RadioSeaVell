class EmployeeModel {
  final String id;
  final String name;
  final String employeeId;

  final String phoneNo;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.employeeId,

    required this.phoneNo,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'employeeId': employeeId,
    'phoneNo': phoneNo,
  };

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json['id'],
    name: json['name'],
    employeeId: json['employeeId'],
    phoneNo: json['phoneNo'],
  );
}
