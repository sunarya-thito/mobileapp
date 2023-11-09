import 'package:flutter/material.dart';

class AnimatedTimerBackground extends StatefulWidget {
  const AnimatedTimerBackground({Key? key}) : super(key: key);

  @override
  _AnimatedTimerBackgroundState createState() =>
      _AnimatedTimerBackgroundState();
}

class _AnimatedTimerBackgroundState extends State<AnimatedTimerBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    super.initState();
    _controller.repeat();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  style: BorderStyle.solid,
                )),
          ),
        )
      ],
    );
  }
}
