// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';

import '../../utils/environment.dart';

class BaseService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ConfigEnvironments.getEnvironment().url;
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = Duration(seconds: 60);//1 Menit
    httpClient.addResponseModifier((request, response) async {
      print("Status: ${response.status.code}");
      // print(request.headers);
      // print(response.body);
      return response;
    });
    httpClient.addRequestModifier<dynamic>((request) async {
      print(request.url);
      print("Method: ${request.method.toUpperCase()}");
      return request;
    });
    super.onInit();
  }
}