import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import '../screens/home_page_screen.dart';
import '../screens/login_page.dart';
import '../screens/profile_page.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    bool isLoggedIn = _auth.currentUser != null;
    User? currentUser = _auth.currentUser;

    String userName = isLoggedIn
        ? userProvider.firstName.isNotEmpty
            ? '${userProvider.firstName} ${userProvider.lastName}'
            : currentUser!.displayName ?? 'Guest'
        : 'Guest';
    String userEmail = currentUser?.email ?? 'guest@example.com';

    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            userName,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          accountEmail: Text(
            userEmail,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                'https://cdn.imgbin.com/15/10/13/imgbin-computer-icons-user-profile-avatar-profile-LJbrar10nYY8mYWt0CUXZ8CxE.jpg',
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
          ),
          decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1.0)),
            image: DecorationImage(
              image: AssetImage('assets/images/logo_image.png'),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          ),
        ),
        if (!isLoggedIn)
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            ),
          )
        else
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              _auth.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePageScreen()),
                (route) => false,
              );
            },
          ),
      ]),
    );
  }
}
