import 'package:currency_converter/currency.dart';
import 'package:units_converter/units_converter.dart';

class ConversionUnit {
  final String name;
  final dynamic unit;

  const ConversionUnit({
    required this.name,
    required this.unit,
  });

  String get unitName {
    return _titleCase(name);
  }
}

String _titleCase(String text) {
  List<String> words = text.split(' ');
  for (int i = 0; i < words.length; i++) {
    if (words[i].length <= 2) {
      words[i] = words[i].toUpperCase();
      continue;
    }
    words[i] = words[i][0].toUpperCase() + words[i].substring(1);
  }
  return words.join(' ');
}

class Conversion {
  final String name;
  final List<ConversionUnit> units;

  const Conversion({
    required this.name,
    required this.units,
  });
}

final Conversion lengthConversion = Conversion(
    name: 'Length',
    units: LENGTH.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion massConversion = Conversion(
    name: 'Mass',
    units:
        MASS.values.map((e) => ConversionUnit(name: e.name, unit: e)).toList());
final Conversion temperatureConversion = Conversion(
    name: 'Temperature',
    units: TEMPERATURE.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion timeConversion = Conversion(
    name: 'Time',
    units:
        TIME.values.map((e) => ConversionUnit(name: e.name, unit: e)).toList());
final Conversion digitalStorageConversion = Conversion(
    name: 'Digital Data',
    units: DIGITAL_DATA.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion speedConversion = Conversion(
    name: 'Speed',
    units: SPEED.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion areaConversion = Conversion(
    name: 'Area',
    units:
        AREA.values.map((e) => ConversionUnit(name: e.name, unit: e)).toList());
final Conversion volumeConversion = Conversion(
    name: 'Volume',
    units: VOLUME.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion pressureConversion = Conversion(
    name: 'Pressure',
    units: PRESSURE.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion energyConversion = Conversion(
    name: 'Energy',
    units: ENERGY.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion numberConversion = Conversion(
    name: 'Number',
    units: NUMERAL_SYSTEMS.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion powerConversion = Conversion(
    name: 'Power',
    units: POWER.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion forceConversion = Conversion(
    name: 'Force',
    units: FORCE.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion angleConversion = Conversion(
    name: 'Angle',
    units: ANGLE.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion illuminanceConversion = Conversion(
    name: 'Illuminance',
    units: ILLUMINANCE.values
        .map((e) => ConversionUnit(name: e.name, unit: e))
        .toList());
final Conversion currencyConversion = Conversion(
    name: 'Currency',
    units: Currency.values
        .map((e) => ConversionUnit(name: e.name.toUpperCase(), unit: e))
        .toList());
