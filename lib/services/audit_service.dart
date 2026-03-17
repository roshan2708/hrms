import 'package:http/http.dart' as http;
import '../core/api/api_client.dart';

class AuditService {
  static Future<http.Response> getSuperAdminAuditLogs() async {
    return await ApiClient.get('/superadmin/audit-logs');
  }

  static Future<http.Response> getAdminAuditLogs() async {
    return await ApiClient.get('/admin/audit-logs');
  }

  static Future<http.Response> getGeneralAuditLogs({String? filter}) async {
    String endpoint = '/audit-logs';
    if (filter != null) endpoint += '?filter=$filter';
    return await ApiClient.get(endpoint);
  }
}
