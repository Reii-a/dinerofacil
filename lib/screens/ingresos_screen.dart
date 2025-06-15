import 'package:flutter/material.dart';

class IngresosScreen extends StatelessWidget {
  const IngresosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresos'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text('Aquí verás, agregarás y eliminarás ingresos'),
      ),
    );
  }
}
