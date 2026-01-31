import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mingl_app/core/auth/token_storage.dart';

class FlutterSecureTokenStorage implements TokenStorage {
  final FlutterSecureStorage _secureStorage;

  FlutterSecureTokenStorage(this._secureStorage);

  @override
  Future<void> save({
    required String accessToken,
    required String refreshToken
  }) async {
    await _secureStorage.write(key: _TokenKeys.access, value: accessToken);
    await _secureStorage.write(key: _TokenKeys.refresh, value: refreshToken);
  }

  @override
  Future<String?> getAccessToken() {
    return _secureStorage.read(key: _TokenKeys.access);
  }

  @override
  Future<String?> getRefreshToken() {
    return _secureStorage.read(key: _TokenKeys.refresh);
  }

  @override
  Future<void> clear() async {
    await _secureStorage.delete(key: _TokenKeys.access);
    await _secureStorage.delete(key: _TokenKeys.refresh);
  }
}

class _TokenKeys {
  static const access = 'access_token';
  static const refresh = 'refresh_token';
}