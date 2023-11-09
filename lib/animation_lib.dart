import 'dart:math';

import 'package:flutter/animation.dart';

class Timeline {
  final List<TweenAnim> tweens;
  final AnimationController parent;

  Timeline({
    required this.tweens,
    required this.parent,
  });

  Duration get currentDuration => parent.duration! * parent.value;

  TweenAnim? get currentTween {
    TweenAnim? lastTween;
    for (int i = 0; i < tweens.length; i++) {
      final tween = tweens[i];
      if (tween.start <= currentDuration) {
        lastTween = tween;
      }
    }
    return lastTween;
  }

  double get value {
    final tween = currentTween;
    if (tween == null) {
      return 0;
    }
    // <= startDuration = 0
    // >= endDuration = 1
    final double value = (currentDuration - tween.start).inMilliseconds /
        (tween.end - tween.start).inMilliseconds;
    return tweenDouble(tween.curve.transform(max(0, min(1, value))),
        tween.startValue, tween.endValue);
  }
}

double tweenDouble(double value, double start, double end) {
  return start + (end - start) * value;
}

class TweenAnim {
  final Duration start;
  final Duration end;
  final double startValue;
  final double endValue;

  final Curve curve;

  TweenAnim({
    required this.start,
    required this.end,
    this.startValue = 0,
    this.endValue = 1,
    this.curve = Curves.linear,
  });
}
