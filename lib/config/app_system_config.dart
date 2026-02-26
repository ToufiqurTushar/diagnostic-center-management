import 'package:flutter_rapid/flutter_rapid.dart';
import '../page/home/home_view.dart';
import '../routes.dart';
import 'app_config.dart';

@pragma('vm:entry-point')
Future<void> _backgroundMessage(RemoteMessage message) async {
  RapidRemoteMessage rapidMessage = await RapidFirebaseNotification.getBackgroundData(message);
  RapidPushNotifyManager.inst.notify(
    99,
    title: "Background Message",
    body: "Showing from Background Message Notify callback",
  );
}

class AppSystemConfig extends RapidSystemConfig {
  String appTitle = "Flutter App";
  ThemeData theme = ThemeData(primarySwatch: Colors.blue);
  ThemeData darkTheme = ThemeData.dark();
  Map<String, Locale> availableLocal = {
    "bn_BD": const Locale('bn', 'BD'),
    "en_US": const Locale('en', 'US'),
    "ur_PK": const Locale('ur', 'PK')
  };
  String? initialRoute = HomeView.routeName;

  List<RapidModuleRegistry> modules = [
    AppRegistry(),
  ];

  RapidSplashScreenData splashScreenData = RapidSplashScreenData()
  .setAppName('Flutter App')
  .setDelay(3);

  String currentEnv = "dev";
  Map<String, RapidEnvConfig> availableEnvironment = {
    "dev": DevConfig(),
    "stage": StageConfig(),
    "prod": ProdConfig(),
  };

  initConfig(var env) {
    return Get.put<AppBaseConfig>(env);
  }

  Future<void> onAppStartup() async {

  }
}
