import 'package:flutter/material.dart';
import 'package:mingl_app/core/account/account_service.dart';
import 'package:mingl_app/core/auth/auth_service.dart';
import 'package:mingl_app/di/setup_di.dart';
import 'package:mingl_app/features/auth/presentation/login_screen.dart';
import 'package:mingl_app/features/bootstrap/loading_screen.dart';
import 'package:mingl_app/features/onboarding/presentation/helpers.dart';

class BootstrapScreen extends StatefulWidget {
  const BootstrapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends State<BootstrapScreen> {
  late final AuthService _authService;
  late final AccountService _accountService;

  @override
  void initState() {
    super.initState();

    _authService = getIt<AuthService>();
    _accountService = getIt<AccountService>();

    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await _authService.tryLoadFromStorageOrRefresh();

    if (!mounted) return;

    if (!_authService.isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen(
          authService: _authService,
          redirectAfterLogin: _redirectAfterLogin))
      );
    }

    await _redirectAfterLogin(context);
  }

  Future<void> _redirectAfterLogin(BuildContext context) async {
    final isNutritionProfileFilled = await _accountService.isNutritionProfileFilled();

    if (!context.mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) =>
        isNutritionProfileFilled ? throw UnimplementedError() : getOnboardingStartScreen()
      )
    );
  }

  @override
  Widget build(BuildContext context) => const LoadingScreen();
}