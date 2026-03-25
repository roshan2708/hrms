class OperationsService {
  static Future<List<dynamic>> getCalendarEvents() async {
    return [
      { 'id': 1, 'title': 'Dentist Appointment', 'time': '09:30 - 10:30', 'date': DateTime.now().toString(), 'type': 'personal' },
      { 'id': 2, 'title': 'Team Meeting', 'time': '11:00 - 12:00', 'date': DateTime.now().toString(), 'type': 'work' },
    ];
  }

  static Future<List<dynamic>> getDailyTasks() async {
    return [
      { 'id': 1, 'task': 'Administrative Work', 'employee': 'Meera Joshi', 'manager': 'Arjun Singh', 'description': 'Office coordination', 'createdAt': '26-09-2025' },
    ];
  }

  static Future<List<dynamic>> getAssets() async {
    return [
      { 'id': 'AS-001', 'name': 'MacBook Pro', 'employee': 'John Doe', 'status': 'Assigned' },
    ];
  }
}
