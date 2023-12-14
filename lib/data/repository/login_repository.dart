// ignore_for_file: prefer_const_constructors
import '../../config/local/database_config.dart';
import '../../core/failure_response.dart';
import '../../models/mapper/profile_mapper.dart';
import '../../utils/strings.dart';
import '../entities/profile/profile.dart';
import '../provider/login_provider.dart';

//domain - repository
abstract class LoginRepository {
  Future<ProfileEntity> getLogin(String username, String password, String firebaseId);
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
}
