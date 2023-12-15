import 'package:deka_mobile/core/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/data_state.dart';
import '../../core/failure_response.dart';
import '../../data/repository/login_repository.dart';

class LoginController extends GetxController{
  LoginController({
    required this.repository,
  });

  final LoginRepository repository;

  final formKey = GlobalKey<FormState>();
  final editingControllers = List.generate(2, (index) => TextEditingController());
  final initVersionName = "".obs;
  final initLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    initVersionName.value = await generateVersionName();
  }

  final stateLogin = Rx<ResponseState>(ResponseDefault());
  void getLogin() async {
    try {
      stateLogin(ResponseLoading());

      final response = await repository.getLogin(
          editingControllers[0].text.toString(),
          editingControllers[1].text.toString(),
          "");
      stateLogin(ResponseSuccess(response));
    }on FailureResponse catch(e) {
      stateLogin(ResponseFailed(e));
    }
  }
}
