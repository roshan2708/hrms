import 'package:http/http.dart' as http;
import '../core/api/api_client.dart';

class AssetService {
  static Future<http.Response> getAllAssets() async {
    return await ApiClient.get('/assets');
  }

  static Future<http.Response> getAssetCategories() async {
    return await ApiClient.get('/assets/categories');
  }

  static Future<http.Response> createAsset(Map<String, dynamic> data) async {
    return await ApiClient.post('/assets', data);
  }

  static Future<http.Response> allocateAsset(Map<String, dynamic> data) async {
    return await ApiClient.post('/assets/allocate', data);
  }
}
