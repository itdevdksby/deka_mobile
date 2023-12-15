import 'package:deka_mobile/models/response/employee_model.dart';
import 'package:deka_mobile/models/response/general_model.dart';
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

  Future<EmployeeModel> getCheckNik({
    required String code,
    required String nik
  }) async{
    final headers = <String, String>{};
    final formData = FormData({});
    final params = <String, dynamic>{
      'code': code,
      'nik': nik,
    };

    final response = await get("sync-data-hris", query: params, headers: headers);
    if(response.status.isOk){
      EmployeeModel value = EmployeeModel.fromJson(response.body!['data']);
      return value;
    } else {
      throw FailureResponse.fromJson(response.body ?? response.statusText);
    }
  }

  Future<GeneralModel> postRegister({
    required String data
  }) async{
    final headers = <String, String>{};
    final params = <String, dynamic>{};
    final formData = FormData({
      'data': data
    });

    final response = await post("register-user", formData, query: params, headers: headers);
    if(response.status.isOk){
      GeneralModel value = GeneralModel.fromJson(response.body);
      return value;
    } else {
      throw FailureResponse.fromJson(response.body ?? response.statusText);
    }
  }
}