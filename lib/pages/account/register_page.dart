import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/components/glass_pane_text_field.dart';
import 'package:mobileapp/main.dart';
import 'package:mobileapp/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        shrinkWrap: true,
        children: [
          Hero(
            tag: 'logo',
            child: Image.asset('assets/MOBILE.png'),
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
                  'Daftar menjadi member baru',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Hero(
            tag: 'email_field',
            child: GlassPaneTextField(controller: _email, label: 'Email'),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.pushReplacementNamed(kLoginPage);
                },
                style: TextButton.styleFrom(
                  foregroundColor: kSecondaryTextColor,
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                ),
                child: Row(
                  children: [
                    Text('Sudah Daftar?'),
                  ],
                ),
              ),
              Spacer(),
              Hero(
                tag: 'primary_button',
                child: OutlinedButton(
                  onPressed: () {
                    if (_email.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Belum Terisi'),
                            content: Text(
                                'Silahkan isi terlebih dahulu email anda!'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text('Baiklah'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    context.pushNamed(kRegisterPasswordPage,
                        queryParameters: {'email': _email.text});
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: kSurfaceColor,
                    foregroundColor: kSecondaryTextColor,
                    side: BorderSide(
                      color: kSurfaceBorderColor,
                      width: 2,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                  ),
                  child: Row(
                    children: [
                      Text('Lanjut'),
                      const SizedBox(
                        width: 12,
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
