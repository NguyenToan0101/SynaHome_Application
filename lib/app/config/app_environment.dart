enum AppEnvironment {
  development,
  staging,
  production;

  String get flavorName => name;

  String get displayName => switch (this) {
        AppEnvironment.development => 'Syna Dev',
        AppEnvironment.staging => 'Syna Staging',
        AppEnvironment.production => 'Syna',
      };

  String get baseUrl => switch (this) {
        AppEnvironment.development => const String.fromEnvironment(
            'API_BASE_URL',
            defaultValue: 'http://10.0.2.2:8080',
          ),
        AppEnvironment.staging => const String.fromEnvironment(
            'API_BASE_URL',
            defaultValue: 'https://staging-api.example.com',
          ),
        AppEnvironment.production => const String.fromEnvironment(
            'API_BASE_URL',
            defaultValue: 'https://api.example.com',
          ),
      };

  bool get isProduction => this == AppEnvironment.production;
  bool get enableVerboseLogs => this == AppEnvironment.development;
}
