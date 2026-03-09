class ApiService {
  final String baseUrl = 'https://api.example.com/v1';

  Future<dynamic> get(String endpoint) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return {'status': 'success', 'data': []};
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return {'status': 'success', 'data': data};
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
