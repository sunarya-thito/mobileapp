import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/main.dart';

import 'components/tool_card.dart';
import 'components/tool_tile.dart';

class ToolsData extends InheritedWidget {
  final Map<Tool, int> tools; // tool, lastUsage
  final ToolsManagerState state;

  ToolsData({
    required this.tools,
    required this.state,
    required Widget child,
  }) : super(child: child);

  static ToolsData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ToolsData>()!;
  }

  @override
  bool updateShouldNotify(ToolsData oldWidget) {
    return tools != oldWidget.tools || state != oldWidget.state;
  }

  void pushToRoute(BuildContext context, Tool tool) {
    state.pushToRoute(context, tool);
  }

  List<Widget> buildToolsListTile({double gap = 10}) {
    List<Tool> ts = [...tools.keys];
    List<Widget> list = [];
    for (int i = 0; i < tools.length; i++) {
      list.add(
        ToolTile(
          tool: ts[i],
        ),
      );
      if (i < tools.length - 1) {
        list.add(SizedBox(height: gap));
      }
    }
    return list;
  }

  List<Widget> buildToolsRow(
      {int truncate = 6, int itemsPerRow = 3, double gap = 10}) {
    List<Widget> rows = [];
    List<Widget> card = buildToolsCard(truncate: truncate);
    for (int i = 0; i < card.length; i += itemsPerRow) {
      List<Widget> row = [];
      // add gap between cards
      for (int j = 0; j < itemsPerRow; j++) {
        row.add(
          Expanded(
            child: card[i + j],
          ),
        );
        if (j < itemsPerRow - 1) {
          row.add(SizedBox(width: gap));
        }
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: row,
        ),
      );
      if (i < card.length - itemsPerRow) {
        rows.add(SizedBox(height: gap));
      }
    }
    return rows;
  }

  List<Widget> buildToolsCard({int truncate = 6}) {
    List<MapEntry<Tool, int>> ts = tools.entries.toList();
    ts.sort((a, b) => b.value.compareTo(a.value));
    if (ts.length > truncate) {
      ts = ts.sublist(0, truncate);
    }
    return ts.map((e) => ToolCard(tool: e.key)).toList();
  }
}

class ToolsManager extends StatefulWidget {
  final Widget child;

  const ToolsManager({Key? key, required this.child}) : super(key: key);

  @override
  ToolsManagerState createState() => ToolsManagerState();
}

class ToolsManagerState extends State<ToolsManager> {
  Map<Tool, int> tools = {};

  @override
  void initState() {
    super.initState();
    for (Tool tool in _tools) {
      tools[tool] = 0;
    }
  }

  void pushToRoute(BuildContext context, Tool tool) {
    setState(() {
      tools[tool] = DateTime.now().millisecondsSinceEpoch;
      context.pushNamed(tool.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToolsData(
      tools: {
        ...tools,
      },
      state: this,
      child: widget.child,
    );
  }
}

class Tool {
  final Widget icon;
  final String name;
  final String description;
  final String routeName;

  Tool({
    required this.icon,
    required this.name,
    required this.description,
    required this.routeName,
  });

  // int lastUsage = 0;
  //
  // void pushToRoute(BuildContext context) {
  //   lastUsage = DateTime.now().millisecondsSinceEpoch;
  //   context.pushNamed(routeName);
  // }
}

final _tools = [
  Tool(
    name: 'BMI Calculator',
    description:
        'Menghitung indeks massa tubuh berdasarkan tinggi dan berat badan',
    icon: const Icon(Icons.monitor_weight_outlined),
    routeName: kToolsBMIPage,
  ),
  Tool(
    name: 'Calculator',
    description: 'Kalkulator sederhana',
    icon: const Icon(Icons.calculate_outlined),
    routeName: kToolsCalculatorPage,
  ),
  Tool(
    name: 'Timer',
    description: 'Tool untuk menghitung waktu',
    icon: const Icon(Icons.timer_outlined),
    routeName: kToolsTimerPage,
  ),
  Tool(
    name: 'Grade Calculator',
    description: 'Menghitung nilai akhir',
    icon: const Icon(Icons.grade_outlined),
    routeName: kToolsGradePage,
  ),
  Tool(
    name: 'Temp Converter',
    description: 'Konversi suhu',
    icon: const Icon(Icons.thermostat_outlined),
    routeName: kToolsTemperaturePage,
  ),
  Tool(
    name: 'Length Converter',
    description: 'Konversi satuan panjang',
    icon: const Icon(Icons.straighten_outlined),
    routeName: kToolsLengthPage,
  ),
  Tool(
    name: 'Weight Converter',
    description: 'Konversi satuan berat',
    icon: const Icon(Icons.line_weight_outlined),
    routeName: kToolsWeightPage,
  ),
  Tool(
    name: 'Currency Converter',
    description: 'Konversi mata uang',
    icon: const Icon(Icons.money_outlined),
    routeName: kToolsCurrencyConverterPage,
  ),
  Tool(
    name: 'File Size Converter',
    description: 'Konversi ukuran file',
    icon: const Icon(Icons.sd_storage_outlined),
    routeName: kToolsFileSizeConverterPage,
  ),
  Tool(
    name: 'Time Converter',
    description: 'Konversi satuan waktu',
    icon: const Icon(Icons.timer_outlined),
    routeName: kToolsTimeConverterPage,
  ),
  // Number System Converter
  Tool(
    name: 'Decimal Converter',
    description: 'Konversi sistem bilangan',
    icon: const Icon(Icons.numbers),
    routeName: kToolsNumberConverterPage,
  ),
];
