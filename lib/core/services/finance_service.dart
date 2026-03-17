class FinanceService {
  static Future<List<dynamic>> getLoans() async {
    return [
      { 'id': 101, 'employee': 'Rajesh Kumar', 'amount': '₹50,000', 'type': 'Personal', 'emi': '₹5,000', 'status': 'Active' },
      { 'id': 102, 'employee': 'Sneha Patel', 'amount': '₹2,00,000', 'type': 'Home Renovation', 'emi': '₹10,000', 'status': 'Approved' },
    ];
  }

  static Future<List<dynamic>> getTravelExpenses() async {
    return [
      { 'id': 'EXP-001', 'employee': 'John Doe', 'project': 'Client Visit - NYC', 'amount': '\$1,200', 'date': 'Oct 10, 2025', 'status': 'Approved', 'category': 'Flight' },
      { 'id': 'EXP-002', 'employee': 'Sarah Lee', 'project': 'Tech Conference', 'amount': '\$850', 'date': 'Oct 12, 2025', 'status': 'Pending', 'category': 'Hotel' },
    ];
  }
}
