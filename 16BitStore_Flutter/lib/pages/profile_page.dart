import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:5234');
  Map<String, dynamic>? userProfile;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final response = await apiService.getUserProfile();
      setState(() {
        userProfile = response;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: userProfile != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email: ${userProfile!['email']}'),
            Text('Nombre: ${userProfile!['nombre']}'),
            // Otros datos del perfil...
          ],
        )
            : errorMessage.isNotEmpty
            ? Text(
          'Error: $errorMessage',
          style: TextStyle(color: Colors.red),
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
