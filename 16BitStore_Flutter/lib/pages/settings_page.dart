import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Models/user_model.dart';
import 'user_profile_page.dart'; // Importa la nueva página

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/search');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Suponiendo que tienes el usuario almacenado o lo obtienes de algún servicio
    User user = User(
      name: 'Juan Perez',
      email: 'juan.perez@example.com',
      phone: '555-555-5555',
      address: '123 Main St, Ciudad, País',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración', style: TextStyle(color: Colors.purple)),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.purple),
            onPressed: () async {
              await storage.delete(key: 'token');
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.purple),
            title: Text('Cuenta', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage(user: user)),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.purple),
            title: Text('Notificaciones', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Acción de configuración para "Notificaciones"
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.purple),
            title: Text('Privacidad', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Acción de configuración para "Privacidad"
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help, color: Colors.purple),
            title: Text('Ayuda', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Acción de configuración para "Ayuda"
            },
          ),
          Divider(),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await storage.delete(key: 'token');
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              ),
              child: const Text('Cerrar Sesión', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver', style: TextStyle(fontSize: 16, color: Colors.purple)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}
