// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deka_mobile/data/entities/profile/profile.dart';
import 'package:deka_mobile/models/response/view_cuti_model.dart';
import 'package:deka_mobile/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/data_state.dart';
import '../../theme/app_colors.dart';
import '../../utils/strings.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  DashboardPage({super.key});
  var pathFoto = "https://webfuzo.duakelinci.id:9393/img/duakelinci-transparant.png";
  var responseViewCuti = ViewCutiModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.stateProfile.value is ResponseSuccess){
          final response = controller.stateProfile.value.data as ProfileEntity;
          pathFoto = response.photo
              ?? "https://webfuzo.duakelinci.id:9393/img/duakelinci-transparant.png";
        }

        if (controller.stateViewCuti.value is ResponseLoading){
          FocusScope.of(context).unfocus();
          controller.initVisibleData.value = false;
        }else if (controller.stateViewCuti.value is ResponseFailed){
          controller.initVisibleData.value = false;
        }else if (controller.stateViewCuti.value is ResponseSuccess){
          controller.initVisibleData.value = true;
          responseViewCuti = controller.stateViewCuti.value.data as ViewCutiModel;
        }

        return _buildBody();
      })
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreeting(),
          _buildErrorData(),
          _buildCountIzin(),
          _buildRekapIzin(),
        ],
      ),
    );
  }

  _buildGreeting() {
    final hour = int.tryParse(DateFormat('HH').format(DateTime.now()));
    var textGreeting = "Selamat Malam";
    if (hour! >= 4 && hour <= 10) textGreeting = "Selamat Pagi";
    if (hour >= 11 && hour <= 14) textGreeting = "Selamat Siang";
    if (hour >= 15 && hour <= 17) textGreeting = "Selamat Sore";

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage("assets/images/img_background_factory.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              colorPrimary.withOpacity(0.6), BlendMode.multiply),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 35, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10),
                    child: CachedNetworkImage(
                      imageUrl: pathFoto,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_rounded),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      ),
                    )),
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.zero,
                  child: IconButton(
                      icon:
                      const Icon(Icons.menu_rounded, color: Colors.amber),
                      onPressed: () {}),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: Text(textGreeting,
                  style: TextStyle(
                      color: colorOnPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(greetingTextDashboard,
                  style: TextStyle(
                      color: colorOnPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }

  _buildErrorData() {
    return Visibility(
      visible: !controller.initVisibleData.value,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 200,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/gif_no_data.gif")),
            TextButton(
              child: Text(
                msgNotFound,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
              ),
              onPressed: () {
                controller.getViewIzin();
              })
          ],
        )
      )
    );
  }

  _buildCountIzin() {
    return Visibility(
        visible: controller.initVisibleData.value,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: colorRed100,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(responseViewCuti.jumlahAlpha ?? "-",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20)),
                            Text(textTotalAlpha,
                                style:
                                TextStyle(color: Colors.red, fontSize: 12)),
                          ],
                        ),
                      )),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: colorGreen100,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(
                                "${responseViewCuti.jumlahSisaCuti ?? "-"} / ${responseViewCuti.jumlahCuti ?? "-"}",
                                style: TextStyle(
                                    color: colorText,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20)),
                            Text(textSisaCuti,
                                style:
                                TextStyle(color: colorText, fontSize: 12)),
                          ],
                        ),
                      )),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: colorBlue100,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(responseViewCuti.totalIzin ?? "-",
                                style: TextStyle(
                                    color: colorText,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20)),
                            Text(textTotalIzin,
                                style:
                                TextStyle(color: colorText, fontSize: 12)),
                          ],
                        ),
                      )),
                ))
          ],
        ));
  }

  _buildRekapIzin() {
    return Visibility(
        visible: controller.initVisibleData.value,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 2,
              color: colorOnPrimary,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(rekapIzin,
                                    style: TextStyle(
                                        color: colorPrimary,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16))),
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 25,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.REKAP_IZIN);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            colorPrimaryDark),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20)))),
                                    child: Text(detail,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                        )),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding:
                              EdgeInsets.only(left: 15, top: 15, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(textIzinBelumDisetujui,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontSize: 15))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(responseViewCuti.totalWaiting ?? "-",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(textIzinDisetujui,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontSize: 15))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(responseViewCuti.totalApproved ?? "-",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(textIzinDitolak,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontSize: 15))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(responseViewCuti.totalReject ?? "-",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ]),
            )
        )
    );
  }
}