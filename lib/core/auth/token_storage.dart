abstract class TokenStorage {
  Future<void> save({
    required String accessToken,
    required String refreshToken
  });

  Future<String?> tryGetAccessToken();
  Future<String?> tryGetRefreshToken();
  Future<void> clear();
}