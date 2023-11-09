import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/components/body_data_chart.dart';
import 'package:mobileapp/components/buttons.dart';
import 'package:mobileapp/components/circular_letter_avatar.dart';
import 'package:mobileapp/main.dart';
import 'package:mobileapp/pages/account/anonymous_profile.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/user_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  BuildContext? _loadingContext;
  @override
  Widget build(BuildContext context) {
    var user = UserData.of(context).user;
    if (user == null) {
      return AnonymousProfile();
    }
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(bottom: 64),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 64,
                    child: CircularLetterAvatar(
                        name: user.displayName ?? user.email ?? user.uid),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Halo, apa kabar?'),
                        Text(user.displayName ?? user.email ?? user.uid,
                            style: TextStyle(fontSize: 28),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 64),
                  child: BodyDataChart(),
                ),
              ),
              GlassPaneElevatedButton(
                child: Row(
                  children: [
                    Expanded(child: Text('About')),
                    Icon(Icons.info_outline),
                  ],
                ),
                backgroundColor: Colors.transparent,
                onPressed: () {
                  context.pushNamed(kDeveloperPage);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              GlassPaneElevatedButton(
                child: Row(
                  children: [
                    Expanded(child: Text('Logout')),
                    Icon(Icons.logout),
                  ],
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        _loadingContext = context;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      barrierDismissible: true);
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    UserData.of(context).logout().then((value) {
                      _loadingContext?.pop();
                    });
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
