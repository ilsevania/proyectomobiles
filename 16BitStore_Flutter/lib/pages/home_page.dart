import 'package:flutter/material.dart';
import '../models/producto_model.dart';
import '../services/api_service.dart';
import 'ProductDetail_page.dart'; // Importa la nueva pantalla de detalles

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ApiService apiService;
  late Future<List<Producto>> futureProductos;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: 'http://localhost:5234');
    futureProductos = apiService.fetchProductos();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.pushNamed(context, '/settings');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/search');
    }
  }

  String _getCategoryImage(String category) {
    category = category.toLowerCase();
    category = category.replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u');
    return 'images/$category.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda Online', style: TextStyle(color: Colors.purple)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Producto>>(
                  future: futureProductos,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No hay productos disponibles');
                    } else {
                      final productosByCategory = _groupByCategory(snapshot.data!);
                      return ListView(
                        children: productosByCategory.entries.map((entry) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  entry.key,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: entry.value.length,
                                  itemBuilder: (context, index) {
                                    final producto = entry.value[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetailPage(producto: producto),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        elevation: 4,
                                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          width: 160,
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: AssetImage(_getCategoryImage(producto.clasificacion)),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Flexible(
                                                child: Text(
                                                  producto.nombreDelProducto,
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text('Precio: \$${producto.precio}'),
                                              Text('Stock: ${producto.cantidadEnStock}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
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

  Map<String, List<Producto>> _groupByCategory(List<Producto> productos) {
    final Map<String, List<Producto>> grouped = {};
    for (var producto in productos) {
      if (!grouped.containsKey(producto.clasificacion)) {
        grouped[producto.clasificacion] = [];
      }
      grouped[producto.clasificacion]!.add(producto);
    }
    return grouped;
  }
}
