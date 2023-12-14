// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/data_state.dart';
import '../../core/failure_response.dart';
import '../../models/response/rekap_izin_model.dart';
import '../../theme/app_colors.dart';
import '../../utils/strings.dart';
import 'item/rekap_izin_tile.dart';
import 'rekap_izin_controller.dart';

class RekapIzinPage extends GetView<RekapIzinController> {
  const RekapIzinPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getRekapIzin();

    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.rekapIzin.value is ResponseLoading){
          return Center(child: CircularProgressIndicator());
        }else if (controller.rekapIzin.value is ResponseSuccess){
          final response = controller.rekapIzin.value.data as List<RekapIzinModel>;
          return _buildBody(response);
        }else if (controller.rekapIzin.value is ResponseFailed){
          final error = controller.rekapIzin.value.error;
          return _buildError(error!);
        }else {
          return SizedBox();
        }
      }),
      floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: colorPrimary,
          onPressed: () async {
            print("Button Add");
          },
          child: Icon(Icons.add, color: Colors.white)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _buildAppBar() {
    return AppBar(title: Text(rekapIzin));
  }

  _buildBody(List<RekapIzinModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return RekapIzinTile(
          rekapIzin: data[index],
          onPressed: (model) async {
            print("Test Click");
          },
        );
      }
    );
  }

  _buildError(FailureResponse failure) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image(
            //     height: 200,
            //     fit: BoxFit.cover,
            //     image: AssetImage("assets/images/gif_no_data.gif")),
            TextButton(
                child: Text(
                  failure.message ?? "Tidak Ada Data",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () {
                  controller.getRekapIzin();
                })
          ],
        ));
  }
}