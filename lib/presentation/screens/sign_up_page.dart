import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../service/user_firebase.dart';
import 'home_page_screen.dart';
import 'login_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future signUp() async {
    String firsName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      addUserData(firsName.trim(), lastName.trim(), user.uid, email.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 249, 249, 249),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 80, 0, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Monserrat',
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(50, 62, 72, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          hintText: 'First Name',
                          labelText: 'First Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          hintText: 'Last Name',
                          labelText: 'Last Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          hintText: 'Email',
                          labelText: 'Email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          hintText: 'Password',
                          labelText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 41, 123, 230),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          signUp();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageScreen()));
                        },
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Monserrat',
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Color.fromARGB(255, 50, 62, 72),
                        fontFamily: 'Monserrat',
                        fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'LOG IN',
                      style: TextStyle(
                          color: Color.fromARGB(255, 41, 123, 230),
                          fontFamily: 'Monserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
