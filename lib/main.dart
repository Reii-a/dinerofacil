import 'package:flutter/material.dart';

void main() {
  runApp(DineroFacilApp());
}

class DineroFacilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dinero Fácil',
      theme: ThemeData(primarySwatch: Colors.green),
      home: FinanzasHome(),
    );
  }
}

class FinanzasHome extends StatefulWidget {
  @override
  _FinanzasHomeState createState() => _FinanzasHomeState();
}

class _FinanzasHomeState extends State<FinanzasHome> {
  List<Map<String, dynamic>> registros = [];
  double balance = 0.0;

  final _controllerDescripcion = TextEditingController();
  final _controllerMonto = TextEditingController();

  void _agregarRegistro(bool esIngreso) {
    final descripcion = _controllerDescripcion.text;
    final monto = double.tryParse(_controllerMonto.text);

    if (descripcion.isEmpty || monto == null) return;

    setState(() {
      registros.add({
        'descripcion': descripcion,
        'monto': esIngreso ? monto : -monto,
        'fecha': DateTime.now()
      });
      balance += esIngreso ? monto : -monto;
      _controllerDescripcion.clear();
      _controllerMonto.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dinero Fácil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Balance: \$${balance.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextField(
              controller: _controllerDescripcion,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _controllerMonto,
              decoration: InputDecoration(labelText: 'Monto'),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => _agregarRegistro(true),
                    child: Text('Ingreso')),
                ElevatedButton(
                    onPressed: () => _agregarRegistro(false),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Gasto')),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: registros.length,
                itemBuilder: (context, index) {
                  final reg = registros[index];
                  return ListTile(
                    title: Text(reg['descripcion']),
                    subtitle:
                        Text('${reg['fecha'].toString().substring(0, 16)}'),
                    trailing: Text(
                      '\$${reg['monto'].toStringAsFixed(2)}',
                      style: TextStyle(
                          color: reg['monto'] >= 0 ? Colors.green : Colors.red),
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
