class Employee {
  final String id;
  final String name;
  final String email;
  final String department;
  final String role;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.role,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      department: json['department'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'department': department,
      'role': role,
    };
  }

  static List<Employee> get dummyEmployees => [
        Employee(id: 'EMP001', name: 'Alice Parker', email: 'alice.parker@company.com', department: 'Engineering', role: 'Team Lead'),
        Employee(id: 'EMP002', name: 'Bob Smith', email: 'bob.smith@company.com', department: 'Human Resources', role: 'HR Manager'),
        Employee(id: 'EMP003', name: 'Charlie Davis', email: 'charlie.davis@company.com', department: 'Marketing', role: 'Marketing Executive'),
        Employee(id: 'EMP004', name: 'Diana Moore', email: 'diana.moore@company.com', department: 'Sales', role: 'Sales Rep'),
        Employee(id: 'EMP005', name: 'Ethan Hunt', email: 'ethan.hunt@company.com', department: 'Finance', role: 'Accountant'),
        Employee(id: 'EMP006', name: 'Frank White', email: 'frank.white@company.com', department: 'Engineering', role: 'Software Engineer'),
        Employee(id: 'EMP007', name: 'Grace Lee', email: 'grace.lee@company.com', department: 'Engineering', role: 'QA Engineer'),
      ];
}
