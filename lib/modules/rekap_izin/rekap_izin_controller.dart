// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../core/data_state.dart';
import '../../core/failure_response.dart';
import '../../data/repository/rekap_izin_repository.dart';

class RekapIzinController extends GetxController {
  final RekapIzinRepository repository;
  RekapIzinController({
    required this.repository,
  });

  final formKey = GlobalKey<FormState>();
  final editingControllers = List.generate(2, (index) => TextEditingController());
  final scrollControllers = ScrollController();
  var initVisibleAdd = true.obs;
  var initLoadingInput = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollControllers.addListener(() {
      if (scrollControllers.position.userScrollDirection == ScrollDirection.reverse) {
        if (initVisibleAdd.value) {
          initVisibleAdd.value = false;
        }
      } else if (scrollControllers.position.userScrollDirection == ScrollDirection.forward) {
        if (!initVisibleAdd.value) {
          initVisibleAdd.value = true;
        }
      }
    });
  }

  final stateRekapIzin = Rx<ResponseState>(ResponseDefault());
  void getRekapIzin() async {
    try {
      stateRekapIzin(ResponseLoading());

      final response = await repository.getRekapIzin();
      stateRekapIzin(ResponseSuccess(response));
    }on FailureResponse catch(e) {
      stateRekapIzin(ResponseFailed(e));
    }
  }

  final statePostRekapIzin = Rx<ResponseState>(ResponseDefault());
  void postRekapIzin() async {
    try {
      statePostRekapIzin(ResponseLoading());

      final response = await repository.getRekapIzin();
      statePostRekapIzin(ResponseSuccess(response));
    }on FailureResponse catch(e) {
      statePostRekapIzin(ResponseFailed(e));
    }
  }
}
