import 'package:flutter/material.dart';
import 'package:prueba/views/login/login_desing.dart';
import 'package:prueba/views/Registrer/register-desing.dart';
import 'package:prueba/views/Home_page/Home_desing.dart';
import 'package:prueba/views/Load_page/Load_desing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '16 BitStore',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginDesign(),
      routes: {
        '/register': (context) => const RegisterDesign(),
        '/home': (context) => Home(),
        '/loading': (context) => LoadingScreen(),
      },
    );
  }
}
