import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/components/buttons.dart';
import 'package:mobileapp/main.dart';
import 'package:mobileapp/theme.dart';

class AnonymousProfile extends StatefulWidget {
  const AnonymousProfile({Key? key}) : super(key: key);

  @override
  _AnonymousProfileState createState() => _AnonymousProfileState();
}

class _AnonymousProfileState extends State<AnonymousProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'logo',
            child: Image.asset('assets/MOBILE.png'),
          ),
          const SizedBox(
            height: 32,
          ),
          Hero(
            tag: 'greeting',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Selamat Datang!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Silahkan Login untuk mendapatkan pengalaman yang lebih',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          GlassPaneElevatedButton(
            child: Text('Login'),
            onPressed: () {
              context.pushNamed(kLoginPage);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          GlassPaneElevatedButton(
            child: Text('About'),
            onPressed: () {},
            backgroundColor: Colors.transparent,
          )
        ],
      ),
    );
  }
}
