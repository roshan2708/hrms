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

  static List<Department> get dummyDepartments => [
        Department(id: 'D01', name: 'Engineering', head: 'Alice Parker', employeeCount: 45),
        Department(id: 'D02', name: 'Human Resources', head: 'Bob Smith', employeeCount: 5),
        Department(id: 'D03', name: 'Marketing', head: 'Charlie Davis', employeeCount: 12),
        Department(id: 'D04', name: 'Sales', head: 'Diana Moore', employeeCount: 20),
        Department(id: 'D05', name: 'Finance', head: 'Ethan Hunt', employeeCount: 8),
      ];
}
