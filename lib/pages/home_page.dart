import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/components/faded_out_scroll.dart';
import 'package:mobileapp/components/rebuilder.dart';
import 'package:mobileapp/components/time_zone_manager.dart';
import 'package:mobileapp/main.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/tool_manager.dart';
import 'package:timezone/timezone.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: FadedOutScroll(
            controller: controller,
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.only(
                top: 24,
                left: 18,
                right: 18,
                bottom: 96,
              ),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Baru Saja Digunakan',
                        style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.goNamed(kToolsPage);
                      },
                      icon: Icon(Icons.arrow_forward_ios,
                          color: kSecondaryTextColor),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...ToolsData.of(context).buildToolsRow(),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Waktu Dunia',
                        style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.pushNamed(kHomePageAddTimeZone);
                      },
                      icon: Icon(Icons.add, color: kSecondaryTextColor),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kSurfaceColor,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: kSurfaceBorderColor, width: 2),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Asia/Jakarta',
                            style: TextStyle(
                              color: kSecondaryTextColor,
                              fontSize: 24,
                            ),
                          ),
                          Rebuilder(
                            builder: (context) {
                              return Text(
                                getTime('Asia/Jakarta'),
                                style: TextStyle(
                                  color: kPrimaryTextColor,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    ...TimeZoneData.of(context)
                        .locations
                        .mapIndexed(
                          (i, e) => Container(
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              color: kSurfaceColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: kSurfaceBorderColor, width: 2),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e,
                                      style: TextStyle(
                                        color: kSecondaryTextColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Rebuilder(
                                      builder: (context) {
                                        return Text(
                                          getTime(e),
                                          style: TextStyle(
                                            color: kPrimaryTextColor,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )),
                                IconButton(
                                  onPressed: () {
                                    TimeZoneData.of(context).removeLocation(i);
                                  },
                                  icon: Icon(Icons.delete,
                                      color: kSecondaryTextColor),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getTime(String location) {
    tz.TZDateTime time = tz.TZDateTime.fromMillisecondsSinceEpoch(
        tz.getLocation(location), DateTime.now().millisecondsSinceEpoch);
    // format to 24 hour format with seconds
    return time.toString().substring(11, 19);
  }
}
