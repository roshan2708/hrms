class AppTask {
  final String id;
  final String title;
  final String? description;
  final String status;
  final DateTime? dueDate;
  final String assignedTo;

  AppTask({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.dueDate,
    required this.assignedTo,
  });

  factory AppTask.fromJson(Map<String, dynamic> json) {
    return AppTask(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String,
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
      assignedTo: json['assignedTo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'dueDate': dueDate?.toIso8601String(),
      'assignedTo': assignedTo,
    };
  }
}
