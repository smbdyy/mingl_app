import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mingl_app/core/config/app_config.dart';
import 'package:mingl_app/core/network/api_client.dart';
import 'package:mingl_app/core/services/auth_service.dart';

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

  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<ApiClient>()));
}