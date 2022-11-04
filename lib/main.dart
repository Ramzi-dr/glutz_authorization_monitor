import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/configuration_screen.dart';
import 'package:glutz_authorization_monitor/glutzServer/rpc_server.dart';
import 'package:glutz_authorization_monitor/hold_screen.dart';
import 'package:glutz_authorization_monitor/email_screen.dart';
import 'package:provider/provider.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'call_screen.dart';
import 'home_screen.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSherdDb().init();
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
        ),
        ChangeNotifierProvider(
          create: (_) => RpcServer(),
        ),
        // ignore: prefer_const_constructors
      ],
      child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: ('/'),
          routes: {
            '/': (context) => const HoldScreen(),
            '/configurationScreen': (context) => ConfigurationScreen(),
            '/homeScreen': (context) => HomeScreen(),
            '/emailScreen': (context) => EmailScreen(),
            '/callScreen': (context) => CallScreen(),
          }),
    );
  }
}
