import 'package:flutter_app/config/env/env_config.dart';

class StagingConfig implements EnvConfig {
  @override
  String get apiBaseUrl => 'https://staging-api.example.com';

  @override
  String get appName => 'Flutter App STAGING';

  @override
  bool get isDevelopment => false;
}

