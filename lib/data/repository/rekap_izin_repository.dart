// ignore_for_file: prefer_const_constructors
import 'package:deka_mobile/config/local/database_config.dart';
import 'package:deka_mobile/data/entities/profile/profile.dart';
import 'package:deka_mobile/models/response/view_cuti_model.dart';

import '../../core/failure_response.dart';
import '../../models/response/rekap_izin_model.dart';
import '../../utils/strings.dart';
import '../provider/rekap_izin_provider.dart';

//domain - repository
abstract class RekapIzinRepository {
  Future<ProfileEntity> getProfile();
  Future<List<RekapIzinModel>> getRekapIzin();
  Future<ViewCutiModel> getViewIzin();
}

//data - repository
class RekapIzinRepositoryImpl extends RekapIzinRepository {
  RekapIzinRepositoryImpl(this._rekapIzinProvider, this._databaseConfig);

  final RekapIzinProvider _rekapIzinProvider;
  final DatabaseConfig _databaseConfig;

  @override
  Future<ProfileEntity> getProfile() async {
    final models = await _databaseConfig.profileDao.getProfile();
    if(models.isEmpty) {
      throw FailureResponse(message: msgNotFound);
    }

    return models.first;
  }

  @override
  Future<List<RekapIzinModel>> getRekapIzin() async {
    final profile = await getProfile();
    return await _rekapIzinProvider.getRekapIzin(nik: profile.nik);
  }

  @override
  Future<ViewCutiModel> getViewIzin() async {
    final profile = await getProfile();
    return await _rekapIzinProvider.getViewIzin(nik: profile.nik);
  }
}
