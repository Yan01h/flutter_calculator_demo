// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalculatorState extends ChangeNotifier {
  String _equation = '';

  String get equation => _equation;

  void handleExpression(String expression) {
    switch (expression) {
      case 'back':
        _handleBackspace();
        break;
      case '=':
        _solve();
        break;
      default:
        _equation = _equation + expression;
        break;
    }
    notifyListeners();
  }

  void clearEquation() {
    _equation = '';
    notifyListeners();
  }

  void _handleBackspace() {
    if (_equation.isNotEmpty) {
      _equation = _equation.substring(0, _equation.length - 1);
    }
  }

  void _solve() {
    try {
      if (_equation.isNotEmpty) {
        num result = _equation.interpret();
        result = result % 1 == 0 ? result.toInt() : result;
        _equation = '$result';
      }
    } catch (e) {
      _equation = 'Error';
    }
  }
}
