import 'package:flutter/material.dart';
import 'package:mobileapp/animation_lib.dart';
import 'package:mobileapp/components/animated_logo.dart';

import '../../theme.dart';
import 'b_m_i_calculator.dart';

class BMIResultShow extends StatefulWidget {
  final double weightKg;
  final double heightCm;

  const BMIResultShow({
    Key? key,
    required this.weightKg,
    required this.heightCm,
  }) : super(key: key);

  @override
  _BMIResultShowState createState() => _BMIResultShowState();
}

class _BMIResultShowState extends State<BMIResultShow>
    with SingleTickerProviderStateMixin {
  /*
  Animation Stages: (in seconds)
  0-1: Slide In Height and Zoom In Height
  0-2: Animate Height Value
  3-4: Scale down and move up a lil bit the height
  3-4: Slide in Weight and Zoom in Weight
  3-5: Animate Weight Value
  6-7: Scale down and move up a lil bit the weight
  6-7: Slide Out to top the height
  6-7: Slide In BMI and Zoom In BMI
  6-8: Animate BMI Value
  11-12: Scale down and move up a lil bit the BMI
  11-12: Fade in fat/skinny image
   */
  late AnimationController _controller;

  @override
  void initState() {
    const Duration duration = Duration(seconds: 16);
    _controller = AnimationController(vsync: this, duration: duration);
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

  double get bmi =>
      widget.weightKg / (widget.heightCm / 100) / (widget.heightCm / 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        surfaceTintColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              // height
              Positioned(
                top: Timeline(tweens: [
                  TweenAnim(
                    start: Duration.zero,
                    end: Duration(seconds: 1),
                    startValue: constraints.maxHeight,
                    endValue: constraints.maxHeight / 2 - 120,
                    curve: Curves.easeOutCubic,
                  ),
                  TweenAnim(
                    start: Duration(seconds: 3),
                    end: Duration(seconds: 4),
                    startValue: constraints.maxHeight / 2 - 120,
                    endValue: 100,
                    curve: Curves.easeOutCubic,
                  ),
                  TweenAnim(
                    start: Duration(seconds: 6),
                    end: Duration(seconds: 7),
                    startValue: 100,
                    endValue: -200,
                    curve: Curves.easeOutCubic,
                  ),
                ], parent: _controller)
                    .value,
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: Timeline(tweens: [
                    TweenAnim(
                      start: Duration.zero,
                      end: Duration(seconds: 1),
                      startValue: 0.5,
                      endValue: 1,
                      curve: Curves.easeOutCubic,
                    ),
                    TweenAnim(
                      start: Duration(seconds: 3),
                      end: Duration(seconds: 4),
                      startValue: 1,
                      endValue: 0.5,
                      curve: Curves.easeOutCubic,
                    ),
                    TweenAnim(
                      start: Duration(seconds: 6),
                      end: Duration(seconds: 7),
                      startValue: 0.5,
                      endValue: 0.2,
                      curve: Curves.easeOutCubic,
                    ),
                  ], parent: _controller)
                      .value,
                  child: Opacity(
                    opacity: Timeline(tweens: [
                      TweenAnim(
                        start: Duration.zero,
                        end: Duration(seconds: 1),
                        startValue: 0,
                        endValue: 1,
                        curve: Curves.easeOutCubic,
                      ),
                      TweenAnim(
                        start: Duration(seconds: 6),
                        end: Duration(seconds: 7),
                        startValue: 1,
                        endValue: 0,
                        curve: Curves.easeOutCubic,
                      ),
                    ], parent: _controller)
                        .value,
                    child: Column(
                      children: [
                        Text('Tinggi Badan Anda',
                            style: TextStyle(fontSize: 28)),
                        Text(
                            '${(widget.heightCm * Timeline(
                                  tweens: [
                                    TweenAnim(
                                        start: Duration.zero,
                                        end: Duration(seconds: 2))
                                  ],
                                  parent: _controller,
                                ).value).toInt()} cm',
                            style: TextStyle(
                                fontSize: 64, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              // weight
              Positioned(
                top: Timeline(tweens: [
                  TweenAnim(
                    start: Duration(seconds: 3),
                    end: Duration(seconds: 4),
                    startValue: constraints.maxHeight,
                    endValue: constraints.maxHeight / 2 - 120,
                    curve: Curves.easeOutCubic,
                  ),
                  TweenAnim(
                    start: Duration(seconds: 6),
                    end: Duration(seconds: 7),
                    startValue: constraints.maxHeight / 2 - 120,
                    endValue: 100,
                    curve: Curves.easeOutCubic,
                  ),
                  TweenAnim(
                    start: Duration(seconds: 9),
                    end: Duration(seconds: 10),
                    startValue: 100,
                    endValue: -200,
                    curve: Curves.easeOutCubic,
                  ),
                ], parent: _controller)
                    .value,
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: Timeline(tweens: [
                    TweenAnim(
                      start: Duration(seconds: 3),
                      end: Duration(seconds: 4),
                      startValue: 0.5,
                      endValue: 1,
                      curve: Curves.easeOutCubic,
                    ),
                    TweenAnim(
                      start: Duration(seconds: 6),
                      end: Duration(seconds: 7),
                      startValue: 1,
                      endValue: 0.5,
                      curve: Curves.easeOutCubic,
                    ),
                    TweenAnim(
                      start: Duration(seconds: 9),
                      end: Duration(seconds: 10),
                      startValue: 0.5,
                      endValue: 0.2,
                      curve: Curves.easeOutCubic,
                    ),
                  ], parent: _controller)
                      .value,
                  child: Opacity(
                    opacity: Timeline(tweens: [
                      TweenAnim(
                        start: Duration(seconds: 3),
                        end: Duration(seconds: 4),
                        startValue: 0,
                        endValue: 1,
                        curve: Curves.easeOutCubic,
                      ),
                      TweenAnim(
                        start: Duration(seconds: 9),
                        end: Duration(seconds: 10),
                        startValue: 1,
                        endValue: 0,
                        curve: Curves.easeOutCubic,
                      ),
                    ], parent: _controller)
                        .value,
                    child: Column(
                      children: [
                        Text('Berat Badan Anda',
                            style: TextStyle(fontSize: 28)),
                        Text(
                            '${(widget.weightKg * Timeline(
                                  tweens: [
                                    TweenAnim(
                                        start: Duration(seconds: 3),
                                        end: Duration(seconds: 5)),
                                  ],
                                  parent: _controller,
                                ).value).toInt()} kg',
                            style: TextStyle(
                                fontSize: 64, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Timeline(tweens: [
                  TweenAnim(
                    start: Duration(seconds: 6),
                    end: Duration(seconds: 7),
                    startValue: constraints.maxHeight,
                    endValue: constraints.maxHeight / 2 - 120,
                    curve: Curves.easeOutCubic,
                  ),
                  TweenAnim(
                    start: Duration(seconds: 9),
                    end: Duration(seconds: 10),
                    startValue: constraints.maxHeight / 2 - 120,
                    endValue: 20,
                    curve: Curves.easeOutCubic,
                  ),
                  TweenAnim(
                    start: Duration(seconds: 15),
                    end: Duration(seconds: 16),
                    startValue: 20,
                    endValue: -200,
                    curve: Curves.easeOutCubic,
                  ),
                ], parent: _controller)
                    .value,
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: Timeline(tweens: [
                    TweenAnim(
                      start: Duration(seconds: 6),
                      end: Duration(seconds: 7),
                      startValue: 0.5,
                      endValue: 1,
                      curve: Curves.easeOutCubic,
                    ),
                    TweenAnim(
                      start: Duration(seconds: 15),
                      end: Duration(seconds: 16),
                      startValue: 1,
                      endValue: 0.2,
                      curve: Curves.easeOutCubic,
                    ),
                  ], parent: _controller)
                      .value,
                  child: Opacity(
                    opacity: Timeline(tweens: [
                      TweenAnim(
                        start: Duration(seconds: 6),
                        end: Duration(seconds: 7),
                        startValue: 0,
                        endValue: 1,
                        curve: Curves.easeOutCubic,
                      ),
                      TweenAnim(
                        start: Duration(seconds: 15),
                        end: Duration(seconds: 16),
                        startValue: 1,
                        endValue: 0,
                        curve: Curves.easeOutCubic,
                      ),
                    ], parent: _controller)
                        .value,
                    child: Column(
                      children: [
                        Text('BMI Anda', style: TextStyle(fontSize: 28)),
                        Text(
                            (bmi *
                                    Timeline(
                                      tweens: [
                                        TweenAnim(
                                            start: Duration(seconds: 6),
                                            end: Duration(seconds: 8)),
                                      ],
                                      parent: _controller,
                                    ).value)
                                .toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 64, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: Timeline(tweens: [
                    TweenAnim(
                      start: Duration(seconds: 10),
                      end: Duration(seconds: 11),
                      startValue: 0,
                      endValue: 1,
                      curve: Curves.easeOutCubic,
                    ),
                    TweenAnim(
                      start: Duration(seconds: 15),
                      end: Duration(seconds: 15, milliseconds: 500),
                      startValue: 1,
                      endValue: 0,
                      curve: Curves.easeOutCubic,
                    ),
                  ], parent: _controller)
                      .value,
                  child: Center(
                    child: AnimatedLogo(
                      size: 512,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(BMIStatus.fromBMI(bmi).image,
                              height: 300, fit: BoxFit.fitHeight),
                          const SizedBox(height: 16),
                          Text(BMIStatus.fromBMI(bmi).name,
                              style: TextStyle(
                                  fontSize: 24, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
