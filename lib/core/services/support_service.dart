class SupportService {
  static Future<List<dynamic>> getTickets() async {
    return [
      {
        'id': 'TKT-001',
        'subject': 'Email login issue',
        'category': 'IT Support',
        'priority': 'High',
        'status': 'Open',
        'creator': 'John Doe',
        'date': '2026-02-24',
        'description': 'Cannot access outlook account.',
      },
    ];
  }

  static Future<List<dynamic>> getKnowledgeBase() async {
    return [
      { 'id': 1, 'title': 'How to apply for leave?', 'category': 'HR' },
      { 'id': 2, 'title': 'Configuring VPN', 'category': 'IT' },
    ];
  }

  static Future<List<dynamic>> getFeedback() async {
    return [
      { 'id': 1, 'employee': 'Alice Smith', 'subject': 'Office Canteen', 'rating': 4, 'comment': 'Good food.' },
    ];
  }
}
