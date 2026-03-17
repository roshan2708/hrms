class Branch {
  final String id;
  final String name;
  final String location;
  final String companyId;

  Branch({
    required this.id,
    required this.name,
    required this.location,
    required this.companyId,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      companyId: json['companyId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'companyId': companyId,
    };
  }
}
