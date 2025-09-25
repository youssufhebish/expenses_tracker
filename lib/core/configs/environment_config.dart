import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration service for managing API keys and environment variables
class EnvironmentConfig {
  /// Initialize the environment configuration by loading the .env file
  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
  }

  /// Get API key from environment variables
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  /// Get base URL from environment variables
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'https://api.example.com';

  static String get url => baseUrl + apiKey;

  /// Get environment variable by key with optional default value
  static String getEnv(String key, {String defaultValue = ''}) {
    return dotenv.env[key] ?? defaultValue;
  }

  /// Check if environment variable exists
  static bool hasEnv(String key) {
    return dotenv.env.containsKey(key);
  }
}