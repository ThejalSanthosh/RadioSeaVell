class Store {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
    };
  }
}