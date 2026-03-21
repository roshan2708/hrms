import 'dart:async';

class ApiService {
  // Base URL simulation
  final String baseUrl = "http://10.216.87.252:5000/api";
  
  // Simulated session
  static String currentUserEmail = "employee@hrms.com";

  // Generic GET method
  Future<dynamic> get(String endpoint) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // This will return dummy data based on the endpoint
    return _getDummyData(endpoint);
  }

  // Generic POST method
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));
    
    return {"status": "success", "message": "Operation completed successfully"};
  }

  // Dummy data generator for various endpoints
  dynamic _getDummyData(String endpoint) {
    if (endpoint.contains("/employee")) {
      if (currentUserEmail == "superadmin@hrms.com") {
        return {
          "id": "EMP000",
          "name": "Super Admin",
          "email": currentUserEmail,
          "department": "Management",
          "role": "Super Admin"
        };
      } else if (currentUserEmail == "admin@hrms.com") {
        return {
          "id": "EMP001",
          "name": "Admin User",
          "email": currentUserEmail,
          "department": "IT",
          "role": "Admin"
        };
      } else if (currentUserEmail == "hr@hrms.com") {
        return {
          "id": "EMP002",
          "name": "HR Specialist",
          "email": currentUserEmail,
          "department": "Human Resources",
          "role": "HR"
        };
      } else if (currentUserEmail == "manager@hrms.com") {
        return {
          "id": "EMP003",
          "name": "Team Manager",
          "email": currentUserEmail,
          "department": "Engineering",
          "role": "Manager"
        };
      } else {
        return {
          "id": "EMP004",
          "name": "John Employee",
          "email": currentUserEmail,
          "department": "Engineering",
          "role": "Employee"
        };
      }
    } else if (endpoint.contains("/attendance")) {
      final now = DateTime.now();
      return [
        {
          "id": "ATT001",
          "employeeId": "EMP001",
          "date": now.toIso8601String(),
          "checkInTime": DateTime(now.year, now.month, now.day, 9, 0).toIso8601String(),
          "status": "Present"
        },
        {
          "id": "ATT002",
          "employeeId": "EMP001",
          "date": now.subtract(const Duration(days: 1)).toIso8601String(),
          "checkInTime": DateTime(now.year, now.month, now.day - 1, 8, 55).toIso8601String(),
          "checkOutTime": DateTime(now.year, now.month, now.day - 1, 18, 5).toIso8601String(),
          "status": "Present"
        }
      ];
    } else if (endpoint.contains("/leaves")) {
      return [
        {
          "id": "LV001",
          "employeeId": "EMP001",
          "leaveType": "Sick Leave",
          "startDate": DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
          "endDate": DateTime.now().subtract(const Duration(days: 9)).toIso8601String(),
          "status": "Approved",
          "reason": "Flu"
        },
        {
          "id": "LV002",
          "employeeId": "EMP001",
          "leaveType": "Casual Leave",
          "startDate": DateTime.now().add(const Duration(days: 5)).toIso8601String(),
          "endDate": DateTime.now().add(const Duration(days: 6)).toIso8601String(),
          "status": "Pending",
          "reason": "Family event"
        }
      ];
    }
    return null;
  }
}
