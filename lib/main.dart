import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'pages/tarefas_page.dart';

void main() {
  runApp(const GerenciadorTarefasApp());
}

class GerenciadorTarefasApp extends StatelessWidget {
  const GerenciadorTarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      debugShowCheckedModeBanner: false,
      theme: criarTema(Brightness.light),
      darkTheme: criarTema(Brightness.dark),
      home: const TarefasPage(),
    );
  }
}
