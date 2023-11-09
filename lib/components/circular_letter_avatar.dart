import 'dart:math';

import 'package:flutter/material.dart';

class CircularLetterAvatar extends StatefulWidget {
  final String name;

  const CircularLetterAvatar({Key? key, required this.name}) : super(key: key);

  @override
  _CircularLetterAvatarState createState() => _CircularLetterAvatarState();
}

class _CircularLetterAvatarState extends State<CircularLetterAvatar> {
  String get initials {
    String name = widget.name;
    if (name.isEmpty) return '?';
    if (name.length == 1) return name.toUpperCase();
    String first = name.substring(0, 1);
    String second = name.substring(1, 2);
    return first.toUpperCase() + second.toLowerCase();
  }

  Color randomFromName() {
    Random random = Random(widget.name.hashCode);
    int red = 64 + random.nextInt(128);
    int green = 64 + random.nextInt(128);
    int blue = 64 + random.nextInt(128);
    return Color.fromARGB(255, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: Container(
          color: randomFromName(),
          padding: EdgeInsets.all(12),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Text(initials),
          ),
        ),
      ),
    );
  }
}
