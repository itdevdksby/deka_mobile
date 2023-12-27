import 'dart:async';

import 'package:floor/floor.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../data/entities/pengaturan_autocode/pengaturan_autocode_android.dart';
import '../../data/entities/pengaturan_autocode/pengaturan_autocode_android_dao.dart';
import '../../data/entities/profile/profile.dart';
import '../../data/entities/profile/profile_dao.dart';

part 'database_config.g.dart';

@Database(version: 3, entities: [
  ProfileEntity,
  PengaturanAutocodeAndroidEntity
])
abstract class DatabaseConfig extends FloorDatabase {
  ProfileDao get profileDao;
  PengaturanAutocodeAndroidDao get pengaturanAutocodeAndroidDao;
}
