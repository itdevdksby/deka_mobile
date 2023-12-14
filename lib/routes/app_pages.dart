// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';

import '../modules/login/login_page.dart';
import '../modules/rekap_izin/rekap_izin_page.dart';

abstract class AppRoutes {
  static const LOGIN = '/login';
  static const REKAP_IZIN = '/RekapIzin';
}

abstract class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.LOGIN,      page: () => LoginPage()),
    GetPage(name: AppRoutes.REKAP_IZIN, page: () => RekapIzinPage()),
  ];
}