import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;
  static const String baseUrl = 'https://test-api-jlbn.onrender.com/lab2026/v1';

  ApiClient({http.Client? client}) : client = client ?? http.Client();

  Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    return await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 15));
  }
}
