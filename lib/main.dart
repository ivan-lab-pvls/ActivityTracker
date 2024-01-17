import 'package:activity_tracker/data/activity_controller.dart';
import 'package:activity_tracker/data/essential/configuration.dart';
import 'package:activity_tracker/data/essential/notifx.dart';
import 'package:activity_tracker/my_theme.dart';
import 'package:activity_tracker/screen/init/init_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: AppFirebaseOptions.currentPlatform);

  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 11),
    minimumFetchInterval: const Duration(seconds: 11),
  ));

  await FirebaseRemoteConfig.instance.fetchAndActivate();

  await NotificationsFb().activate();

  final SharedPreferences bd = await SharedPreferences.getInstance();
  runApp(MyApp(bd));
}

class MyApp extends StatelessWidget {
  const MyApp(
    this._bd, {
    super.key,
  });
  final SharedPreferences _bd;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActivityController(_bd),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: MyTheme.myTheme,
        home: const InitScreen(),
      ),
    );
  }
}
