import 'package:flutter_app/config/env/env_config.dart';

class DevConfig implements EnvConfig {
  @override
  String get apiBaseUrl => 'https://dev-api.example.com';

  @override
  String get appName => 'Flutter App DEV';

  @override
  bool get isDevelopment => true;
}

