import 'package:flutter/material.dart';

import 'app/my_app.dart';
import 'core/configs/environment_config.dart';
import 'core/database/hive_service.dart';
import 'core/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize environment configuration
  await EnvironmentConfig.initialize();
  
  // Initialize Hive database
  await HiveService.init();

  // Initialize dependency injection
  await di.init();

  runApp(const MyApp());
}
