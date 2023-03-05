import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calculator_demo/calculator/calculator.dart';
import 'package:flutter_calculator_demo/calculator/calculator_state.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(500, 800),
      center: true,
      title: 'Flutter Calculator',
    );
    windowManager.waitUntilReadyToShow(
      windowOptions,
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  }

  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorState(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        //themeMode: ThemeMode.dark,
        home: const CalculatorScreen(),
      ),
    );
  }
}
