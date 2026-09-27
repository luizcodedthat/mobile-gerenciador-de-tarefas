import 'package:flutter/material.dart';

const Color corSemente = Color(0xFF3F51B5);
const Color corPendente = Color(0xFFE65100);
const Color corConcluida = Color(0xFF2E7D32);

ThemeData criarTema(Brightness brightness) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: corSemente,
      brightness: brightness,
    ),
    appBarTheme: const AppBarTheme(centerTitle: false),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
