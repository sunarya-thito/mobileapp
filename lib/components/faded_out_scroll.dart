import 'package:flutter/material.dart';
import 'package:mobileapp/theme.dart';

class FadedOutScroll extends StatefulWidget {
  final ScrollController controller;
  final Widget child;
  final Color color;

  const FadedOutScroll({
    Key? key,
    required this.controller,
    required this.child,
    this.color = kBackgroundColor,
  }) : super(key: key);

  @override
  _FadedOutScrollState createState() => _FadedOutScrollState();
}

class _FadedOutScrollState extends State<FadedOutScroll> {
  bool _showFadeBottom = false;
  bool _showFadeTop = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
    if (widget.controller.hasClients) {
      if (widget.controller.offset <
          widget.controller.position.maxScrollExtent) {
        _showFadeBottom = true;
      }
      if (widget.controller.offset > 0) {
        _showFadeTop = true;
      }
    } else {
      _showFadeBottom = true;
      _showFadeTop = false;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (widget.controller.offset < widget.controller.position.maxScrollExtent) {
      if (!_showFadeBottom) {
        setState(() {
          _showFadeBottom = true;
        });
      }
    } else {
      if (_showFadeBottom) {
        setState(() {
          _showFadeBottom = false;
        });
      }
    }
    if (widget.controller.offset > 0) {
      if (!_showFadeTop) {
        setState(() {
          _showFadeTop = true;
        });
      }
    } else {
      if (_showFadeTop) {
        setState(() {
          _showFadeTop = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 250,
          child: AnimatedOpacity(
            opacity: _showFadeBottom ? 1 : 0,
            duration: Duration(milliseconds: 200),
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0, 0.1, 1],
                    colors: [
                      widget.color.withOpacity(1),
                      widget.color.withOpacity(1),
                      widget.color.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 50,
          child: AnimatedOpacity(
            opacity: _showFadeTop ? 1 : 0,
            duration: Duration(milliseconds: 200),
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      widget.color.withOpacity(1),
                      widget.color.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
