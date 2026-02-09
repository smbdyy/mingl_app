import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _httpClient;

  ApiClient({
    required this.baseUrl,
    required http.Client httpClient
  }) : _httpClient = httpClient;

  Future<http.Response> post(
    String path,
    Map<String, dynamic> body, {
    Map<String, String> additionalHeaders = const {}
  }) async {
    final uri = Uri.parse('$baseUrl$path');

    final headers = {
      'Content-Type': 'application/json',
      ...additionalHeaders
    };

    return await _httpClient.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<http.Response> get(
    String path, {
    Map<String, String> headers = const {}
  }) async {
    final uri = Uri.parse("$baseUrl$path");

    return await _httpClient.get(uri, headers: headers);
  }
}