class Environments {
  static const String LOCAL = 'LOCAL';
  static const String DEBUG = 'DEBUG';
  static const String PROD = 'PRODUCTION';
}

class EnvData {
  String env;
  String url;
  String dbName;
  String? key;

  EnvData({required this.env, required this.url, required this.dbName, this.key});
}

class ConfigEnvironments {
  //Change environment in this bottom line
  static const String _currentEnvironments = Environments.DEBUG;

  static final List<EnvData> _availableEnvironments = [
    EnvData(
        env: Environments.LOCAL,
        url: 'http://localhost/api/',
        dbName: 'getx_local.db'),
    EnvData(
        env: Environments.DEBUG,
        url: 'https://appdk-trial.duakelinci.id:9393/api/webusagi/v2/hc/',
        dbName: 'getx_debug.db'),
    EnvData(
        env: Environments.PROD,
        url: 'https://dkapi.duakelinci.id:9393/api/webusagi/v2/hc/',
        dbName: 'getx_prod.db'),
  ];

  static EnvData getEnvironment() {
    return _availableEnvironments.firstWhere(
            (element) => element.env == _currentEnvironments
    );
  }
}