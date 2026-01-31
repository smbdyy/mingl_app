import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mingl_app/core/auth/flutter_secure_token_storage.dart';
import 'package:mingl_app/core/auth/token_storage.dart';
import 'package:mingl_app/core/config/app_config.dart';
import 'package:mingl_app/core/network/api_client.dart';
import 'package:mingl_app/core/auth/auth_service.dart';

final getIt = GetIt.instance;

Future<void> setupDi() async {
  final appConfig = AppConfig.fromEnv();

  getIt.registerSingleton<AppConfig>(appConfig);

  getIt.registerLazySingleton<http.Client>(() => http.Client());

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: appConfig.apiBaseUrl,
      httpClient: getIt<http.Client>(),
    )
  );

  getIt.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock
      )
    )
  );

  getIt.registerSingleton<TokenStorage>(
    FlutterSecureTokenStorage(getIt<FlutterSecureStorage>())
  );

  getIt.registerLazySingleton<AuthService>(() =>
    AuthService(
      apiClient: getIt<ApiClient>(),
      tokenStorage: getIt<TokenStorage>()
    )
  );
}