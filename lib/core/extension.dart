// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';

import 'package:android_id/android_id.dart';
import 'package:deka_mobile/utils/strings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

String generateRandomId() {
  final random = Random();
  const length = 11;
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final id = StringBuffer();

  for (var i = 0; i < length; i++) {
    id.write(chars[random.nextInt(chars.length)]);
  }

  return id.toString();
}

String generateCode(int lastCode) {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final id = StringBuffer();

  for (var i = 0; i < lastCode; i++) {
    id.write(chars[random.nextInt(chars.length)]);
  }

  return id.toString();
}

Future<String> generateDeviceId() async {
  String? value;
  value = await AndroidId().getId();

  if (Platform.isIOS) {
    final deviceInfo = await DeviceInfoPlugin().iosInfo;
    value = deviceInfo.identifierForVendor;
  }

  return value ?? "getDeviceId $msgGenerateError";
}

Future<String> generateDeviceBrand() async {
  String? value;
  final deviceInfo = await DeviceInfoPlugin().deviceInfo;
  value = deviceInfo.data['brand'];

  return value ?? "generateDeviceBrand $msgGenerateError";
}

Future<String> generateDeviceModel() async {
  String? value;
  final deviceInfo = await DeviceInfoPlugin().deviceInfo;
  value = deviceInfo.data['model'];

  return value ?? "generateDeviceModel $msgGenerateError";
}

Future<String> generateVersionName() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Future<void> pickerPhoto(ImageSource source, final void Function(String path) onPicked) async {
  final picked = await ImagePicker().pickImage(source: source, imageQuality: 70);
  if(picked == null) return;

  onPicked(picked.path);
}