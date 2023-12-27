import 'package:deka_mobile/modules/dashboard/dashboard_controller.dart';
import 'package:deka_mobile/modules/login/register/register_controller.dart';
import 'package:deka_mobile/modules/login/reset/reset_controller.dart';
import 'package:get/get.dart';

import '../../config/local/database_config.dart';
import '../../modules/login/login_controller.dart';
import '../../modules/rekap_izin/rekap_izin_controller.dart';
import '../../utils/environment.dart';
import '../provider/login_provider.dart';
import '../provider/rekap_izin_provider.dart';
import '../repository/login_repository.dart';
import '../repository/rekap_izin_repository.dart';

class BindingDependency implements Bindings {
  @override
  Future<void> dependencies() async {
    final env = ConfigEnvironments.getEnvironment();

    //Database
    final database = await $FloorDatabaseConfig.databaseBuilder(env.dbName).build();
    Get.lazyPut<DatabaseConfig>(() => database, fenix: true);

    //Provider
    Get.lazyPut(() => LoginProvider(), fenix: true);
    Get.lazyPut(() => RekapIzinProvider(), fenix: true);

    //Controller
    Get.lazyPut(() => LoginController(repository: Get.find()), fenix: true);
    Get.lazyPut(() => RegisterController(repository: Get.find()), fenix: true);
    Get.lazyPut(() => ResetController(repository: Get.find()), fenix: true);
    Get.lazyPut(() => DashboardController(repository: Get.find()), fenix: true);
    Get.lazyPut(() => RekapIzinController(repository: Get.find()), fenix: true);

    //Repository
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(Get.find(), Get.find()), fenix: true);
    Get.lazyPut<RekapIzinRepository>(() => RekapIzinRepositoryImpl(Get.find(), Get.find()), fenix: true);
  }
}