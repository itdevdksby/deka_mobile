// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';

import '../../core/data_state.dart';
import '../../core/failure_response.dart';
import '../../data/repository/rekap_izin_repository.dart';

class DashboardController extends GetxController {
  final RekapIzinRepository repository;
  DashboardController({
    required this.repository,
  });

  final initVisibleData = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
    getViewIzin();
  }

  final stateProfile = Rx<ResponseState>(ResponseDefault());
  void getProfile() async {
    try {
      stateProfile(ResponseLoading());

      final response = await repository.getProfile();
      stateProfile(ResponseSuccess(response));
    }on FailureResponse catch(e) {
      stateProfile(ResponseFailed(e));
    }
  }

  final stateViewCuti = Rx<ResponseState>(ResponseDefault());
  void getViewIzin() async {
    try {
      stateViewCuti(ResponseLoading());

      final response = await repository.getViewIzin();
      stateViewCuti(ResponseSuccess(response));
    }on FailureResponse catch(e) {
      stateViewCuti(ResponseFailed(e));
    }
  }
}
