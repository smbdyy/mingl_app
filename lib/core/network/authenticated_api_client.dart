import 'package:mingl_app/core/auth/auth_service.dart';
import 'package:mingl_app/core/auth/token_storage.dart';
import 'package:mingl_app/core/network/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:mingl_app/core/network/api_exception.dart';

class AuthenticatedApiClient {
  final ApiClient _apiClient;
  final AuthService _authService;
  final TokenStorage _tokenStorage;

  AuthenticatedApiClient({
    required ApiClient apiClient,
    required AuthService authService,
    required TokenStorage tokenStorage
  }) : _apiClient = apiClient, _authService = authService, _tokenStorage = tokenStorage;

  Future<http.Response> get(String path) async {
    var headers = {
      'Authorization': await _getAuthHeaderValue()
    };

    var response = await _apiClient.get(path, headers: headers);

    if (response.statusCode == 401) {
      await _authService.tryRefresh();
      headers['Authorization'] = await _getAuthHeaderValue();

      response = await _apiClient.get(path, headers: headers);
    }

    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }

    return response;
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    var headers = {
      'Authorization': await _getAuthHeaderValue(),
    };

    var response = await _apiClient.post(path, body, additionalHeaders: headers);

    if (response.statusCode == 401) {
      await _authService.tryRefresh();
      headers['Authorization'] = await _getAuthHeaderValue();

      response = await _apiClient.post(path, body, additionalHeaders: headers);
    }

    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }

    return response;
  }

  Future<String> _getAuthHeaderValue() async {
    final accessToken = await _tokenStorage.tryGetAccessToken();

    if (accessToken == null) {
      throw StateError('Not logged in');
    }

    return 'Bearer $accessToken';
  }
}