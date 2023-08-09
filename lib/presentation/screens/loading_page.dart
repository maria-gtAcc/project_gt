import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import '../../routes/navigation.dart';
import '../../routes/app_route.dart';

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
      Navigation().pushReplacementNamed(AppRoutes.home);
      return;
    }
    Provider.of<UserProvider>(context, listen: false).getUser(user.uid);
    Navigation().pushReplacementNamed(AppRoutes.home);
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
