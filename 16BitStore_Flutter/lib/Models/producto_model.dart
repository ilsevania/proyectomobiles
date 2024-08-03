// lib/models/producto.dart
class Producto {
  final int id;
  final String clasificacion;
  final String codigoDelProducto;
  final String nombreDelProducto;
  final double precio;
  final int cantidadEnStock;

  Producto({
    required this.id,
    required this.clasificacion,
    required this.codigoDelProducto,
    required this.nombreDelProducto,
    required this.precio,
    required this.cantidadEnStock,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      clasificacion: json['clasificacion'],
      codigoDelProducto: json['codigoDelProducto'],
      nombreDelProducto: json['nombreDelProducto'],
      precio: json['precio'].toDouble(),
      cantidadEnStock: json['cantidadEnStock'],
    );
  }
}
