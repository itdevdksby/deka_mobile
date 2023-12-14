import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/data_state.dart';
import '../../core/failure_response.dart';
import '../../data/repository/rekap_izin_repository.dart';

class RekapIzinController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formControllers = List.generate(5, (index) => TextEditingController());

  final RekapIzinRepository repository;
  RekapIzinController({
    required this.repository,
  });

  final rekapIzin = Rx<ResponseState>(ResponseDefault());
  void getRekapIzin() async {
    try {
      rekapIzin(ResponseLoading());

      final response = await repository.getRekapIzin();
      rekapIzin(ResponseSuccess(response));
    }on FailureResponse catch(e) {
      rekapIzin(ResponseFailed(e));
    }
  }
}
