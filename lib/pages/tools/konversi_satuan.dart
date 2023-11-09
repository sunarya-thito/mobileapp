import 'package:flutter/material.dart';
import 'package:mobileapp/components/animated_page_logo.dart';
import 'package:mobileapp/theme.dart';
import 'package:units_converter/models/extension_converter.dart';

import '../../converter.dart';

class KonversiSatuan extends StatefulWidget {
  final String title;
  final Conversion conversion;
  final Widget icon;

  const KonversiSatuan({
    Key? key,
    required this.title,
    required this.conversion,
    required this.icon,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _KonversiSatuanState();
  }
}

class _KonversiSatuanState extends State<KonversiSatuan> {
  final _inputController = TextEditingController(text: '0');
  final _outputController = TextEditingController(text: '0');

  late ConversionUnit _sourceUnit;
  late ConversionUnit _targetUnit;
  bool _editingInput = false;
  bool _editingOutput = false;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_onInputChanged);
    _outputController.addListener(_onOutputChanged);
    List<ConversionUnit> units = widget.conversion.units;
    _sourceUnit = units[0];
    _targetUnit = units[1];
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    if (_editingOutput) {
      return;
    }
    _editingInput = true;
    final input = _inputController.text;
    double? tryParse = double.tryParse(input);
    final result =
        tryParse?.convertFromTo(_sourceUnit.unit, _targetUnit.unit) ?? 0;
    _outputController.text = _formatNum(result);
    _editingInput = false;
  }

  void _onOutputChanged() {
    if (_editingInput) {
      return;
    }
    _editingOutput = true;
    final output = _outputController.text;
    // BigDecimal? tryParse = BigDecimal.tryParse(output);
    double parsed = double.tryParse(output) ?? 0;
    // final input = widget.conversion
    //     .convert(_targetUnit, _sourceUnit, tryParse ?? BigDecimal.zero);
    final result =
        parsed.convertFromTo(_targetUnit.unit, _sourceUnit.unit) ?? 0;
    _inputController.text = _formatNum(result);
    _editingOutput = false;
  }

  String _formatNum(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  @override
  Widget build(BuildContext context) {
    List<ConversionUnit> units = widget.conversion.units;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: kSecondaryTextColor,
        surfaceTintColor: kBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IconTheme(
              //     data: IconThemeData(size: 128, color: kSecondaryTextColor),
              //     child: widget.icon),
              // Text(
              //   widget.title,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: kSecondaryTextColor,
              //     fontSize: 24,
              //   ),
              // ),
              AnimatedPageLogo(
                icon: widget.icon,
                name: widget.title,
              ),
              const SizedBox(height: 64),
              Container(
                decoration: BoxDecoration(
                  color: kSurfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kSurfaceBorderColor, width: 2),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _inputController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration.collapsed(
                            hintText: _sourceUnit.name),
                      ),
                    ),
                    DropdownButton(
                      items: units
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.unitName),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _sourceUnit = value as ConversionUnit;
                          _onInputChanged();
                        });
                      },
                      value: _sourceUnit,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Icon(Icons.arrow_downward, color: kFocusedSurfaceColor, size: 48),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: kSurfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kSurfaceBorderColor, width: 2),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _outputController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration.collapsed(
                            hintText: _targetUnit.name),
                      ),
                    ),
                    DropdownButton(
                      items: units
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.unitName),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _targetUnit = value as ConversionUnit;
                          _onOutputChanged();
                        });
                      },
                      value: _targetUnit,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
