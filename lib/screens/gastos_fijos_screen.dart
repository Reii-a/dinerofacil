import 'package:flutter/material.dart';

class GastosFijosScreen extends StatelessWidget {
  const GastosFijosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos Fijos'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text('Aquí verás, agregarás y eliminarás gastos fijos'),
      ),
    );
  }
}
