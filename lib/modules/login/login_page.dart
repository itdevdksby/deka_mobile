// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/data_state.dart';
import '../../data/entities/profile/profile.dart';
import '../../theme/app_colors.dart';
import '../../theme/show_snackbar_message.dart';
import '../../theme/standard_button_primary.dart';
import '../../theme/standard_text_field.dart';
import '../../utils/strings.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.stateLogin.value is ResponseLoading){
          controller.initLoading.value = true;
        }else if (controller.stateLogin.value is ResponseSuccess){
          controller.initLoading.value = false;
          final response = controller.stateLogin.value.data as ProfileEntity;

          WidgetsBinding.instance.addPostFrameCallback((_) =>
              showSnackBarMessage(context, TypeMessage.SUCCESS,
                  response.name.toString(), DurationMessage.LENGTH_SHORT));
        }else if (controller.stateLogin.value is ResponseFailed){
          controller.initLoading.value = false;
          final response = controller.stateLogin.value.error;

          WidgetsBinding.instance.addPostFrameCallback((_) =>
              showSnackBarMessage(context, TypeMessage.ERROR,
                  response!.message.toString(), DurationMessage.LENGTH_SHORT));
        }

        return _buildBody();
      }),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildContent(),
          ]),
    );
  }

  _buildHeader() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: colorPrimary,
        image: DecorationImage(
          image: AssetImage("assets/images/img_background_factory.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              colorPrimary.withOpacity(0.6), BlendMode.multiply),
        ),
      ),
      child: Column(
          children: [
            Image.asset("assets/images/img_logo_apps.png",
            fit: BoxFit.cover, height: 220),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Colors.white,
          ),
          height: 30,
        )
      ]),
    );
  }

  _buildContent() {
    return Form(
        key: controller.formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                  offset: Offset(20, 0),
                  child: Text(greeting,
                      style: TextStyle(
                          color: colorText,
                          fontWeight: FontWeight.w800,
                          fontSize: 22))),
              Transform.translate(
                  offset: Offset(20, -5),
                  child: Text(greetingText,
                      style: TextStyle(color: colorText, fontSize: 12))),
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
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          // Get.toNamed(ResetPassword.nameRoute);
                        },
                        child: Text(reset,
                            style: TextStyle(color: colorText)),
                      ))), //Button Reset
              StandardButtonPrimary(
                  formKey: controller.formKey,
                  titleHint: login.toUpperCase(),
                  isLoading: controller.initLoading.value,
                  onPressed: () {
                    controller.getLogin();
                  }
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.black87)),
                      Text("   Atau   "),
                      Expanded(child: Divider(color: Colors.black87)),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          // Get.toNamed(Register.nameRoute);
                        },
                        child: Text("Daftar Sekarang ?",
                            style: TextStyle(
                                color: colorText,
                                fontWeight: FontWeight.w800)),
                      ))), //Button Register
              Container(
                  alignment: Alignment.center,
                  child: Text("v${controller.initVersionName.value}",
                      style: TextStyle(
                          color: Colors.black38, fontSize: 10))),
            ])
    );
  }
}
