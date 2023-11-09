import 'package:flutter/material.dart';

class PageReset extends StatefulWidget {
  final Widget child;

  const PageReset({Key? key, required this.child}) : super(key: key);

  @override
  _PageResetState createState() => _PageResetState();
}

class _PageResetState extends State<PageReset> {
  bool _show = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
