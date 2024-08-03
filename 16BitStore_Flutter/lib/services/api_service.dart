import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universal_html/html.dart' as html;
import '../models/producto_model.dart';

class ApiService {
  final String baseUrl;
  final FlutterSecureStorage? secureStorage = kIsWeb ? null : FlutterSecureStorage();

  ApiService({required this.baseUrl});

  Future<void> writeSecureData(String key, String value) async {
    if (kIsWeb) {
      html.window.localStorage[key] = value;
    } else {
      await secureStorage?.write(key: key, value: value);
    }
  }

  Future<String?> readSecureData(String key) async {
    if (kIsWeb) {
      return html.window.localStorage[key];
    } else {
      return await secureStorage?.read(key: key);
    }
  }

  Future<void> deleteSecureData(String key) async {
    if (kIsWeb) {
      html.window.localStorage.remove(key);
    } else {
      await secureStorage?.delete(key: key);
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Access'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'method': 'login',
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print('Response: $jsonResponse');
      if (jsonResponse['isSuccess']) {
        await writeSecureData('token', jsonResponse['token']);
        print('Token stored: ${jsonResponse['token']}'); // Debug print
      }
      return jsonResponse;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password, String nombre, String tipoDeUsuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Access'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'method': 'register',
        'email': email,
        'password': password,
        'nombre': nombre,
        'tipodeusuario': tipoDeUsuario,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<Map<String, dynamic>> recoveryCheck(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Access'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'method': 'recovery_check',
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to recovery check');
    }
  }

  Future<Map<String, dynamic>> recoveryChange(String email, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Access'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'method': 'recovery_change',
        'email': email,
        'newpassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to recovery change');
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    String? token = await readSecureData('token');
    final response = await http.get(
      Uri.parse('$baseUrl/api/UserProfile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user profile');
    }
  }

  // Nueva función para obtener productos
  Future<List<Producto>> fetchProductos() async {
    final response = await http.get(Uri.parse('$baseUrl/api/Productos'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Producto.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
