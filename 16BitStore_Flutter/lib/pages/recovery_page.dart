import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'recovery_change_page.dart'; // Importar la nueva pantalla de cambio de contraseña

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({Key? key}) : super(key: key);

  @override
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:5234');
  final TextEditingController emailController = TextEditingController();

  String responseMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Contraseña', style: TextStyle(color: Colors.purple)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth > 600 ? 400 : double.infinity, // Ajuste del ancho del cuadro de texto
                    child: TextField(
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200, // Ajuste del tamaño del botón
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final response = await apiService.recoveryCheck(emailController.text);
                          setState(() {
                            responseMessage = response['message'];
                          });
                          print('Response: $response');
                          print('IsSuccess: ${response['isSuccess']}');
                          print('Message: ${response['message']}');
                          if (response['isSuccess'] == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecoveryChangePage(email: emailController.text),
                              ),
                            );
                          }
                        } catch (e) {
                          setState(() {
                            responseMessage = e.toString();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: const Text('Recuperar Contraseña'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    responseMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
