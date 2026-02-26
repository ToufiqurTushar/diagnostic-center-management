import 'package:flutter_rapid/flutter_rapid.dart';
import 'config/app_system_config.dart';

Future<void> main() async {
  FlutterRapidApp flutterRapidApp = FlutterRapidApp();
  await flutterRapidApp.bStart(AppSystemConfig());
  runApp(flutterRapidApp);
}
