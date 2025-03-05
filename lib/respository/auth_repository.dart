
import 'package:http/http.dart' as http;
import 'package:mvvm_provider_completeproject/data/network/BaseApiServices.dart';
import 'package:mvvm_provider_completeproject/data/network/NetworkApiService.dart';
import 'package:mvvm_provider_completeproject/res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndPint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<void> logoutApi(String token) async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.logOutEndPoint),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to logout. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }

}
