import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mingl_app/core/auth/token_storage.dart';
import 'package:mingl_app/core/models/account.dart';
import 'package:mingl_app/core/network/api_client.dart';

class AuthService {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  Account? _currentAccount;
  Account? get currentAccount => _currentAccount;

  bool get isLoggenIn => _currentAccount != null;

  AuthService({
    required ApiClient apiClient,
    required TokenStorage tokenStorage
  }) : _apiClient = apiClient, _tokenStorage = tokenStorage;

  Future<void> tryLoadFromStorage() async {
    final accessToken = await _tokenStorage.tryGetAccessToken();
    final refreshToken = await _tokenStorage.tryGetRefreshToken();

    if (accessToken == null || refreshToken == null) {
      await _tokenStorage.clear();
      _currentAccount = null;

      return;
    }

    if (isTokenExpired(accessToken)) {
      await tryRefresh();
    }
    else {
      _fillAccountFromJwt(accessToken);
    }
  }

  static bool isTokenExpired(String jwt) {
    final decoded = JwtDecoder.decode(jwt);

    final expClaim = decoded['exp'] as int;
    final expiry = DateTime.fromMillisecondsSinceEpoch(expClaim * 1000);

    return DateTime.now().toUtc().isAfter(expiry);
  }

  Future<void> tryRefresh() async {
    final refreshToken = await _tokenStorage.tryGetRefreshToken();

    if (refreshToken == null) {
      return;
    }

    final response = await _apiClient.post(
      '/auth/refersh-token',
      {
        'refreshToken': refreshToken
      }
    );

    final dto = _RefreshTokenResponseDto.fromJson(jsonDecode(response.body));

    await _tokenStorage.save(accessToken: dto.accessToken, refreshToken: dto.refreshToken);
    _fillAccountFromJwt(dto.accessToken);
  }

  void _fillAccountFromJwt(String jwt) {
    final accountDto = _AccountDto.fromJwt(jwt);
    _currentAccount = accountDto.toDomainModel();
  }

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

  factory _AccountDto.fromJwt(String jwt) {
    final decoded = JwtDecoder.decode(jwt);
    
    return _AccountDto(
      id: decoded['sub'] as int,
      email: decoded['email'] as String
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