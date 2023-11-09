import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/user_manager.dart';

class BodyDataChart extends StatefulWidget {
  const BodyDataChart({Key? key}) : super(key: key);

  @override
  _BodyDataChartState createState() => _BodyDataChartState();
}

class _BodyDataChartState extends State<BodyDataChart> {
  @override
  Widget build(BuildContext context) {
    List<BodyData> data = BodyRecordData.of(context)!.data;
    if (data.length > 10) {
      data = data.sublist(data.length - 10);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: LineChart(
            LineChartData(
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    axisNameWidget: Text('Data Berat dan Tinggi Badan'),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: data
                        .mapIndexed((i, e) => FlSpot(
                              i.toDouble(),
                              e.height,
                            ))
                        .toList(),
                    color: Colors.blue,
                    barWidth: 2,
                    dotData: FlDotData(
                      show: true,
                    ),
                  ),
                  LineChartBarData(
                    spots: data
                        .mapIndexed((i, e) => FlSpot(
                              i.toDouble(),
                              e.weight,
                            ))
                        .toList(),
                    color: Colors.red,
                    barWidth: 2,
                    dotData: FlDotData(
                      show: true,
                    ),
                  ),
                ]),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        // create legend
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text('Tinggi Badan'),
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              width: 16,
              height: 16,
              color: Colors.red,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text('Berat Badan'),
            ),
          ],
        ),
      ],
    );
  }
}

class BodyDataManager extends StatefulWidget {
  final Widget child;

  const BodyDataManager({Key? key, required this.child}) : super(key: key);

  @override
  BodyDataManagerState createState() => BodyDataManagerState();
}

class BodyDataManagerState extends State<BodyDataManager> {
  final List<BodyData> data = [];

  void addData(BodyData data) {
    setState(() {
      this.data.add(data);
    });
  }

  void popData() {
    setState(() {
      data.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BodyRecordData(
      data: [
        ...data,
      ],
      addData: addData,
      popData: popData,
      child: widget.child,
    );
  }
}

class BodyRecordData extends InheritedWidget {
  final List<BodyData> data;
  final Function(BodyData) addData;
  final Function() popData;

  const BodyRecordData({
    Key? key,
    required this.data,
    required Widget child,
    required this.addData,
    required this.popData,
  }) : super(key: key, child: child);

  static BodyRecordData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BodyRecordData>();
  }

  @override
  bool updateShouldNotify(BodyRecordData oldWidget) {
    return data != oldWidget.data;
  }
}
