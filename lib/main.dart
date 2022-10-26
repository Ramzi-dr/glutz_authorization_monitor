import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/configuration_screen.dart';
import 'package:glutz_authorization_monitor/hold_screen.dart';
import 'package:provider/provider.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSherdDb().init();
  AppSherdDb().cloudReadReader();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppSherdDb(),
        )
        // ignore: prefer_const_constructors
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: ('/'),
          routes: {
            '/':(context) => HoldScreen(),
            '/configurationScreen': (context) => ConfigurationScreen(),
            '/homeScreen': (context) => HomeScreen(),
          }),
    );
  }
}
