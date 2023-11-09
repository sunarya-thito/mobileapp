import 'package:collection/collection.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/components/faded_out_scroll.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/tool_manager.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBackgroundColor,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            height: 64,
            alignment: Alignment.bottomLeft,
            child: Text(
              'Tools',
              style: TextStyle(
                color: kSecondaryTextColor,
                fontSize: 24,
              ),
            ),
          ),
          backgroundColor: kBackgroundColor,
          elevation: 0,
          toolbarHeight: 90,
          surfaceTintColor: kBackgroundColor,
        ),
        backgroundColor: Colors.transparent,
        body: FadedOutScroll(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding:
                const EdgeInsets.only(top: 0, left: 18, right: 18, bottom: 96),
            children: ToolsData.of(context)
                .buildToolsListTile()
                .mapIndexed((index, element) {
              return Entry(
                opacity: 0,
                scale: 0,
                yOffset: 200,
                delay: Duration(milliseconds: 50 * index),
                child: element,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
