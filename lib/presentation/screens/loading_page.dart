import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    toHome();
  }

  void toHome() async {
    await Future.delayed(Duration(seconds: 2));

    User? user = _auth.currentUser;

    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
      return;
    }

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(user.uid).get();

    if (snapshot.exists) {
      String firstName = snapshot.data()!['first name'] ?? '';
      String lastName = snapshot.data()!['last name'] ?? '';

      Provider.of<UserProvider>(context, listen: false)
          .setUser(firstName, lastName);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePageScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading'),
      ),
    );
  }
}
