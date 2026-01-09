import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _httpClient;

  ApiClient({
    required this.baseUrl,
    required httpClient,
  }) : _httpClient = httpClient;

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body
  ) async {
    final uri = Uri.parse('$baseUrl$path');

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await _httpClient.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw HttpException('API exception(${response.statusCode}): ${response.body}');
  }
}