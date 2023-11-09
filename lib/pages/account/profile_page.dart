import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/components/buttons.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Halo, apa kabar?'),
          Text(user.displayName ?? user.email ?? user.uid),
          GlassPaneElevatedButton(child: Row(
            children: [
              Expanded(child: Text('Logout')),
              Icon(Icons.logout),
            ],
          ), onPressed: () {
            showDialog(context: context, builder: (context) {
              _loadingContext = context;
              return Center(
                child: CircularProgressIndicator(),
              );
            }, barrierDismissible: true);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              UserData.of(context).logout().then((value) {
                _loadingContext?.pop();
              });
            });
          },)
        ],
      ),
    );
  }
}
