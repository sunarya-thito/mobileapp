import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/components/glass_pane_text_field.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/user_manager.dart';

class RegisterPasswordPage extends StatefulWidget {
  final String email;
  const RegisterPasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  _RegisterPasswordPageState createState() => _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

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
                  widget.email,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Hero(
            tag: 'password_field',
            child: GlassPaneTextField(
                controller: _password, label: 'Password', obscureText: true),
          ),
          const SizedBox(
            height: 10,
          ),
          Hero(
            tag: 'confirm_password_field',
            child: GlassPaneTextField(
                obscureText: true,
                controller: _confirmPassword,
                label: 'Confirm Password'),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: kSecondaryTextColor,
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                ),
                child: Row(
                  children: [
                    Text('Bukan Email Anda?'),
                  ],
                ),
              ),
              Spacer(),
              Hero(
                tag: 'primary_button',
                child: OutlinedButton(
                  onPressed: () {
                    if (_password.text != _confirmPassword.text) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Password Bermasalah'),
                            content: Text(
                                'Pastikan password dan confirm password sama!'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text('Baiklah'))
                            ],
                          );
                        },
                      );
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (context) {
                          loadingContext = context;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        barrierDismissible: false);
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      UserData.of(context)
                          .register(widget.email, _password.text)
                          .then((value) {
                        loadingContext?.pop();
                        if (value != null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Gagal'),
                                content: Text(value),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: Text('Baiklah'))
                                ],
                              );
                            },
                          );
                          return;
                        }
                        Navigator.popUntil(context, (route) {
                          return route.isFirst;
                        });
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
                      Text('Buat Akun'),
                      const SizedBox(
                        width: 12,
                      ),
                      Icon(Icons.add),
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
