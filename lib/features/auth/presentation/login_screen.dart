import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mingl_app/core/auth/auth_service.dart';
import 'package:mingl_app/core/config/app_config.dart';
import 'package:mingl_app/core/account/account.dart';
import 'package:mingl_app/di/setup_di.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService;
  final Future<void> Function(BuildContext context) redirectAfterLogin;

  const LoginScreen({
    super.key,
    required this.authService,
    required this.redirectAfterLogin});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Account? _account;

  @override
  void initState() {
    super.initState();

    _initializeGoogleSignIn();
  }

  void _initializeGoogleSignIn() {
    final signIn = GoogleSignIn.instance;
    final appConfig = getIt<AppConfig>();
    unawaited(
      signIn.initialize(serverClientId: appConfig.googleServerClientId).then((
        _,
      ) {
        signIn.authenticationEvents
          .listen(_handleGoogleSignInAuthenticationEvent)
          .onError(_handleGoogleAuthenticationError);

          // todo lightweight auth?
      }),
    );
  }

  Future<void> _handleGoogleSignInAuthenticationEvent(
    GoogleSignInAuthenticationEvent event
  ) async {
    final user =
      switch (event) {
          GoogleSignInAuthenticationEventSignIn(user: final user) => user,
          GoogleSignInAuthenticationEventSignOut() => null,
        };

    if (!mounted) return;

    if (user == null) {
      setState(() {
        _account = null;
      });

      return;
    }

    final idToken = user.authentication.idToken;

    if (idToken == null) {
      throw UnimplementedError('idToken is null'); // todo how is it possible?
    }

    final account = await widget.authService.loginWithGoogle(idToken);

    if (!mounted) return;

    setState(() {
      _account = account;
    });

    await widget.redirectAfterLogin(context);
  }

  Future<void> _handleGoogleAuthenticationError(Object e) async  {
    if (!mounted) return;

    setState(() {
      _account = null;
    });
    // todo message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in screen')),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        if (_account != null)
          ..._buildAuthenticatedWidgets(_account!)
        else
          ..._buildUnathenticatedWidgets()
      ],
    );
  }

  List<Widget> _buildAuthenticatedWidgets(Account account) {
    return <Widget>[
      Text('Signed in: ${account.id}'),
    
      ElevatedButton(
        onPressed: () async { await GoogleSignIn.instance.signOut(); },
        child: const Text('Sign out')
      )
    ];
  }

  List<Widget> _buildUnathenticatedWidgets() {
    return <Widget>[
      if (GoogleSignIn.instance.supportsAuthenticate())
        ElevatedButton(
          onPressed: () async { await GoogleSignIn.instance.authenticate(); },
          child: const Text('Google sign in'),
        )
      else
        const Text('GoogleSignIn unsupported')
    ];
  }
} // todo dispose