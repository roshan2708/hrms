class Company {
  final String id;
  final String name;
  final String? logo;
  final String? address;
  final String? email;

  Company({
    required this.id,
    required this.name,
    this.logo,
    this.address,
    this.email,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'address': address,
      'email': email,
    };
  }
}
