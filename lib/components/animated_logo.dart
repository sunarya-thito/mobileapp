import 'dart:math';

import 'package:flutter/material.dart';

import '../theme.dart';

class AnimatedLogo extends StatefulWidget {
  final Widget child;
  final double size;

  const AnimatedLogo({
    Key? key,
    required this.child,
    this.size = 256,
  }) : super(key: key);
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
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
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Center(
          child: Container(
            width: widget.size * _controller.value,
            height: widget.size * _controller.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kSecondaryTextColor
                  .withOpacity(_rippleTween(_controller.value) * 0.7),
            ),
          ),
        ),
        Center(
          child: Container(
            width: widget.size * max(_controller.value - 0.3, 0),
            height: widget.size * max(_controller.value - 0.3, 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kSecondaryTextColor
                  .withOpacity(_rippleTween(_controller.value) * 0.7),
            ),
          ),
        ),
        Center(
          child: Container(
            width: widget.size * max(_controller.value - 0.6, 0),
            height: widget.size * max(_controller.value - 0.6, 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kSecondaryTextColor
                  .withOpacity(_rippleTween(_controller.value) * 0.7),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}
