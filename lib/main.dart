import 'package:flutter/material.dart';
import 'package:prueba/views/login/login_desing.dart';
import 'package:prueba/views/Registrer/register-desing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ilse Vania Rodriguez Sanchez',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginDesign(),
      routes: {
        '/register': (context) => const RegisterDesign(),
      },
    );
  }
}
