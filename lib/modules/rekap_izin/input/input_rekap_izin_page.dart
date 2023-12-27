// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:deka_mobile/modules/rekap_izin/rekap_izin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data_state.dart';
import '../../../theme/show_snackbar_message.dart';
import '../../../theme/standard_button_primary.dart';
import '../../../theme/standard_text_field.dart';
import '../../../utils/strings.dart';

class InputRekapIzinPage extends GetView<RekapIzinController> {
  InputRekapIzinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.statePostRekapIzin.value is ResponseLoading){
          controller.initLoadingInput.value = true;
        }else if (controller.statePostRekapIzin.value is ResponseFailed){
          controller.initLoadingInput.value = false;
          final response = controller.statePostRekapIzin.value.error;

          WidgetsBinding.instance.addPostFrameCallback((_) =>
              showSnackBarMessage(context, TypeMessage.ERROR,
                  response!.message.toString(), DurationMessage.LENGTH_SHORT));
        }else if (controller.statePostRekapIzin.value is ResponseSuccess){
          controller.initLoadingInput.value = false;

          WidgetsBinding.instance.addPostFrameCallback((_) =>
              Get.back()
          );
        }

        return _buildBody();
      }),
    );
  }

  _buildAppBar() {
    return AppBar(title: Text(rekapIzin));
  }

  _buildBody() {
    return SingleChildScrollView(
      child: _buildContent()
    );
  }

  _buildContent() {
    return Form(
        key: controller.formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [//BELUM SELESAI
              StandardTextField(
                  editingController: controller.editingControllers[0],
                  titleHint: username,
                  msgError: msgNotFound,
                  iconField: Icon(Icons.person_outline),
                  inputType: TextInputType.number),
              StandardTextField(
                  editingController: controller.editingControllers[1],
                  titleHint: password,
                  msgError: msgNotFound,
                  iconField: Icon(Icons.lock_outline),
                  inputAction: TextInputAction.done,
                  isPassword: true),
              StandardButtonPrimary(
                  formKey: controller.formKey,
                  titleHint: submit.toUpperCase(),
                  isLoading: controller.initLoadingInput.value,
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.postRekapIzin();
                    }
                  }
              )
            ])
    );
  }
}
