class Periodo {
  final int? id;
  final DateTime fechaInicio;
  final DateTime fechaTermino;
  final double saldoInicial;
  final double saldoDisponible;

  Periodo({
    this.id,
    required this.fechaInicio,
    required this.fechaTermino,
    required this.saldoInicial,
    required this.saldoDisponible,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha_inicio': fechaInicio.toIso8601String(),
      'fecha_termino': fechaTermino.toIso8601String(),
      'saldo_inicial': saldoInicial,
      'saldo_disponible': saldoDisponible,
    };
  }

  factory Periodo.fromMap(Map<String, dynamic> map) {
    return Periodo(
      id: map['id'],
      fechaInicio: DateTime.parse(map['fecha_inicio']),
      fechaTermino: DateTime.parse(map['fecha_termino']),
      saldoInicial: map['saldo_inicial'],
      saldoDisponible: map['saldo_disponible'],
    );
  }
}
