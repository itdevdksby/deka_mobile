import 'package:get/get.dart';

import '../../config/remote/base_service.dart';
import '../../core/failure_response.dart';
import '../../models/response/rekap_izin_model.dart';
import '../../utils/strings.dart';

class RekapIzinProvider extends BaseService {

  Future<List<RekapIzinModel>> getRekapIzin({String? nik}) async{
      final headers = <String, String>{};
      final params = <String, dynamic>{};
      final formData = FormData({
        'nik': nik
      });

      final response = await post("perizinan/list", formData, query: params, headers: headers);
      if(response.status.isOk){
        List<RekapIzinModel> value = response.body['data']
            .map<RekapIzinModel>((dynamic i) => RekapIzinModel.fromJson(i as Map<String, dynamic>))
            .toList();

        if (value.isEmpty){
          throw FailureResponse(message: msgNotFound);
        }
        return value;
      } else {
        throw FailureResponse.fromJson(response.body ?? response.statusText);
      }
  }
}