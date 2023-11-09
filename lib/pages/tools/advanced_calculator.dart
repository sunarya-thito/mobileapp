import 'package:flutter/material.dart';
import 'package:mobileapp/components/buttons.dart';
import 'package:mobileapp/theme.dart';

class AdvancedCalculator extends StatefulWidget {
  const AdvancedCalculator({Key? key}) : super(key: key);

  @override
  _AdvancedCalculatorState createState() => _AdvancedCalculatorState();
}

enum Operation {
  add('+'),
  subtract('-'),
  multiply('×'),
  divide('÷');

  final String symbol;

  const Operation(this.symbol);
}

class _AdvancedCalculatorState extends State<AdvancedCalculator> {
  String currentNumber = '0';
  String previousNumber = '0';
  Operation? operation;
  Widget buildButton(
    String text, {
    Color? foregroundColor,
    Color? backgroundColor,
    Color? borderColor,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: GlassPaneElevatedButton(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  void appendDecimal() {
    setState(() {
      if (currentNumber.contains('.')) {
        return;
      }
      currentNumber = '$currentNumber.';
    });
  }

  void appendNumber(int number) {
    setState(() {
      if (currentNumber == '0') {
        currentNumber = number.toString();
        return;
      }
      currentNumber = currentNumber + number.toString();
    });
  }

  void negateNumber() {
    setState(() {
      currentNumber = _formatNumber(double.parse(currentNumber) * -1);
    });
  }

  void clear() {
    setState(() {
      currentNumber = '0';
    });
  }

  void backspace() {
    setState(() {
      if (currentNumber.length == 1) {
        currentNumber = '0';
        return;
      }
      currentNumber = currentNumber.substring(0, currentNumber.length - 1);
    });
  }

  void allClear() {
    setState(() {
      currentNumber = '0';
      previousNumber = '0';
      operation = null;
    });
  }

  void add() {
    setState(() {
      equals();
      previousNumber = currentNumber;
      currentNumber = '0';
      operation = Operation.add;
    });
  }

  void subtract() {
    setState(() {
      equals();
      previousNumber = currentNumber;
      currentNumber = '0';
      operation = Operation.subtract;
    });
  }

  void multiply() {
    setState(() {
      equals();
      previousNumber = currentNumber;
      currentNumber = '0';
      operation = Operation.multiply;
    });
  }

  void divide() {
    setState(() {
      equals();
      previousNumber = currentNumber;
      currentNumber = '0';
      operation = Operation.divide;
    });
  }

  void equals() {
    setState(() {
      if (operation == null) {
        previousNumber = currentNumber;
        return;
      }
      switch (operation) {
        case Operation.add:
          currentNumber = _formatNumber(
              double.parse(previousNumber) + double.parse(currentNumber));
          break;
        case Operation.subtract:
          currentNumber = _formatNumber(
              double.parse(previousNumber) - double.parse(currentNumber));
          break;
        case Operation.multiply:
          currentNumber = _formatNumber(
              double.parse(previousNumber) * double.parse(currentNumber));
          break;
        case Operation.divide:
          currentNumber = _formatNumber(
              double.parse(previousNumber) / double.parse(currentNumber));
          break;
        default:
          break;
      }
      previousNumber = '0';
      operation = null;
    });
  }

  String _formatNumber(double number) {
    if (number == number.toInt()) {
      return number.toInt().toString();
    }
    return number.toString();
  }

  Widget gap() {
    return SizedBox(
      width: 10,
      height: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          toolbarHeight: 90,
          surfaceTintColor: kBackgroundColor,
          foregroundColor: kSecondaryTextColor,
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 96, left: 18, right: 18, top: 0),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          operation == null
                              ? previousNumber
                              : '$previousNumber ${operation?.symbol}',
                          style: TextStyle(
                            color: kSecondaryTextColor,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ), // user input
                      ),
                      Container(
                        child: Text(
                          currentNumber.toString(),
                          style: TextStyle(
                            color: kPrimaryTextColor,
                            fontSize: 48,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ), // result
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: (constraints.maxWidth - 36) / 4 * 5 + 40,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildButton('AC', onPressed: allClear),
                            gap(),
                            buildButton('C', onPressed: clear),
                            gap(),
                            buildButton('⌫', onPressed: backspace),
                            gap(),
                            buildButton('÷', onPressed: divide),
                          ],
                        ),
                      ),
                      gap(),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildButton('7', onPressed: () => appendNumber(7)),
                            gap(),
                            buildButton('8', onPressed: () => appendNumber(8)),
                            gap(),
                            buildButton('9', onPressed: () => appendNumber(9)),
                            gap(),
                            buildButton('×', onPressed: multiply),
                          ],
                        ),
                      ),
                      gap(),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildButton('4', onPressed: () => appendNumber(4)),
                            gap(),
                            buildButton('5', onPressed: () => appendNumber(5)),
                            gap(),
                            buildButton('6', onPressed: () => appendNumber(6)),
                            gap(),
                            buildButton('-', onPressed: subtract),
                          ],
                        ),
                      ),
                      gap(),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildButton('1', onPressed: () => appendNumber(1)),
                            gap(),
                            buildButton('2', onPressed: () => appendNumber(2)),
                            gap(),
                            buildButton('3', onPressed: () => appendNumber(3)),
                            gap(),
                            buildButton('+', onPressed: add),
                          ],
                        ),
                      ),
                      gap(),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildButton('±', onPressed: negateNumber),
                            gap(),
                            buildButton('0', onPressed: () => appendNumber(0)),
                            gap(),
                            buildButton('.', onPressed: appendDecimal),
                            gap(),
                            buildButton('=', onPressed: equals),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ));
  }
}
