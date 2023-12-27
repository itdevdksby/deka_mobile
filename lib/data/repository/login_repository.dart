// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';

import 'package:deka_mobile/core/extension.dart';
import 'package:deka_mobile/models/domain/register_domain.dart';
import 'package:deka_mobile/models/response/employee_model.dart';
import 'package:deka_mobile/models/response/general_model.dart';

import '../../config/local/database_config.dart';
import '../../core/failure_response.dart';
import '../../models/mapper/profile_mapper.dart';
import '../../utils/strings.dart';
import '../entities/profile/profile.dart';
import '../provider/login_provider.dart';

//domain - repository
abstract class LoginRepository {
  Future<ProfileEntity> getLogin(String username, String password, String firebaseId);
  Future<EmployeeModel> getCheckNik(String nik);
  Future<GeneralModel> postRegister(RegisterDomain domain);
  Future<GeneralModel> getReset(String nik);
}

//data - repository
class LoginRepositoryImpl extends LoginRepository {
  LoginRepositoryImpl(this._loginProvider, this._databaseConfig);

  final LoginProvider _loginProvider;
  final DatabaseConfig _databaseConfig;

  @override
  Future<ProfileEntity> getLogin(String username, String password, String firebaseId) async {
    final response = await _loginProvider.getLogin(username: username, password: password, firebaseId: firebaseId);

    await _databaseConfig.profileDao.deleteAll().whenComplete(() async =>
      await _databaseConfig.profileDao.insertEntity(ProfileMapper(response))
    );

    final localProfile = await _databaseConfig.profileDao.getProfile();
    if(localProfile.isEmpty) {
      throw FailureResponse(message: msgNotFound);
    }

    return localProfile.first;
  }

  @override
  Future<EmployeeModel> getCheckNik(String nik) async {
    final response = await _loginProvider.getCheckNik(code: "10000", nik: nik);
    if(response.status != "ACTIVE") {
      throw FailureResponse(message: msgNotFound);
    }

    return response;
  }

  @override
  Future<GeneralModel> postRegister(RegisterDomain domain) async {
    domain.device_brand = await generateDeviceBrand();
    domain.device_type = await generateDeviceModel();
    domain.device_id = await generateDeviceId();

    if (domain.foto_temp != null) {
      final imageBytes = await File(domain.foto_temp!).readAsBytes();
      final photoBase64 = base64Encode(imageBytes);

      domain.foto = "data:@file/png;base64,$photoBase64";
    }

    final json = jsonEncode(domain).toString();
    return await _loginProvider.postRegister(data: json);
  }

  @override
  Future<GeneralModel> getReset(String nik) async {
    return await _loginProvider.getReset(nik: nik);
  }
}
