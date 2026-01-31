import 'dart:convert';

import 'package:mingl_app/core/models/account.dart';
import 'package:mingl_app/core/network/api_client.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<Account> loginWithGoogle(String idToken) async {
    final response = await _apiClient.post(
      '/auth/google-id-token',
      {
        'idToken': idToken,
      },
    );

    final dto = _LoginResponseDto.fromJson(jsonDecode(response.body));
  }
}

class _AccountDto {
  final int id;
  final String email;

  _AccountDto({
    required this.id,
    required this.email
  });

  factory _AccountDto.fromJson(Map<String, dynamic> json) {
    return _AccountDto(
      id: json['id'] as int,
      email: json['email'] as String,
    );
  }
}

class _LoginResponseDto {
  final _AccountDto account;
  final String accessToken;
  final String refreshToken;

  _LoginResponseDto({
    required this.account,
    required this.accessToken,
    required this.refreshToken,
  });

  factory _LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return _LoginResponseDto(
      account: _AccountDto.fromJson(json['account']),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}

class _RefreshTokenResponseDto {
  final String accessToken;
  final String refreshToken;

  _RefreshTokenResponseDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory _RefreshTokenResponseDto.fromJson(Map<String, dynamic> json) {
    return _RefreshTokenResponseDto(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}