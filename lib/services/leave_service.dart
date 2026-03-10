import '../models/leave_model.dart';
import 'api_service.dart';

class LeaveService {
  final ApiService _apiService = ApiService();

  Future<List<LeaveRequest>> getLeaveRequests() async {
    final List<dynamic> response = await _apiService.get("/leaves");
    return response.map((json) => LeaveRequest.fromJson(json)).toList();
  }

  Future<bool> applyLeave(LeaveRequest request) async {
    final response = await _apiService.post("/leave", request.toJson());
    return response['status'] == 'success';
  }
}
