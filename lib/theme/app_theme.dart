// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      fontFamily: 'nunitosans',
      appBarTheme: appBarTheme()
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      backgroundColor: colorPrimary,
      elevation: 2,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      centerTitle: true
  );
}
