// ignore_for_file: prefer_const_constructors

import 'package:deka_mobile/modules/dashboard/dashboard_page.dart';
import 'package:deka_mobile/modules/login/register/register_page.dart';
import 'package:deka_mobile/modules/login/reset/reset_page.dart';
import 'package:get/get.dart';

import '../modules/login/login_page.dart';
import '../modules/rekap_izin/input/input_rekap_izin_page.dart';
import '../modules/rekap_izin/rekap_izin_page.dart';

abstract class AppRoutes {
  static const LOGIN = '/LOGIN';
  static const REGISTER = '/REGISTER';
  static const RESET = '/RESET';
  static const DASHBOARD = '/DASHBOARD';
  static const REKAP_IZIN = '/REKAP_IZIN';
  static const INPUT_REKAP_IZIN = '/INPUT_REKAP_IZIN';
}

abstract class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.LOGIN,      page: () => LoginPage()),
    GetPage(name: AppRoutes.REGISTER,   page: () => RegisterPage()),
    GetPage(name: AppRoutes.RESET,      page: () => ResetPage()),
    GetPage(name: AppRoutes.DASHBOARD,  page: () => DashboardPage()),
    GetPage(name: AppRoutes.REKAP_IZIN, page: () => RekapIzinPage()),
    GetPage(name: AppRoutes.INPUT_REKAP_IZIN, page: () => InputRekapIzinPage()),
  ];
}