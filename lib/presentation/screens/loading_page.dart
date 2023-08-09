import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import 'home_page_screen.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    toHome();
  }

  void toHome() async {
    await Future.delayed(Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.delayed(Duration(seconds: 0), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePageScreen()),
        );
      });
      return;
    }
    Future.delayed(Duration(seconds: 0), () {
      Provider.of<UserProvider>(context, listen: false).getUser(user.uid);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePageScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/kee_logo.png', fit: BoxFit.cover),
      ),
    );
  }
}
