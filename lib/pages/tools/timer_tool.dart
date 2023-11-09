import 'package:flutter/material.dart';
import 'package:mobileapp/components/animated_logo.dart';
import 'package:mobileapp/components/buttons.dart';
import 'package:mobileapp/components/rebuilder.dart';
import 'package:mobileapp/theme.dart';

class TimerTool extends StatefulWidget {
  const TimerTool({Key? key}) : super(key: key);

  @override
  _TimerToolState createState() => _TimerToolState();
}

class _TimerToolState extends State<TimerTool> {
  int? startTime;
  int frozenTime = 0;

  int get duration => startTime == null
      ? frozenTime
      : DateTime.now().millisecondsSinceEpoch - startTime!;

  String getTime(int duration) {
    final hours = duration ~/ 3600000;
    final minutes = (duration % 3600000) ~/ 60000;
    final seconds = (duration % 60000) ~/ 1000;
    final milliseconds = duration % 1000;
    return '${_format(hours, 2)}:${_format(minutes, 2)}:${_format(seconds, 2)}:${_format(milliseconds, 3)}';
  }

  String _format(int value, int digits) {
    return value.toString().padLeft(digits, '0');
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
            Container(
              height: 256,
              child: AnimatedLogo(
                child: Rebuilder(
                  interval: const Duration(milliseconds: 100),
                  builder: (context) {
                    return Text(
                      getTime(duration),
                      style: TextStyle(
                        color: kSecondaryTextColor,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 64),
            if (startTime != null)
              GlassPaneElevatedButton(
                  child: Text('Stop'),
                  onPressed: () {
                    setState(() {
                      frozenTime = duration;
                      startTime = null;
                    });
                  }),
            if (startTime == null)
              GlassPaneElevatedButton(
                  child: Text(frozenTime == 0 ? 'Start' : 'Resume'),
                  onPressed: () {
                    setState(() {
                      // startTime = DateTime.now().millisecondsSinceEpoch - fr
                      startTime =
                          DateTime.now().millisecondsSinceEpoch - frozenTime;
                    });
                  }),
            if (startTime == null && frozenTime > 0)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: GlassPaneElevatedButton(
                    child: Text('Reset'),
                    onPressed: () {
                      setState(() {
                        frozenTime = 0;
                      });
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
