import 'package:flutter/material.dart';
import '../models/producto_model.dart';
import '../services/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ApiService apiService;
  late Future<List<Producto>> futureProductos;
  List<Producto> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  String _category = 'All';
  String _sortOrder = 'None';

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: 'http://localhost:5234');
    _fetchAllProducts();
  }

  Future<void> _fetchAllProducts() async {
    futureProductos = apiService.fetchProductos();
  }

  void _performSearch() {
    futureProductos.then((productos) {
      setState(() {
        _searchResults = productos.where((product) {
          bool matchesName = product.nombreDelProducto.toLowerCase().contains(_searchController.text.toLowerCase());
          bool matchesCategory = _category == 'All' || product.clasificacion == _category;
          return matchesName && matchesCategory;
        }).toList();

        switch (_sortOrder) {
          case 'Precio: Menor a Mayor':
            _searchResults.sort((a, b) => a.precio.compareTo(b.precio));
            break;
          case 'Precio: Mayor a Menor':
            _searchResults.sort((a, b) => b.precio.compareTo(a.precio));
            break;
          case 'Nombre: A-Z':
            _searchResults.sort((a, b) => a.nombreDelProducto.compareTo(b.nombreDelProducto));
            break;
          case 'Nombre: Z-A':
            _searchResults.sort((a, b) => b.nombreDelProducto.compareTo(a.nombreDelProducto));
            break;
        }
      });
    });
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

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
              onSubmitted: (value) {
                _performSearch();
              },
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _category,
              onChanged: (String? newValue) {
                setState(() {
                  _category = newValue!;
                });
                _performSearch();
              },
              items: <String>[
                'All',
                'Electrónica',
                'Electrodomésticos',
                'Hogar',
                'Ropa',
                'Juguetes',
                'Deportes',
                'Libros',
                'Jardinería'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _sortOrder,
              onChanged: (String? newValue) {
                setState(() {
                  _sortOrder = newValue!;
                });
                _performSearch();
              },
              items: <String>[
                'None',
                'Precio: Menor a Mayor',
                'Precio: Mayor a Menor',
                'Nombre: A-Z',
                'Nombre: Z-A'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
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
                    return _searchResults.isNotEmpty
                        ? ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final producto = _searchResults[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(_getCategoryImage(producto.clasificacion)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(producto.nombreDelProducto),
                            subtitle: Text('${producto.clasificacion} - \$${producto.precio}'),
                          ),
                        );
                      },
                    )
                        : Center(
                      child: Text(
                        'No se encontraron resultados.',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
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
        currentIndex: 2,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}
