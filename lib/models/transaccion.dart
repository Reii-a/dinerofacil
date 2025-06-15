class Transaccion {
  final int? id;
  final double monto;
  final String descripcion;
  final DateTime fecha;
  final bool esIngreso;
  final int periodoId;
  final int? categoriaId;

  Transaccion({
    this.id,
    required this.monto,
    required this.descripcion,
    required this.fecha,
    required this.esIngreso,
    required this.periodoId,
    this.categoriaId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'monto': monto,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'es_ingreso': esIngreso ? 1 : 0,
      'periodo_id': periodoId,
      'categoria_id': categoriaId,
    };
  }

  factory Transaccion.fromMap(Map<String, dynamic> map) {
    return Transaccion(
      id: map['id'],
      monto: map['monto'],
      descripcion: map['descripcion'],
      fecha: DateTime.parse(map['fecha']),
      esIngreso: map['es_ingreso'] == 1,
      periodoId: map['periodo_id'],
      categoriaId: map['categoria_id'],
    );
  }
}
