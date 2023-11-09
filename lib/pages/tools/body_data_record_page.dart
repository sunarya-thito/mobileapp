import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobileapp/components/body_data_chart.dart';
import 'package:mobileapp/components/buttons.dart';
import 'package:mobileapp/components/glass_pane_text_field.dart';
import 'package:mobileapp/user_manager.dart';

import '../../theme.dart';

class BodyDataRecordPage extends StatefulWidget {
  const BodyDataRecordPage({Key? key}) : super(key: key);

  @override
  _BodyDataRecordPageState createState() => _BodyDataRecordPageState();
}

class _BodyDataRecordPageState extends State<BodyDataRecordPage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Data Record'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 96,
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 192,
              child: BodyDataChart(),
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              'Tambah Data Baru',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            GlassPaneTextField(
                controller: weightController,
                label: 'Weight',
                keyboardType: TextInputType.number),
            const SizedBox(
              height: 10,
            ),
            GlassPaneTextField(
                controller: heightController,
                label: 'Height',
                keyboardType: TextInputType.number),
            const SizedBox(
              height: 32,
            ),
            GlassPaneElevatedButton(
                child: Text('Tambah'),
                onPressed: () {
                  double? weight = double.tryParse(weightController.text);
                  double? height = double.tryParse(heightController.text);
                  if (weight == null || height == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Weight dan Height harus berupa angka'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Baiklah'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  BodyRecordData.of(context)!
                      .addData(BodyData(height: height, weight: weight));
                }),
            const SizedBox(
              height: 8,
            ),
            GlassPaneElevatedButton(
              child: Text('Hapus Terakhir'),
              onPressed: () {
                BodyRecordData.of(context)!.popData();
              },
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              height: 8,
            ),
            // tambah random data
            GlassPaneElevatedButton(
              child: Text('Tambah Random Data'),
              onPressed: () {
                Random random = Random();
                BodyRecordData.of(context)!.addData(BodyData(
                    height: random.nextDouble() * 100 + 150,
                    weight: random.nextDouble() * 50 + 50));
              },
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
