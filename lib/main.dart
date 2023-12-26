// ignore_for_file: prefer_const_constructors

import 'package:deka_mobile/routes/app_pages.dart';
import 'package:deka_mobile/theme/app_theme.dart';
import 'package:deka_mobile/translations/app_translations.dart';
import 'package:deka_mobile/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/binding/binding_dependency.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BindingDependency().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme(),
      title: appName.tr,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.pages,
      translationsKeys: AppTranslation.translations,
      locale: Get.deviceLocale,
      fallbackLocale: Locale('id', 'ID')
    );
  }
}
