// ignore_for_file: prefer_const_constructors

import 'package:deka_mobile/modules/login/register/register_page.dart';
import 'package:get/get.dart';

import '../modules/login/login_page.dart';
import '../modules/rekap_izin/rekap_izin_page.dart';

abstract class AppRoutes {
  static const LOGIN = '/LOGIN';
  static const REGISTER = '/REGISTER';
  static const REKAP_IZIN = '/REKAP_IZIN';
}

abstract class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.LOGIN,      page: () => LoginPage()),
    GetPage(name: AppRoutes.REGISTER,   page: () => RegisterPage()),
    GetPage(name: AppRoutes.REKAP_IZIN, page: () => RekapIzinPage()),
  ];
}