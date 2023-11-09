import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/components/animated_page_logo.dart';
import 'package:mobileapp/components/buttons.dart';
import 'package:mobileapp/main.dart';
import 'package:mobileapp/theme.dart';
import 'package:units_converter/units_converter.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

enum BMIStatus {
  underweight('assets/underweight.png', 'Kurus'),
  normal('assets/normalweight.png', 'Normal'),
  overweight('assets/overweight.png', 'Gemuk'),
  obesity('assets/obesity.png', 'Obesitas'),
  extremeObesity('assets/extremeobesity.png', 'Obesitas Ekstrim');

  final String image;
  final String name;
  const BMIStatus(this.image, this.name);

  static BMIStatus fromBMI(double bmi) {
    if (bmi < 18.5) {
      return BMIStatus.underweight;
    } else if (bmi < 25) {
      return BMIStatus.normal;
    } else if (bmi < 30) {
      return BMIStatus.overweight;
    } else if (bmi < 35) {
      return BMIStatus.obesity;
    } else {
      return BMIStatus.extremeObesity;
    }
  }
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  MASS _massUnit = MASS.kilograms;
  LENGTH _lengthUnit = LENGTH.centimeters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        surfaceTintColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedPageLogo(
                icon: Icon(Icons.monitor_weight_outlined),
                name: 'BMI Calculator'),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: kSurfaceColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kSurfaceBorderColor, width: 2),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration.collapsed(hintText: 'Berat Badan'),
                    ),
                  ),
                  DropdownButton(
                    items: MASS.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _massUnit = value!;
                      });
                    },
                    value: _massUnit,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: kSurfaceColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kSurfaceBorderColor, width: 2),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration.collapsed(hintText: 'Tinggi Badan'),
                    ),
                  ),
                  DropdownButton(
                    items: LENGTH.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _lengthUnit = value!;
                      });
                    },
                    value: _lengthUnit,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            GlassPaneElevatedButton(
                child: Text('Hitung'),
                onPressed: () {
                  context.pushNamed(kToolsBMIShowPage, queryParameters: {
                    'weight': ((double.tryParse(_weightController.text) ?? 0)
                                .convertFromTo(_massUnit, MASS.kilograms) ??
                            0)
                        .toStringAsFixed(2),
                    'height': ((double.tryParse(_heightController.text) ?? 0)
                                .convertFromTo(
                                    _lengthUnit, LENGTH.centimeters) ??
                            0)
                        .toStringAsFixed(2),
                  });
                }),
          ],
        ),
      ),
    );
  }
}
