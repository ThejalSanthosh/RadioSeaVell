class Employee {
  final String id;
  final String name;
  final String employeeId;

  final String phoneNo;

  Employee({
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

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json['id'],
    name: json['name'],
    employeeId: json['employeeId'],
    phoneNo: json['phoneNo'],
  );
}
