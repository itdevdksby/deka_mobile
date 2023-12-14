import 'package:get/get.dart';

import '../../config/remote/base_service.dart';
import '../../core/failure_response.dart';
import '../../models/response/login_model.dart';

class LoginProvider extends BaseService {
  Future<LoginModel> getLogin({
    required String username,
    required String password,
    required String firebaseId,
  }) async{
      final headers = <String, String>{};
      final params = <String, dynamic>{};
      final formData = FormData({
        'username': username,
        'password': password,
        'firebase_id': firebaseId,
      });

      final response = await post("login", formData, query: params, headers: headers);
      if(response.status.isOk){
        LoginModel value = LoginModel.fromJson(response.body!['data']['profile']);
        return value;
      } else {
        throw FailureResponse.fromJson(response.body ?? response.statusText);
      }
  }
}