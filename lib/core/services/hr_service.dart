import '../api/api_client.dart';

class HRService {
  static Future<List<dynamic>> getWFHRequests() async {
    // Current backend doesn't show WFH specific endpoint, using a simulated response 
    // based on react initRequests for now.
    return [
      { 'id': 1, 'employee': 'John Doe', 'dept': 'Engineering', 'startDate': '2026-06-01', 'endDate': '2026-06-05', 'days': 5, 'reason': 'Medical Emergency', 'status': 'Pending', 'avatar': 'JD' },
      { 'id': 2, 'employee': 'Jane Smith', 'dept': 'Sales', 'startDate': '2026-06-10', 'endDate': '2026-06-12', 'days': 3, 'reason': 'Home Renovation', 'status': 'Approved', 'avatar': 'JS' },
      { 'id': 3, 'employee': 'Riya Gupta', 'dept': 'HR', 'startDate': '2026-06-15', 'endDate': '2026-06-15', 'days': 1, 'reason': 'Internet Works', 'status': 'Pending', 'avatar': 'RG' },
      { 'id': 4, 'employee': 'Arjun Sen', 'dept': 'Marketing', 'startDate': '2026-05-28', 'endDate': '2026-05-30', 'days': 3, 'reason': 'Project Deadline', 'status': 'Rejected', 'avatar': 'AS' },
    ];
  }

  static Future<bool> submitWFHRequest(Map<String, dynamic> data) async {
    // Simulate API call
    return true;
  }

  static Future<bool> updateWFHStatus(int id, String status) async {
    // Simulate API call
    return true;
  }

  static Future<List<dynamic>> getJobs() async {
    return [
      { 'id': 1, 'title': 'Senior React Developer', 'department': 'Engineering', 'type': 'Full-time', 'location': 'Remote', 'applicants': 12, 'status': 'Open', 'postedDate': '2024-01-15' },
      { 'id': 2, 'title': 'UI/UX Designer', 'department': 'Design', 'type': 'Contract', 'location': 'Office', 'applicants': 8, 'status': 'Open', 'postedDate': '2024-01-20' },
      { 'id': 3, 'title': 'Marketing Manager', 'department': 'Marketing', 'type': 'Full-time', 'location': 'Office', 'applicants': 45, 'status': 'Closed', 'postedDate': '2024-01-10' },
    ];
  }

  static Future<List<dynamic>> getCandidates() async {
    return [
      { 'id': 101, 'name': 'John Doe', 'email': 'john@example.com', 'role': 'Senior React Developer', 'stage': 'Interview', 'date': '2024-02-10', 'phone': '+1 234 567 8900' },
      { 'id': 102, 'name': 'Jane Smith', 'email': 'jane@example.com', 'role': 'UI/UX Designer', 'stage': 'Screening', 'date': '2024-02-12', 'phone': '+1 234 567 8901' },
    ];
  }

  static Future<List<dynamic>> getTrainings() async {
    return [
      {
        'id': 1,
        'title': 'React Advanced Patterns',
        'trainer': 'CodeAcademy',
        'date': '2024-03-01',
        'duration': '2 Weeks',
        'participants': 15,
        'status': 'Upcoming',
        'progress': 0,
      },
      {
        'id': 2,
        'title': 'Workplace Safety',
        'trainer': 'Internal HR',
        'date': '2024-02-15',
        'duration': '2 Hours',
        'participants': 45,
        'status': 'Completed',
        'progress': 100,
      },
    ];
  }

  static Future<List<dynamic>> getPerformanceReviews() async {
    return [
      { 'id': 1, 'employee': 'John Doe', 'department': 'Engineering', 'reviewer': 'Robert Fox', 'cycle': 'Q1 2024', 'status': 'Pending Review', 'score': '-' },
      { 'id': 2, 'employee': 'Jane Smith', 'department': 'Design', 'reviewer': 'Cody Fisher', 'cycle': 'Q1 2024', 'status': 'Completed', 'score': '4.5/5' },
      { 'id': 3, 'employee': 'Alice Johnson', 'department': 'Marketing', 'reviewer': 'Bessie Cooper', 'cycle': 'Annual 2023', 'status': 'Completed', 'score': '4.8/5' },
    ];
  }

  static Future<List<dynamic>> getOnboardingCandidates() async {
    return [
      { 'id': 1, 'name': 'Alice Johnson', 'role': 'Frontend Developer', 'dept': 'Engineering', 'date': '2026-02-20', 'status': 'In Progress', 'progress': 60 },
      { 'id': 2, 'name': 'Bob Smith', 'role': 'UI/UX Designer', 'dept': 'Design', 'date': '2026-02-22', 'status': 'Document Verification', 'progress': 80 },
    ];
  }

  static Future<List<dynamic>> getIssuedCertificates() async {
    return [
      { 'name': 'Mark Wilson', 'type': 'Experience Certificate', 'date': 'Apr 10, 2024', 'id': 'EMP-101' },
      { 'name': 'Rohan Mehta', 'type': 'Internship Certificate', 'date': 'Feb 14, 2024', 'id': 'EMP-055' },
    ];
  }
}
