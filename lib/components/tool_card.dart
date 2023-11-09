import 'package:flutter/material.dart';
import 'package:mobileapp/tool_manager.dart';

import '../theme.dart';

class ToolCard extends StatelessWidget {
  final Tool tool;

  const ToolCard({Key? key, required this.tool}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: kSurfaceBorderColor,
          width: 2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          ToolsData.of(context).state.pushToRoute(context, tool);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned(
                left: -20,
                bottom: -20,
                child: IconTheme(
                    data: IconThemeData(size: 90, color: kFocusedSurfaceColor),
                    child: tool.icon),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                height: 120,
                alignment: Alignment.topRight,
                child: Text(tool.name, textAlign: TextAlign.right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
