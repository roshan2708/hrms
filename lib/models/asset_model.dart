class Asset {
  final String id;
  final String name;
  final String category;
  final String status;
  final String? serialNumber;

  Asset({
    required this.id,
    required this.name,
    required this.category,
    required this.status,
    this.serialNumber,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      serialNumber: json['serialNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'status': status,
      'serialNumber': serialNumber,
    };
  }
}
