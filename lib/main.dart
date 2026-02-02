import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mingl_app/core/auth/auth_service.dart';
import 'package:mingl_app/di/setup_di.dart';
import 'package:mingl_app/features/auth/presentation/login_screen.dart';
import 'package:mingl_app/features/onboarding/presentation/helpers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await setupDi();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();

    return FutureBuilder(
      future: authService.tryLoadFromStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator())));
        }

        if (!authService.isLoggedIn) {
          return MaterialApp(home: LoginScreen(authService: authService));
        }

        return MaterialApp(home: getOnboardingStartScreen());
      }
    );
  }
}
