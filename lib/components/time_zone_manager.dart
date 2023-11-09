import 'package:flutter/material.dart';

class TimeZoneManager extends StatefulWidget {
  final Widget child;

  const TimeZoneManager({Key? key, required this.child}) : super(key: key);
  @override
  _TimeZoneManagerState createState() => _TimeZoneManagerState();
}

class _TimeZoneManagerState extends State<TimeZoneManager> {
  final List<String> locations = [];
  @override
  Widget build(BuildContext context) {
    return TimeZoneData(
      locations: [
        ...locations,
      ],
      addLocation: (String location) {
        setState(() {
          locations.add(location);
        });
      },
      removeLocation: (int index) {
        setState(() {
          locations.removeAt(index);
        });
      },
      child: widget.child,
    );
  }
}

class TimeZoneData extends InheritedWidget {
  final List<String> locations;
  final Function(String) addLocation;
  final Function(int) removeLocation;

  const TimeZoneData({
    Key? key,
    required Widget child,
    required this.locations,
    required this.addLocation,
    required this.removeLocation,
  }) : super(key: key, child: child);

  static TimeZoneData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TimeZoneData>()!;
  }

  @override
  bool updateShouldNotify(TimeZoneData oldWidget) {
    return locations != oldWidget.locations;
  }
}
