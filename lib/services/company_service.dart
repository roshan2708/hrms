import 'package:http/http.dart' as http;
import '../core/api/api_client.dart';

class CompanyService {
  static Future<http.Response> getAllCompanies() async {
    return await ApiClient.get('/superadmin/companies');
  }

  static Future<http.Response> createCompany(Map<String, dynamic> companyData) async {
    return await ApiClient.post('/superadmin/create-company', companyData);
  }

  static Future<http.Response> getCompanyById(String id) async {
    return await ApiClient.get('/superadmin/companies/$id');
  }

  static Future<http.Response> updateCompany(String id, Map<String, dynamic> updates) async {
    return await ApiClient.put('/superadmin/companies/$id', updates);
  }

  static Future<http.Response> deleteCompany(String id) async {
    return await ApiClient.delete('/superadmin/companies/$id');
  }
}
