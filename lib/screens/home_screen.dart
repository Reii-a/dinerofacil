import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double ingresosTotales = 0.0;
  double gastosTotales = 0.0;
  double saldoDisponible = 0.0;
  List<Map<String, dynamic>> transacciones = [];

  @override
  void initState() {
    super.initState();
    _cargarResumen();
  }

  Future<void> _cargarResumen() async {
    final db = await DBHelper.db;
    final periodos = await db.query(
      'periodos',
      orderBy: 'fecha_inicio DESC',
      limit: 1,
    );

    if (periodos.isEmpty) return;

    final periodo = periodos.first;
    final periodoId = periodo['id'];
    final saldo = (periodo['saldo_disponible'] as num).toDouble();

    final transacs = await db.query(
      'transacciones',
      where: 'periodo_id = ?',
      whereArgs: [periodoId],
      orderBy: 'fecha DESC',
      limit: 10,
    );

    double ingresos = 0.0;
    double gastos = 0.0;

    for (var t in transacs) {
      final esIngreso = t['es_ingreso'] == 1;
      final monto = (t['monto'] as num).toDouble();
      if (esIngreso) {
        ingresos += monto;
      } else {
        gastos += monto;
      }
    }

    setState(() {
      ingresosTotales = ingresos;
      gastosTotales = gastos;
      saldoDisponible = saldo;
      transacciones = transacs;
    });
  }

  String formatearFecha(String fechaIso) {
    final fecha = DateTime.parse(fechaIso);
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        toolbarHeight: 80,
        title: Image.asset(
          'lib/assets/images/logo.png',
          height: 100,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: const Text('Menú',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Gastos Fijos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/gastos-fijos');
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_upward),
              title: const Text('Ingresos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/ingresos');
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_downward),
              title: const Text('Gastos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/gastos');
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categorías'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/categorias');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historial'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/historial');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Saldo Disponible', style: TextStyle(fontSize: 20)),
            Text(
              '\$${saldoDisponible.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            Text('Gastos Totales',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade800)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Ingresos',
                        style: TextStyle(fontSize: 16, color: Colors.green)),
                    Text('\$${ingresosTotales.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.green)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Gastos',
                        style: TextStyle(fontSize: 16, color: Colors.red)),
                    Text('\$${gastosTotales.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.red)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Últimas transacciones',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade700)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: transacciones.length,
                itemBuilder: (context, index) {
                  final t = transacciones[index];
                  final monto = (t['monto'] as num).toDouble();
                  final esIngreso = t['es_ingreso'] == 1;
                  final color = esIngreso ? Colors.green : Colors.red;

                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(
                          esIngreso
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: color),
                      title: Text(t['descripcion'],
                          style:
                              const TextStyle(fontWeight: FontWeight.w500)),
                      subtitle: Text(
                          '${formatearFecha(t['fecha'])} • Categoría: ${t['categoria_id'] ?? 'Sin categoría'}'),
                      trailing: Text('\$${monto.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: color)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
