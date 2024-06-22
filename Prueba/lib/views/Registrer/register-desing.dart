import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterDesign extends StatefulWidget {
  const RegisterDesign({super.key});

  @override
  State<RegisterDesign> createState() => _RegisterDesignState();
}

class _RegisterDesignState extends State<RegisterDesign> {
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _registerUser() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.68:5242/api/register'), // Reemplaza con la IP local de tu máquina
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'NombreUsuario': _usernameController.text,
          'Email': _emailController.text,
          'Contrasena': _passwordController.text,
          'TipoUsuario': 'Normal',  // Puedes cambiar esto según sea necesario
          'Status': 'Activo'        // Puedes cambiar esto según sea necesario
        }),
      );

      if (response.statusCode == 200) {
        // Registro exitoso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario registrado con éxito')),
        );
      } else {
        // Error al registrar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en el registro: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en el registro: $e')),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce un correo electrónico';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, introduce un correo válido (ej. usuario@dominio.com)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce una contraseña';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'La contraseña debe contener al menos una letra mayúscula';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'La contraseña debe contener al menos un número';
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'La contraseña debe contener al menos un símbolo (!@#\$&*~)';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirma tu contraseña';
    }
    if (value != _passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: _validateEmail,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                obscureText: true,
                validator: _validateConfirmPassword,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _registerUser();
                  }
                },
                child: Text('Registrarse'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
