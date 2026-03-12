class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String type; // e.g., 'leave', 'attendance', 'system'

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    required this.type,
  });

  static List<AppNotification> get dummyNotifications => [
        AppNotification(
          id: 'N01',
          title: 'Leave Approved',
          message: 'Your sick leave request for 15 Oct has been approved.',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: false,
          type: 'leave',
        ),
        AppNotification(
          id: 'N02',
          title: 'Attendance Alert',
          message: 'You missed your check-out yesterday.',
          timestamp: DateTime.now().subtract(const Duration(hours: 18)),
          isRead: false,
          type: 'attendance',
        ),
        AppNotification(
          id: 'N03',
          title: 'System Update',
          message: 'The HRMS will undergo maintenance this Sunday at 2 AM.',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          isRead: true,
          type: 'system',
        ),
        AppNotification(
          id: 'N04',
          title: 'Leave Rejected',
          message: 'Your casual leave request for next week was rejected due to project deadlines.',
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
          isRead: true,
          type: 'leave',
        ),
      ];
}
