import 'package:flutter/material.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/tool_manager.dart';

class ToolTile extends StatelessWidget {
  final Tool tool;

  const ToolTile({
    Key? key,
    required this.tool,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: kSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: kSurfaceBorderColor,
          width: 2,
        ),
      ),
      contentPadding: EdgeInsets.only(left: 18, top: 0, bottom: 0, right: 12),
      trailing: IconButton(
        icon: Icon(Icons.chevron_right_outlined),
        color: kSecondaryTextColor,
        onPressed: () {
          ToolsData.of(context).state.pushToRoute(context, tool);
        },
      ),
      leading: IconTheme(
          data: IconThemeData(size: 48, color: kSecondaryTextColor),
          child: tool.icon),
      title: Text(tool.name, style: TextStyle(color: kSecondaryTextColor)),
      subtitle: Text(tool.description),
      onTap: () {
        ToolsData.of(context).state.pushToRoute(context, tool);
      },
    );
  }
}
