// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:deka_mobile/modules/login/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants.dart';
import '../../../core/data_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/show_snackbar_message.dart';
import '../../../theme/single_select/single_select_dialog.dart';
import '../../../theme/standard_button_primary.dart';
import '../../../theme/standard_picker_field.dart';
import '../../../theme/standard_text_field.dart';
import '../../../utils/strings.dart';

class RegisterPage extends GetView<RegisterController> {
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.stateCheckNik.value is ResponseLoading){
          FocusScope.of(context).unfocus();
          controller.initLoadingCheck.value = true;
          controller.initVisible.value = false;
        }else if (controller.stateCheckNik.value is ResponseFailed){
          controller.initLoadingCheck.value = false;
        }else if (controller.stateCheckNik.value is ResponseSuccess){
          controller.initLoadingCheck.value = false;
          controller.initVisible.value = true;
        }

        if (controller.stateRegister.value is ResponseLoading){
          FocusScope.of(context).unfocus();
          controller.initLoading.value = true;
        }else if (controller.stateRegister.value is ResponseFailed){
          controller.initLoading.value = false;
        }else if (controller.stateRegister.value is ResponseSuccess){
          controller.initLoading.value = false;
        }

        return _buildBody();
      }),
    );
  }

  _buildAppBar() {
    return AppBar(title: Text(register));
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
                  Row(children: [
                    Expanded(child: StandardTextField(
                      editingController: controller.editingControllers[0],
                      titleHint: nik,
                      msgError: msgNikNotValid,
                      maxLength: 8,
                      iconField: Icon(Icons.contact_mail_outlined),
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done)),
                    Padding(padding: EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.editingControllers[0].text.isNull ||
                              (controller.editingControllers[0].text.length ?? 0) < 8) {
                            WidgetsBinding.instance.addPostFrameCallback((_) =>
                              showSnackBarMessage(
                                context,
                                TypeMessage.ERROR,
                                msgNikNotValid,
                                DurationMessage.LENGTH_SHORT)
                            );
                          } else {
                            controller.getCheckNik();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10),
                          backgroundColor: controller.initLoadingCheck.value
                              ? Colors.grey
                              : colorPrimary),
                        child: controller.initLoadingCheck.value
                          ? SizedBox(width: 24, height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2
                              )
                          )
                          : Icon(Icons.search, color: Colors.white),
                    )
                    ),
                  ]),
                  Visibility(visible: controller.initVisible.value, child: Column(children: [
                    StandardPickerField(
                        titleHint: fotoProfil,
                        pathValue: controller.stateDomain.value.foto_temp,
                        onPressed: (path) {
                          controller.stateDomain.value.foto_temp = path;
                        },
                        onRemove: () {
                          controller.stateDomain.value.foto_temp = null;
                        }),
                    StandardTextField(
                        editingController: controller.editingControllers[1],
                        titleHint: ktp,
                        msgError: msgFieldEmpty,
                        readOnly: true,
                        iconField: Icon(Icons.contact_mail_outlined)),
                    StandardTextField(
                        editingController: controller.editingControllers[2],
                        titleHint: nama,
                        msgError: msgFieldEmpty,
                        readOnly: true,
                        iconField: Icon(Icons.person_outline)),
                    StandardTextField(
                        editingController: controller.editingControllers[3],
                        titleHint: email,
                        msgError: msgFieldEmpty,
                        readOnly: true,
                        iconField: Icon(Icons.mail_outline)),
                    StandardTextField(
                        editingController: controller.editingControllers[4],
                        titleHint: phone,
                        msgError: msgFieldEmpty,
                        readOnly: true,
                        iconField: Icon(Icons.phone_android_outlined)),
                    StandardTextField(
                        editingController: controller.editingControllers[5],
                        titleHint: alamat,
                        msgError: msgFieldEmpty,
                        readOnly: true,
                        iconField: Icon(Icons.home_outlined)),
                    StandardTextField(
                        editingController: controller.editingControllers[6],
                        titleHint: ttl,
                        msgError: msgFieldEmpty,
                        readOnly: true,
                        iconField: Icon(Icons.cake_outlined)),
                    StandardTextField(
                        editingController: controller.editingControllers[7],
                        titleHint: divisi,
                        msgError: msgFieldEmpty,
                        readOnly: true,
                        iconField: Icon(Icons.domain_outlined)),
                    StandardTextField(
                        editingController: controller.editingControllers[8],
                        titleHint: costCenter,
                        msgError: msgFieldEmpty,
                        readOnly: true,
                        iconField: Icon(Icons.work_outline)),
                    StandardTextField(
                        editingController: controller.editingControllers[9],
                        titleHint: organisasi,
                        msgError: msgFieldEmpty,
                        readOnly: true,
                        iconField: Icon(Icons.description_outlined)),
                    StandardTextField(
                        editingController: controller.editingControllers[10],
                        titleHint: lokasiKerja,
                        msgError: msgFieldEmpty,
                        readOnly: true,
                        iconField: Icon(Icons.pin_drop_outlined),
                        onPressed: () {
                          dialogSingleSelect(context, listLokasi, (idIndex, model) {
                                controller.stateDomain.value.lokasi = model.codeOrId!;
                                controller.stateDomain.value.lokasi_desc = model.message!;
                                controller.editingControllers[10].text = model.message!;
                              });
                        },
                    ),
                    StandardButtonPrimary(
                        formKey: controller.formKey,
                        titleHint: submit.toUpperCase(),
                        isLoading: controller.initLoading.value,
                        onPressed: () {
                          if(controller.stateDomain.value.foto_temp.isNull){
                            showSnackBarMessage(Get.context!, TypeMessage.ERROR,
                                "Foto masih kosong", DurationMessage.LENGTH_SHORT);
                            return;
                          }

                          controller.postRegister();
                        }
                    )
                  ]))
                ]
            )
        )
    );
  }
}
