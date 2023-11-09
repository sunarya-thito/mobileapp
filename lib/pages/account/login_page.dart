import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/components/glass_pane_text_field.dart';
import 'package:mobileapp/main.dart';
import 'package:mobileapp/theme.dart';

import '../../user_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  BuildContext? loadingContext;

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
                  'Silahkan Login untuk mendapatkan pengalaman yang lebih',
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
            height: 10,
          ),
          Hero(
            tag: 'password_field',
            child: GlassPaneTextField(
                obscureText: true, controller: _password, label: 'Password'),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.pushReplacementNamed(kRegisterPage);
                },
                style: TextButton.styleFrom(
                  foregroundColor: kSecondaryTextColor,
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                ),
                child: Row(
                  children: [
                    Text('Belum Daftar?'),
                  ],
                ),
              ),
              Spacer(),
              Hero(
                tag: 'primary_button',
                child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        loadingContext = context;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      UserData.of(context)
                          .login(_email.text, _password.text)
                          .then((value) {
                        loadingContext?.pop();
                        if (!value) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Gagal Login'),
                                content: Text('User atau Password salah'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: Text('Baiklah'),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      });
                    });
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
                      Text('Login'),
                      const SizedBox(
                        width: 12,
                      ),
                      Icon(Icons.login),
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
