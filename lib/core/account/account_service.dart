import 'dart:convert';

import 'package:mingl_app/core/macrosCalculation/macros.dart';
import 'package:mingl_app/core/network/api_exception.dart';
import 'package:mingl_app/core/network/authenticated_api_client.dart';

class AccountService {
  final AuthenticatedApiClient _apiClient;

  AccountService(this._apiClient);

  Future<bool> isNutritionProfileFilled() async {
    final response = await _apiClient.get('/account/is-nutrition-profile-filled');

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode);
    }

    return _IsNutritionProfileFilledResponse.fromJson(jsonDecode(response.body)).isFilled;
  }

  Future<Macros> setNutritionProfile({
    required int age,
    required double weightKg,
    required double targetWeightKg,
    required int heightCm,
    required String sex,
    required String activityLevel,
    String? foodExceptions,
    String? foodPreferences,
  }) async {
    final requestBody = {
      'age': age,
      'weightKg': weightKg,
      'targetWeightKg': targetWeightKg,
      'heightCm': heightCm,
      'sex': sex,
      'activityLevel': activityLevel,
      'foodExceptions': foodExceptions,
      'foodPreferences': foodPreferences,
    };

    final response = await _apiClient.post('/account/nutrition-profile/set', requestBody);

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode);
    }

    return _SetNutritionProfileResponse.fromJson(jsonDecode(response.body)).macros.toDomainModel();
  }
}

class _IsNutritionProfileFilledResponse {
  final bool isFilled;

  _IsNutritionProfileFilledResponse({required this.isFilled});

  factory _IsNutritionProfileFilledResponse.fromJson(Map<String, dynamic> json) {
    return _IsNutritionProfileFilledResponse(isFilled: json['isFilled']);
  }
}

class _SetNutritionProfileResponse {
  final _MacrosDto macros;

  _SetNutritionProfileResponse({required this.macros});

  factory _SetNutritionProfileResponse.fromJson(Map<String, dynamic> json) {
    return _SetNutritionProfileResponse(macros: _MacrosDto.fromJson(json['macros']));
  }
}


class _MacrosDto {
  final int kCal;
  final int proteinGrams;
  final int carbohydrateGrams;
  final int fatGrams;

  _MacrosDto({
    required this.kCal,
    required this.proteinGrams,
    required this.carbohydrateGrams,
    required this.fatGrams
  });

  factory _MacrosDto.fromJson(Map<String, dynamic> json) {
    return _MacrosDto(
      kCal: json['kCal'],
      proteinGrams: json['proteinGrams'],
      carbohydrateGrams: json['carbohydrateGrams'],
      fatGrams: json['fatGrams']);
  }

  Macros toDomainModel() {
    return Macros(kCal: kCal, proteinGrams: proteinGrams, carbohydrateGrams: carbohydrateGrams, fatGrams: fatGrams);
  }
}