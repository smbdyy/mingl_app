import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mingl_app/core/config/app_config.dart';
import 'package:mingl_app/core/models/account.dart';
import 'package:mingl_app/core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService;

  const LoginScreen({super.key, required this.authService});

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
    final appConfig = GetIt.instance<AppConfig>();
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

    setState(() {
      _account = account;
    });
  }

  Future<void> _handleGoogleAuthenticationError(Object e) async  {
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
} 