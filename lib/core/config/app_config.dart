import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  final String apiBaseUrl;
  final String googleServerClientId;

  const AppConfig({
    required this.apiBaseUrl,
    required this.googleServerClientId
  });

  factory AppConfig.fromEnv() {
    return AppConfig(
      apiBaseUrl: _getRequiredValue('API_BASE_URL'),
      googleServerClientId: _getRequiredValue('GOOGLE_SERVER_CLIENT_ID')
    );
  }

  static String _getRequiredValue(String key) {
      final value = dotenv.env[key];

      if (value == null || value.isEmpty) {
        throw StateError('Environment variable $key is not set');
      }

      return value;
  }
}