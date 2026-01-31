import 'dart:convert';

import 'package:mingl_app/core/auth/token_storage.dart';
import 'package:mingl_app/core/models/account.dart';
import 'package:mingl_app/core/network/api_client.dart';

class AuthService {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  AuthService({
    required ApiClient apiClient,
    required TokenStorage tokenStorage
  }) : _apiClient = apiClient, _tokenStorage = tokenStorage;

  Future<Account> loginWithGoogle(String idToken) async {
    final response = await _apiClient.post(
      '/auth/google-id-token',
      {
        'idToken': idToken,
      },
    );

    final dto = _LoginResponseDto.fromJson(jsonDecode(response.body));

    await _tokenStorage.save(accessToken: dto.accessToken, refreshToken: dto.refreshToken);
    return dto.account.toDomainModel();
  }
}

class AuthFailedException implements Exception {
  final int statusCode;

  AuthFailedException(this.statusCode);

  @override
  String toString() => 'Auth failed, status code: $statusCode';
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

  Account toDomainModel() {
    return Account(
      id: id,
      email: email
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