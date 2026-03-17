class AuditLog {
  final String id;
  final String action;
  final String user;
  final DateTime timestamp;
  final String details;

  AuditLog({
    required this.id,
    required this.action,
    required this.user,
    required this.timestamp,
    required this.details,
  });

  factory AuditLog.fromJson(Map<String, dynamic> json) {
    return AuditLog(
      id: json['id'] as String,
      action: json['action'] as String,
      user: json['user'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      details: json['details'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'action': action,
      'user': user,
      'timestamp': timestamp.toIso8601String(),
      'details': details,
    };
  }
}
