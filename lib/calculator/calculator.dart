import 'package:flutter/material.dart';
import 'package:flutter_calculator_demo/calculator/calculator_state.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonSpacing = 3.0;
    final buttonLayout = [
      ['cos(', 'sin(', 'tan(', 'back'],
      ['sqrt(', 'pi', '.', '+'],
      ['1', '2', '3', '-'],
      ['4', '5', '6', '*'],
      ['7', '8', '9', '/'],
      ['0', '(', ')', '='],
    ];

    var state = Provider.of<CalculatorState>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.transparent,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(
              right: buttonSpacing,
            ),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                state.equation.isNotEmpty ? state.equation : ' ',
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buttonLayout.map((btnLst) {
                return Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: btnLst
                        .map(
                          (expr) => Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(buttonSpacing),
                              child: CalculatorButton(expression: expr),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String expression;

  const CalculatorButton({
    super.key,
    required this.expression,
  });

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<CalculatorState>(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            expression == '=' ? Colors.green : Theme.of(context).primaryColor,
        splashFactory: NoSplash.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () {
        state.handleExpression(expression);
      },
      onLongPress: () {
        state.clearEquation();
      },
      child: getButtonWidget(),
    );
  }

  Widget getButtonWidget() {
    switch (expression) {
      case 'back':
        return const Icon(
          Icons.backspace,
          size: 15,
        );
      case 'sqrt(':
        return const Text(
          '√',
          style: TextStyle(
            fontSize: 20,
          ),
        );
      case 'pi':
        return const Text(
          'π',
          style: TextStyle(
            fontSize: 20,
          ),
        );
      default:
        return Text(
          expression,
          style: const TextStyle(
            fontSize: 20,
          ),
        );
    }
  }
}
