import 'dart:convert';

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
}

class _IsNutritionProfileFilledResponse {
  final bool isFilled;

  _IsNutritionProfileFilledResponse({required this.isFilled});

  factory _IsNutritionProfileFilledResponse.fromJson(Map<String, dynamic> json) {
    return _IsNutritionProfileFilledResponse(isFilled: json['isFilled']);
  }
}

