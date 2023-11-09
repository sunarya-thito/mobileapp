import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/theme.dart';

class BottomNavBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavBar({Key? key, required this.navigationShell})
      : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

const Object _heroTag = Object();

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: Material(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          decoration: BoxDecoration(
            color: kSurfaceColor,
            borderRadius: BorderRadius.circular(500),
            border: Border.all(
              color: kSurfaceBorderColor,
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Row(
                  children: [
                    Flexible(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: widget.navigationShell.currentIndex == 0
                            ? Hero(
                                tag: _heroTag,
                                child: buildSelection(),
                              )
                            : Container(),
                        onTap: () {
                          if (widget.navigationShell.currentIndex == 0) {
                            // pop to root
                            var ctx = widget.navigationShell.shellRouteContext
                                .navigatorKey.currentContext;
                            Navigator.of(ctx!)
                                .popUntil((route) => route.isFirst);
                            return;
                          }
                          widget.navigationShell.goBranch(0);
                        },
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: widget.navigationShell.currentIndex == 1
                            ? Hero(
                                tag: _heroTag,
                                child: buildSelection(),
                              )
                            : Container(),
                        onTap: () {
                          if (widget.navigationShell.currentIndex == 1) {
                            // pop to root
                            var ctx = widget.navigationShell.shellRouteContext
                                .navigatorKey.currentContext;
                            Navigator.of(ctx!)
                                .popUntil((route) => route.isFirst);
                            return;
                          }
                          widget.navigationShell.goBranch(1);
                        },
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: widget.navigationShell.currentIndex == 2
                            ? Hero(
                                tag: _heroTag,
                                child: buildSelection(),
                              )
                            : Container(),
                        onTap: () {
                          if (widget.navigationShell.currentIndex == 2) {
                            // pop to root
                            var ctx = widget.navigationShell.shellRouteContext
                                .navigatorKey.currentContext;
                            Navigator.of(ctx!)
                                .popUntil((route) => route.isFirst);
                            return;
                          }
                          widget.navigationShell.goBranch(2);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned.fill(
                child: IgnorePointer(
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Icon(Icons.home_filled),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Icon(Icons.settings),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildSelection() {
    return Container(
      decoration: BoxDecoration(
        color: kFocusedSurfaceColor,
        borderRadius: BorderRadius.circular(500),
        border: Border.all(
          color: kFocusedSurfaceBorderColor,
          width: 2,
        ),
      ),
    );
  }
}
