import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _httpClient;

  ApiClient({
    required this.baseUrl,
    required httpClient,
  }) : _httpClient = httpClient;

  Future<http.Response> post(
    String path,
    Map<String, dynamic> body
  ) async {
    final uri = Uri.parse('$baseUrl$path');

    final headers = {
      'Content-Type': 'application/json',
    };

    return await _httpClient.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
  }
}