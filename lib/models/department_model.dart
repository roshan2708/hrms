class Department {
  final String id;
  final String name;
  final String head;
  final int employeeCount;

  Department({
    required this.id,
    required this.name,
    required this.head,
    required this.employeeCount,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] as String,
      name: json['name'] as String,
      head: json['head'] as String,
      employeeCount: json['employeeCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'head': head,
      'employeeCount': employeeCount,
    };
  }
}
