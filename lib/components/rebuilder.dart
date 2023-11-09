import 'package:flutter/material.dart';

class Rebuilder extends StatefulWidget {
  final WidgetBuilder builder;
  final Duration interval;
  const Rebuilder({
    Key? key,
    required this.builder,
    this.interval = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _RebuilderState createState() => _RebuilderState();
}

class _RebuilderState extends State<Rebuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.interval);
    super.initState();
    _controller.repeat();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant Rebuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.interval != widget.interval) {
      _controller.duration = widget.interval;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
