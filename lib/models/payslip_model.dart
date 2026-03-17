class PaySlip {
  final String id;
  final String employeeId;
  final String month;
  final String year;
  final double netSalary;
  final String downloadUrl;

  PaySlip({
    required this.id,
    required this.employeeId,
    required this.month,
    required this.year,
    required this.netSalary,
    required this.downloadUrl,
  });

  factory PaySlip.fromJson(Map<String, dynamic> json) {
    return PaySlip(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      month: json['month'] as String,
      year: json['year'] as String,
      netSalary: (json['netSalary'] as num).toDouble(),
      downloadUrl: json['downloadUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'month': month,
      'year': year,
      'netSalary': netSalary,
      'downloadUrl': downloadUrl,
    };
  }
}
