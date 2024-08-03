import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import '../services/api_service.dart';

class RecoveryChangePage extends StatefulWidget {
  final String email;

  const RecoveryChangePage({Key? key, required this.email}) : super(key: key);

  @override
  _RecoveryChangePageState createState() => _RecoveryChangePageState();
}

class _RecoveryChangePageState extends State<RecoveryChangePage> {
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:5234');
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Contraseña', style: TextStyle(color: Colors.purple)),
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
                Text(
                  'Cambiando contraseña del usuario ${widget.email}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Nueva Contraseña',
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
                        _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureNewPassword,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Contraseña',
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
                        _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200, // Ajuste del tamaño del botón
                  child: ElevatedButton(
                    onPressed: () async {
                      if (newPasswordController.text != confirmPasswordController.text) {
                        Flushbar(
                          message: "Las contraseñas no coinciden",
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.red,
                        ).show(context);
                        return;
                      }
                      try {
                        final response = await apiService.recoveryChange(widget.email, newPasswordController.text);
                        if (response['isSuccess'] == true) {
                          Flushbar(
                            message: "Contraseña cambiada con éxito",
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.green,
                          ).show(context);
                          await Future.delayed(Duration(seconds: 3)); // Espera 3 segundos antes de redirigir
                          Navigator.pushReplacementNamed(context, '/login');
                        } else {
                          Flushbar(
                            message: response['message'],
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.red,
                          ).show(context);
                        }
                      } catch (e) {
                        Flushbar(
                          message: e.toString(),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.red,
                        ).show(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: const Text('Cambiar Contraseña'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
