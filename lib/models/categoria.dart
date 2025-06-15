class Categoria {
  final int? id;
  final String nombre;
  final bool esIngreso;

  Categoria({
    this.id,
    required this.nombre,
    required this.esIngreso,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'es_ingreso': esIngreso ? 1 : 0,
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'],
      nombre: map['nombre'],
      esIngreso: map['es_ingreso'] == 1,
    );
  }
}
