import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mingl_app/core/network/api_client.dart';

final getIt = GetIt.instance;

Future<void> setupDi() async {
  final String apiBaseUrl = dotenv.env['API_BASE_URL']
      ?? (throw StateError('API_BASE_URL not found in .env'));

  getIt.registerLazySingleton<http.Client>(() => http.Client());

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(
        baseUrl: apiBaseUrl,
        httpClient: getIt<http.Client>(),
      ));

  
}