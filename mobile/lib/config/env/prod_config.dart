import 'package:flutter_app/config/env/env_config.dart';

class ProdConfig implements EnvConfig {
  @override
  String get apiBaseUrl => 'https://api.example.com';

  @override
  String get appName => 'Flutter App';

  @override
  bool get isDevelopment => false;
}

