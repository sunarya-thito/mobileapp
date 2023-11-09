import 'dart:math';

import 'package:flutter/material.dart';

import '../theme.dart';

class AnimatedPageLogo extends StatefulWidget {
  final Widget icon;
  final String name;

  const AnimatedPageLogo({
    Key? key,
    required this.icon,
    required this.name,
  }) : super(key: key);
  @override
  _AnimatedPageLogoState createState() => _AnimatedPageLogoState();
}

class _AnimatedPageLogoState extends State<AnimatedPageLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    // 0 - 0.5 Logo Zoom In
    // 0.5 - 1 Logo Zoom Out
    // 0.5 - 1 Ripple Size
    super.initState();
    // repeat the animation
    _controller.repeat();
    _controller.addListener(() {
      setState(() {});
    });
  }

  double _logoBounceTween(double t) {
    if (t < 0.3) {
      return Curves.easeIn.transform(t * (1 / 0.3));
    } else {
      return Curves.easeIn.transform(1 - (t - 0.3) * (1 / 0.7));
    }
  }

  double _rippleTween(double t) {
    if (t < 0.3) {
      return Curves.easeIn.transform(t * (1 / 0.3));
    } else {
      // 0.5 - 1 size: 0 - 1
      return Curves.easeIn.transform(1 - (t - 0.3) * (1 / 0.7));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              left: -256,
              top: -256,
              bottom: -256,
              right: -256,
              child: Center(
                child: Container(
                  width: 256 * _controller.value,
                  height: 256 * _controller.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kSecondaryTextColor
                        .withOpacity(_rippleTween(_controller.value) * 0.7),
                  ),
                ),
              ),
            ),
            Positioned(
              left: -256,
              top: -256,
              bottom: -256,
              right: -256,
              child: Center(
                child: Container(
                  width: 256 * max(_controller.value - 0.3, 0),
                  height: 256 * max(_controller.value - 0.3, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kSecondaryTextColor
                        .withOpacity(_rippleTween(_controller.value) * 0.7),
                  ),
                ),
              ),
            ),
            Positioned(
              left: -256,
              top: -256,
              bottom: -256,
              right: -256,
              child: Center(
                child: Container(
                  width: 256 * max(_controller.value - 0.6, 0),
                  height: 256 * max(_controller.value - 0.6, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kSecondaryTextColor
                        .withOpacity(_rippleTween(_controller.value) * 0.7),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 128 + 30,
              height: 128 + 30,
              child: IconTheme(
                  data: IconThemeData(
                      size: 128 + 30 * _logoBounceTween(_controller.value),
                      color: kSecondaryTextColor),
                  child: widget.icon),
            ),
          ],
        ),
        Text(
          widget.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kSecondaryTextColor,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
