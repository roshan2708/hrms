class SalaryAssignment {
  final String id;
  final String employeeId;
  final String employeeName;
  final double baseSalary;
  final List<Map<String, dynamic>> allowances;
  final List<Map<String, dynamic>> deductions;

  SalaryAssignment({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.baseSalary,
    required this.allowances,
    required this.deductions,
  });

  factory SalaryAssignment.fromJson(Map<String, dynamic> json) {
    return SalaryAssignment(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      baseSalary: (json['baseSalary'] as num).toDouble(),
      allowances: List<Map<String, dynamic>>.from(json['allowances']),
      deductions: List<Map<String, dynamic>>.from(json['deductions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'baseSalary': baseSalary,
      'allowances': allowances,
      'deductions': deductions,
    };
  }
}
