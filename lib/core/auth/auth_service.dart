import 'dart:async';
import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mingl_app/core/auth/token_storage.dart';
import 'package:mingl_app/core/account/account.dart';
import 'package:mingl_app/core/network/api_client.dart';
import 'package:mingl_app/core/network/api_exception.dart';

class AuthService {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  Account? _currentAccount;
  Account? get currentAccount => _currentAccount;

  bool get isLoggedIn => _currentAccount != null;

  AuthService({
    required ApiClient apiClient,
    required TokenStorage tokenStorage
  }) : _apiClient = apiClient, _tokenStorage = tokenStorage;

  Future<void> tryLoadFromStorageOrRefresh() async {
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

  Future<void>? _refreshInFlight;

  Future<void> tryRefresh() {
    if (_refreshInFlight != null) {
      return _refreshInFlight!;
    }

    final completer = Completer<void>();
    _refreshInFlight = completer.future;

    _executeRefresh().then(
      completer.complete,
      onError: completer.completeError
    ).whenComplete(() {
      _refreshInFlight = null;
    });

    return _refreshInFlight!;
  }

  Future<void> _executeRefresh() async {
    final refreshToken = await _tokenStorage.tryGetRefreshToken();

    if (refreshToken == null) {
      return;
    }

    final response = await _apiClient.post(
      '/auth/refresh-token',
      {
        'refreshToken': refreshToken
      }
    );

    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode);
    }

    final dto = _RefreshTokenResponseDto.fromJson(jsonDecode(response.body));

    await _tokenStorage.save(accessToken: dto.accessToken, refreshToken: dto.refreshToken);
    _fillAccountFromJwt(dto.accessToken);
  }

  void _fillAccountFromJwt(String jwt) {
    final accountDto = _AccountDto.fromJwt(jwt);
    _currentAccount = accountDto.toDomainModel();
  }

  Future<Account> loginWithGoogle(String idToken) async { // todo is account needed?
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
      id: int.parse(decoded['sub'] as String),
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