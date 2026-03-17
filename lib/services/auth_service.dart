import 'package:http/http.dart' as http;
import '../core/api/api_client.dart';

class AuthService {
  static Future<http.Response> login(String email, String password) async {
    return await ApiClient.post('/auth/login', {
      'email': email,
      'password': password,
    });
  }

  static Future<http.Response> signUp(Map<String, dynamic> userData) async {
    return await ApiClient.post('/auth/super-admin/signup', userData);
  }

  static Future<http.Response> verifySignupOtp(Map<String, dynamic> data) async {
    return await ApiClient.post('/auth/verify-signup-otp', data);
  }

  static Future<http.Response> verifyResetOtp(Map<String, dynamic> data) async {
    return await ApiClient.post('/auth/verify-reset-otp', data);
  }

  static Future<http.Response> forgotPassword(String email) async {
    return await ApiClient.post('/auth/forgot-password', {'email': email});
  }

  static Future<http.Response> resetPassword(Map<String, dynamic> data) async {
    return await ApiClient.post('/auth/reset-password', data);
  }
}
