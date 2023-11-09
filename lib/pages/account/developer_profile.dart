import 'package:flutter/material.dart';
import 'package:mobileapp/theme.dart';

class DeveloperProfile extends StatefulWidget {
  const DeveloperProfile({Key? key}) : super(key: key);

  @override
  _DeveloperProfileState createState() => _DeveloperProfileState();
}

class _DeveloperProfileState extends State<DeveloperProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Developer'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 96,
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 32, right: 32, bottom: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                height: 200,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipOval(
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset('assets/profile.jpg'))),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Thito Yalasatria Sunarya',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('NRP: 152021083', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
