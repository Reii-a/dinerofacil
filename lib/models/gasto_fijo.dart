class GastoFijo {
  final int? id;
  final String nombre;
  final double monto;
  final int? categoriaId;
  final int? duracion; // null = indefinido
  final int periodosRestantes;
  final bool activo;
  final int periodoInicioId;

  GastoFijo({
    this.id,
    required this.nombre,
    required this.monto,
    this.categoriaId,
    this.duracion,
    required this.periodosRestantes,
    required this.activo,
    required this.periodoInicioId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'monto': monto,
      'categoria_id': categoriaId,
      'duracion': duracion,
      'periodos_restantes': periodosRestantes,
      'activo': activo ? 1 : 0,
      'periodo_inicio_id': periodoInicioId,
    };
  }

  factory GastoFijo.fromMap(Map<String, dynamic> map) {
    return GastoFijo(
      id: map['id'],
      nombre: map['nombre'],
      monto: map['monto'],
      categoriaId: map['categoria_id'],
      duracion: map['duracion'],
      periodosRestantes: map['periodos_restantes'],
      activo: map['activo'] == 1,
      periodoInicioId: map['periodo_inicio_id'],
    );
  }
}
