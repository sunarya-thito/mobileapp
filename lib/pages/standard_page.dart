import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/components/bottom_nav_bar.dart';
import 'package:mobileapp/theme.dart';

class StandardPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const StandardPage({
    super.key,
    required this.navigationShell,
  });

  @override
  _StandardPageState createState() => _StandardPageState();
}

class _StandardPageState extends State<StandardPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: kBackgroundColor,
              child: widget.navigationShell,
            ),
          ),
          Positioned(
            bottom: 18,
            left: 18,
            right: 18,
            height: 64,
            child: BottomNavBar(
              navigationShell: widget.navigationShell,
            ),
          ),
        ],
      ),
    );
  }
}
