import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/components/time_zone_manager.dart';
import 'package:mobileapp/theme.dart';
import 'package:timezone/timezone.dart' as tz;

class AddTimeZone extends StatefulWidget {
  const AddTimeZone({Key? key}) : super(key: key);

  @override
  _AddTimeZoneState createState() => _AddTimeZoneState();
}

class _AddTimeZoneState extends State<AddTimeZone> {
  final TextEditingController _controller = TextEditingController(); // search

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Tambah Zona Waktu',
          ),
          backgroundColor: kBackgroundColor,
          elevation: 0,
          toolbarHeight: 90,
          surfaceTintColor: kBackgroundColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Cari lokasi',
                  hintStyle: TextStyle(
                    color: kSecondaryTextColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 18,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: kSecondaryTextColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: kSurfaceBorderColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: kSurfaceBorderColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: kSurfaceBorderColor,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: kSurfaceColor,
                ),
              ),
            ),
          )),
      backgroundColor: kBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        children: tz.timeZoneDatabase.locations.values
            .where((element) {
              String query = _controller.text.toLowerCase();
              if (query.isEmpty) {
                return true;
              }
              return element.name.toLowerCase().contains(query);
            })
            .sortedBy((e) => e.toString())
            .mapIndexed((i, e) {
              var listTile = ListTile(
                title: Text(e.toString()),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: kSurfaceBorderColor,
                    width: 2,
                  ),
                ),
                tileColor: kSurfaceColor,
                onTap: () {
                  TimeZoneData.of(context).addLocation(e.name);
                  Navigator.pop(context, e);
                },
              );
              if (i > 0) {
                return Column(
                  children: [
                    const SizedBox(height: 8),
                    listTile,
                  ],
                );
              }
              return listTile;
            })
            .toList(),
      ),
    );
  }
}
