class Expense {
  final String id;
  final String employeeId;
  final String category;
  final double amount;
  final DateTime date;
  final String status;
  final String? receiptUrl;

  Expense({
    required this.id,
    required this.employeeId,
    required this.category,
    required this.amount,
    required this.date,
    required this.status,
    this.receiptUrl,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      receiptUrl: json['receiptUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status,
      'receiptUrl': receiptUrl,
    };
  }
}
