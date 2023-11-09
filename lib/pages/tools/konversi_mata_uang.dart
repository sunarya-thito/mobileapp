import 'package:currency_converter/currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/components/animated_page_logo.dart';
import 'package:mobileapp/components/buttons.dart';
import 'package:mobileapp/theme.dart';
import 'package:units_converter/properties/numeral_systems.dart';

import '../../converter.dart';

class KonversiMataUang extends StatefulWidget {
  final String title;
  final Conversion conversion;
  final Widget icon;

  const KonversiMataUang({
    Key? key,
    required this.title,
    required this.conversion,
    required this.icon,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _KonversiMataUangState();
  }
}

class _KonversiMataUangState extends State<KonversiMataUang> {
  final _inputController = TextEditingController(text: '0');
  final _outputController = TextEditingController(text: '0');

  late ConversionUnit _sourceUnit;
  late ConversionUnit _targetUnit;

  @override
  void initState() {
    super.initState();
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

  BuildContext? _dialogContext;

  void process() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        _dialogContext = context;
        // loader spinner
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    asyncProcess().then((value) {
      if (_dialogContext != null) {
        Navigator.pop(_dialogContext!);
        _dialogContext = null;
      }
    }).catchError((error) {
      if (_dialogContext != null) {
        Navigator.pop(_dialogContext!);
        _dialogContext = null;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    });
  }

  Future<void> asyncProcess() async {
    double tryParse = double.tryParse(_inputController.text) ?? 0;
    var converted = await CurrencyConverter.convert(
      from: _sourceUnit.unit,
      to: _targetUnit.unit,
      amount: tryParse,
    );
    _outputController.text = converted == null ? '0' : converted.toString();
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
                        keyboardType: _sourceUnit.unit ==
                                NUMERAL_SYSTEMS.decimal
                            ? TextInputType.numberWithOptions(decimal: false)
                            : TextInputType.text,
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
                        });
                      },
                      value: _sourceUnit,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              GlassPaneElevatedButton(
                onPressed: process,
                child: Text('Convert'),
              ),
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
                        readOnly: true,
                        controller: _outputController,
                        keyboardType: _targetUnit.unit ==
                                NUMERAL_SYSTEMS.decimal
                            ? TextInputType.numberWithOptions(decimal: false)
                            : TextInputType.text,
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
