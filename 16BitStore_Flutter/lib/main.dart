import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:bitstore_flutter/pages/login_page.dart';
import 'package:bitstore_flutter/pages/register_page.dart';
import 'package:bitstore_flutter/pages/recovery_change_page.dart';
import 'package:bitstore_flutter/pages/home_page.dart';
import 'package:bitstore_flutter/pages/settings_page.dart';
import 'pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitStore Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/recovery-change': (context) => RecoveryChangePage(email: ModalRoute.of(context)?.settings.arguments as String),
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}
