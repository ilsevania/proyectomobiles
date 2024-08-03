import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:another_flushbar/flushbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:5234');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController tipoDeUsuarioController = TextEditingController();
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  String emailError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  String responseMessage = '';

  bool validateEmail(String email) {
    String pattern =
        r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool validatePassword(String password) {
    String pattern =
        r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  void register() async {
    setState(() {
      emailError = '';
      passwordError = '';
      confirmPasswordError = '';
    });

    bool isValid = true;

    if (!validateEmail(emailController.text)) {
      setState(() {
        emailError = 'Formato de correo inválido';
      });
      isValid = false;
    }

    if (!validatePassword(passwordController.text)) {
      setState(() {
        passwordError =
        'La contraseña debe tener al menos 8 caracteres, una mayúscula y un número';
      });
      isValid = false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        confirmPasswordError = 'Las contraseñas no coinciden';
      });
      isValid = false;
    }

    if (!isValid) return;

    try {
      final response = await apiService.register(
        emailController.text,
        passwordController.text,
        nombreController.text,
        tipoDeUsuarioController.text,
      );
      setState(() {
        responseMessage = response['message'];
      });
      if (response['isSuccess']) {
        Flushbar(
          message: "Registro exitoso",
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ).show(context);
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        setState(() {
          responseMessage = response['message'];
        });
      }
    } catch (e) {
      setState(() {
        responseMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register', style: TextStyle(color: Colors.purple)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.purple.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    errorText: emailError.isEmpty ? null : emailError,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.purple.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    errorText: passwordError.isEmpty ? null : passwordError,
                  ),
                  obscureText: _obscureText,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Password',
                    filled: true,
                    fillColor: Colors.purple.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmText = !_obscureConfirmText;
                        });
                      },
                    ),
                    errorText: confirmPasswordError.isEmpty ? null : confirmPasswordError,
                  ),
                  obscureText: _obscureConfirmText,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    filled: true,
                    fillColor: Colors.purple.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: tipoDeUsuarioController,
                  decoration: InputDecoration(
                    labelText: 'Tipo de Usuario',
                    filled: true,
                    fillColor: Colors.purple.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  responseMessage,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Volver al login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
