import 'package:flutter/material.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text('Aquí se mostrarán las categorías.'),
      ),
    );
  }
}
