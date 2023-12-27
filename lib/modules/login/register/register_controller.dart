// ignore_for_file: prefer_const_constructors

import 'package:deka_mobile/models/domain/register_domain.dart';
import 'package:deka_mobile/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/data_state.dart';
import '../../../core/failure_response.dart';
import '../../../data/repository/login_repository.dart';
import '../../../theme/show_snackbar_message.dart';

class RegisterController extends GetxController{
  RegisterController({
    required this.repository,
  });

  final LoginRepository repository;

  final formKey = GlobalKey<FormState>();
  final editingControllers = List.generate(11, (index) => TextEditingController());
  final initLoadingCheck = false.obs;
  final initLoading = false.obs;
  final initVisible = false.obs;

  final stateCheckNik = Rx<ResponseState>(ResponseDefault());
  void getCheckNik() async {
    try {
      stateCheckNik(ResponseLoading());

      final response = await repository.getCheckNik(
          editingControllers[0].text.toString()
      );

      editingControllers[0].text = response.nik ?? "";
      editingControllers[1].text = response.idNumber ?? "";
      editingControllers[2].text = response.name ?? "";
      editingControllers[3].text = response.emailAddress ?? "";
      editingControllers[4].text = response.mobilePhone ?? "";
      editingControllers[5].text = response.currentAddress ?? "";
      editingControllers[6].text = "${response.birthPlace}, ${DateFormat('dd-MM-yyyy')
          .format(DateFormat('dd/MM/yyyy')
          .parse(response.dateOfBirth ?? ""))}" ?? "";
      editingControllers[7].text = response.costCenterDescription ?? "";
      editingControllers[8].text = response.gradeDescription ?? "";
      editingControllers[9].text = response.orgLevelDescription ?? "";

      stateDomain.value.username = response.nik;
      stateDomain.value.nik = response.nik;
      stateDomain.value.name = response.name;
      stateDomain.value.ktp = response.idNumber;
      stateDomain.value.email = response.emailAddress;
      stateDomain.value.phone_1 = response.mobilePhone;
      stateDomain.value.address = response.currentAddress;
      stateDomain.value.tempat_lahir = response.birthPlace;
      stateDomain.value.tgl_lahir = DateFormat('yyyy-MM-dd')
          .format(DateFormat('dd/MM/yyyy')
          .parse(response.dateOfBirth ?? ""));
      stateDomain.value.cost_center_code = response.costCenterCode;
      stateDomain.value.cost_center_desc = response.costCenterDescription;
      stateDomain.value.jabatan_code = response.gradeCode;
      stateDomain.value.jabatan_desc = response.gradeDescription;
      stateDomain.value.organization_level = response.orgLevelDescription;
      stateDomain.value.organization_level_desc = response.orgLevelDescription;

      Future.delayed(Duration(milliseconds: 500));
      stateCheckNik(ResponseSuccess(response));
    }on FailureResponse catch(e) {
      showSnackBarMessage(Get.context!, TypeMessage.ERROR,
          e.message.toString(), DurationMessage.LENGTH_SHORT);
      stateCheckNik(ResponseFailed(e));
    }
  }

  final stateRegister = Rx<ResponseState>(ResponseDefault());
  final stateDomain = Rx<RegisterDomain>(RegisterDomain());
  void postRegister() async {
    try {
      stateRegister(ResponseLoading());

      final response = await repository.postRegister(stateDomain.value);

      showSnackBarMessage(Get.context!, TypeMessage.SUCCESS,
          msgOkRegister, DurationMessage.LENGTH_SHORT);
      stateRegister(ResponseSuccess(response));
    }on FailureResponse catch(e) {
      showSnackBarMessage(Get.context!, TypeMessage.ERROR,
          e.message.toString(), DurationMessage.LENGTH_SHORT);
      stateRegister(ResponseFailed(e));
    }
  }
}
