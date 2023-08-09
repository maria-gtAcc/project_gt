import 'package:flutter/material.dart';

import '../../routes/app_route.dart';
import '../../routes/navigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigation().pushReplacementNamed(AppRoutes.home);
          },
        ),
      ),
    );
  }
}
