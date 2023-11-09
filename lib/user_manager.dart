import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BodyData {
  final double height;
  final double weight;

  BodyData({
    required this.height,
    required this.weight,
  });
}

class UserManager extends StatefulWidget {
  final Widget child;

  const UserManager({Key? key, required this.child}) : super(key: key);

  @override
  UserManagerState createState() => UserManagerState();
}

class UserManagerState extends State<UserManager> {
  User? user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen(_onUserChange);
  }

  void _onUserChange(User? user) {
    setState(() {
      this.user = user;
    });
  }

  Future<bool> login(String email, String password) async {
    // setState(() {
    //   FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    // });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (mounted) {
        setState(() {});
      }
      return FirebaseAuth.instance.currentUser != null;
    } catch (e) {}
    return false;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      setState(() {});
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'User dengan email tersebut sudah terdaftar';
      } else if (e.code == 'invalid-email') {
        return 'Email tidak valid';
      } else if (e.code == 'weak-password') {
        return 'Password terlalu lemah';
      }
    }
    if (FirebaseAuth.instance.currentUser == null) {
      return 'Terjadi kesalahan';
    }
    if (mounted) {
      setState(() {});
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return UserData(
      user: user,
      state: this,
      child: widget.child,
    );
  }
}

class UserData extends InheritedWidget {
  final User? user;
  final UserManagerState state;

  const UserData({
    Key? key,
    required Widget child,
    required this.user,
    required this.state,
  }) : super(key: key, child: child);

  static UserData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserData>()!;
  }

  Future<String?> register(String email, String password) {
    return state.register(email, password);
  }

  Future<bool> login(String email, String password) {
    return state.login(email, password);
  }

  Future<void> logout() {
    return state.logout();
  }

  @override
  bool updateShouldNotify(UserData oldWidget) {
    return user != oldWidget.user;
  }
}
