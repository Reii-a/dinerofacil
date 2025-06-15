import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/gastos_fijos_screen.dart';
import 'screens/ingresos_screen.dart';
import 'screens/gastos_screen.dart';
import 'screens/historial_screen.dart';
import 'screens/categorias_screen.dart';

void main() {
  runApp(const DineroFacilApp());
}

class DineroFacilApp extends StatelessWidget {
  const DineroFacilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dinero Fácil',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.orange.shade50,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/gastos-fijos': (context) => const GastosFijosScreen(),
        '/ingresos': (context) => const IngresosScreen(),
        '/gastos': (context) => const GastosScreen(),
        '/categorias': (context) => const CategoriasScreen(),
        '/historial': (context) => const HistorialScreen(),
      },
    );
  }
}
