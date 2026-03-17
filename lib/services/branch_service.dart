import 'package:http/http.dart' as http;
import '../core/api/api_client.dart';

class BranchService {
  static Future<http.Response> getAllBranches() async {
    // Note: Endpoint inferred from web menu "Branches"
    return await ApiClient.get('/branches');
  }

  static Future<http.Response> createBranch(Map<String, dynamic> data) async {
    return await ApiClient.post('/branches', data);
  }

  static Future<http.Response> updateBranch(String id, Map<String, dynamic> data) async {
    return await ApiClient.put('/branches/$id', data);
  }

  static Future<http.Response> deleteBranch(String id) async {
    return await ApiClient.delete('/branches/$id');
  }
}
