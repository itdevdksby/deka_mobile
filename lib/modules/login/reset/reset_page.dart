// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:deka_mobile/modules/login/reset/reset_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/standard_button_primary.dart';
import '../../../theme/standard_text_field.dart';
import '../../../utils/strings.dart';

class ResetPage extends GetView<ResetController> {
  ResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.stateReset.value is ResponseLoading){
          FocusScope.of(context).unfocus();
          controller.initLoading.value = true;
        }else if (controller.stateReset.value is ResponseFailed){
          controller.initLoading.value = false;
        }else if (controller.stateReset.value is ResponseSuccess){
          controller.initLoading.value = false;

          WidgetsBinding.instance.addPostFrameCallback((_) => Get.back());
        }

        return _buildBody();
      }),
    );
  }

  _buildAppBar() {
    return AppBar(title: Text(reset));
  }

  _buildBody() {
    return SingleChildScrollView(
      child: _buildContent(),
    );
  }

  _buildContent() {
    return Builder(builder: (context) =>
        Form(
            key: controller.formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StandardTextField(
                    editingController: controller.editingControllers[0],
                    titleHint: nik,
                    msgError: msgFieldEmpty,
                    maxLength: 8,
                    inputType: TextInputType.number,
                    iconField: Icon(Icons.contact_mail_outlined)
                  ),
                  Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Text(greetingTextReset,
                          style: TextStyle(color: colorText, fontSize: 11))
                  ),
                  StandardButtonPrimary(
                      formKey: controller.formKey,
                      titleHint: submit.toUpperCase(),
                      isLoading: controller.initLoading.value,
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.getReset();
                        }
                      }
                  )
                ]
            )
        )
    );
  }
}
