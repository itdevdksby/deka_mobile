// ignore_for_file: prefer_const_constructors

import 'package:deka_mobile/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data_state.dart';
import '../../../core/failure_response.dart';
import '../../../data/repository/login_repository.dart';
import '../../../theme/show_snackbar_message.dart';

class ResetController extends GetxController{
  ResetController({
    required this.repository,
  });

  final LoginRepository repository;

  final formKey = GlobalKey<FormState>();
  final editingControllers = List.generate(1, (index) => TextEditingController());
  final initLoading = false.obs;

  final stateReset = Rx<ResponseState>(ResponseDefault());
  void getReset() async {
    try {
      stateReset(ResponseLoading());

      final response = await repository.getReset(editingControllers[0].text.toString());

      showSnackBarMessage(Get.context!, TypeMessage.SUCCESS,
          msgOkReset, DurationMessage.LENGTH_SHORT);
      stateReset(ResponseSuccess(response));
    }on FailureResponse catch(e) {
      showSnackBarMessage(Get.context!, TypeMessage.ERROR,
          e.message.toString(), DurationMessage.LENGTH_SHORT);
      stateReset(ResponseFailed(e));
    }
  }
}
