import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba/views/Load_page/Load_desing.dart';


class LoginDesign extends StatefulWidget {
  const LoginDesign({super.key});

  @override
  State<LoginDesign> createState() => _LoginDesignState();
}

class _LoginDesignState extends State<LoginDesign> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _loginUser() async {
    // Mostrar la pantalla de carga
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoadingScreen(),
    ));

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.68:5242/api/register/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Email': _emailController.text,
          'Contrasena': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Inicio de sesión exitoso
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Error en el inicio de sesión
        Navigator.of(context).pop(); // Cierra la pantalla de carga
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario o contraseña incorrectos')),
        );
      }
    } catch (e) {
      Navigator.of(context).pop(); // Cierra la pantalla de carga
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en el inicio de sesión: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagen circular para el perfil
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/profile.png'), // Asegúrate de tener esta imagen en tu carpeta de assets
              backgroundColor: Colors.grey[200],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Acción para recuperar la contraseña
                },
                child: Text(
                  'Recuperar contraseña',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            // Empuja el botón de registro hacia la parte inferior de la pantalla
            ElevatedButton(
              onPressed: _loginUser,
              child: Text('Iniciar Sesion'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16.0),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register'); // Navega a la pantalla de registro
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
