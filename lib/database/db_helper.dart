import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/periodo.dart';
import '../models/transaccion.dart';
import '../models/categoria.dart';
import '../models/gasto_fijo.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dinerofacil.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _crearTablas,
    );
  }

  static Future<void> _crearTablas(Database db, int version) async {
    await db.execute('''
      CREATE TABLE periodos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fecha_inicio TEXT,
        fecha_termino TEXT,
        saldo_inicial REAL,
        saldo_disponible REAL
      );
    ''');

    await db.execute('''
      CREATE TABLE categorias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        es_ingreso INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE transacciones (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        monto REAL,
        descripcion TEXT,
        fecha TEXT,
        es_ingreso INTEGER,
        periodo_id INTEGER,
        categoria_id INTEGER,
        FOREIGN KEY (periodo_id) REFERENCES periodos(id),
        FOREIGN KEY (categoria_id) REFERENCES categorias(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE gastos_fijos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        monto REAL,
        categoria_id INTEGER,
        duracion INTEGER,
        periodos_restantes INTEGER,
        activo INTEGER,
        periodo_inicio_id INTEGER,
        FOREIGN KEY (categoria_id) REFERENCES categorias(id),
        FOREIGN KEY (periodo_inicio_id) REFERENCES periodos(id)
      );
    ''');
  }

  /// Puedes agregar aquí métodos como insertarPeriodo, obtenerTransacciones, etc.
}
