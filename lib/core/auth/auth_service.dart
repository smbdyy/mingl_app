import 'package:mingl_app/core/models/account.dart';
import 'package:mingl_app/core/network/api_client.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<Account> loginWithGoogle(String idToken) async {
    final response = await _apiClient.post(
      '/auth/google-id-token',
      {
        'idToken': idToken,
      },
    );

    return Account.fromJson(response);
  }
}