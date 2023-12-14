// ignore_for_file: prefer_const_constructors
import '../../core/constants.dart';
import '../../models/response/rekap_izin_model.dart';
import '../provider/rekap_izin_provider.dart';

//domain - repository
abstract class RekapIzinRepository {
  Future<List<RekapIzinModel>> getRekapIzin();
}

//data - repository
class RekapIzinRepositoryImpl extends RekapIzinRepository {
  RekapIzinRepositoryImpl(this._rekapIzinProvider);

  final RekapIzinProvider _rekapIzinProvider;

  @override
  Future<List<RekapIzinModel>> getRekapIzin() async {
    return await _rekapIzinProvider.getRekapIzin(nik: NIK_EXAMPLE);
  }
}
