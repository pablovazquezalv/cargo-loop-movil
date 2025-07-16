class User {
  final String email;
  final String name;
  final String phone;
  final int rolId;

  User({
    required this.email,
    required this.name,
    required this.phone,
    required this.rolId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '', // <-- previene null
      name: json['name'] ?? '',
      phone: json['phone']?.toString() ?? '',
      rolId: json['rol_id'] is String ? int.parse(json['rol_id']) : (json['rol_id'] ?? 0),
    );
  }
}
