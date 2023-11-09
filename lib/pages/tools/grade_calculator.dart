import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../components/animated_page_logo.dart';
import '../../theme.dart';

class GradeCalculator extends StatefulWidget {
  const GradeCalculator({Key? key}) : super(key: key);

  @override
  _GradeCalculatorState createState() => _GradeCalculatorState();
}

class _GradeCalculatorState extends State<GradeCalculator> {
  final TextEditingController controller = TextEditingController();
  GradeScale scale = scales.first;
  Grade? grade;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        grade = scale.getGrade(double.tryParse(controller.text) ?? 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: kBackgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedPageLogo(
              icon: Icon(Icons.grade_outlined),
              name: 'Grade Calculator',
            ),
            const SizedBox(height: 64),
            DropdownButtonFormField<GradeScale>(
              decoration: InputDecoration(
                fillColor: kSurfaceColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kSurfaceBorderColor, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kSurfaceBorderColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kSurfaceBorderColor, width: 2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              value: scale,
              onChanged: (value) {
                setState(() {
                  scale = value!;
                  grade = scale.getGrade(double.tryParse(controller.text) ?? 0);
                });
              },
              items: scales.map((scale) {
                return DropdownMenuItem<GradeScale>(
                  value: scale,
                  child: Text(scale.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: kSurfaceColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kSurfaceBorderColor, width: 2),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration.collapsed(hintText: 'Nilai'),
              ),
            ),
            const SizedBox(height: 16),
            if (grade != null)
              Container(
                decoration: BoxDecoration(
                  color: kSurfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kSurfaceBorderColor, width: 2),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Nilai Akhir', style: TextStyle(fontSize: 18)),
                    Text(
                      grade!.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

final List<GradeScale> scales = [
  GradeScale(name: 'Indeks Prestasi', grades: [
    Grade(name: 'A', min: 3.5, max: 4),
    Grade(name: 'AB', min: 3, max: 3.5),
    Grade(name: 'B', min: 2.5, max: 3),
    Grade(name: 'BC', min: 2, max: 2.5),
    Grade(name: 'C', min: 1.5, max: 2),
    Grade(name: 'CD', min: 1, max: 1.5),
    Grade(name: 'D', min: 0.5, max: 1),
    Grade(name: 'DE', min: 0, max: 0.5),
    Grade(name: 'E', min: -1, max: 0),
  ]),
  GradeScale(name: 'Nilai Huruf', grades: [
    Grade(name: 'A', min: 80, max: 100),
    Grade(name: 'B', min: 70, max: 80),
    Grade(name: 'C', min: 60, max: 70),
    Grade(name: 'D', min: 50, max: 60),
    Grade(name: 'E', min: 0, max: 50),
  ]),
];

class GradeScale {
  final String name;
  final List<Grade> grades;

  const GradeScale({
    required this.name,
    required this.grades,
  });

  Grade? getGrade(double value) {
    return grades
        .firstWhereOrNull((grade) => value > grade.min && value <= grade.max);
  }
}

class Grade {
  final String name;
  final double min;
  final double max;

  const Grade({
    required this.name,
    required this.min,
    required this.max,
  });
}
