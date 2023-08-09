import 'package:flutter/material.dart';
import 'package:project_gt/presentation/shared_widgets/loading_circle.dart';
import 'package:project_gt/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../../routes/app_route.dart';
import '../../routes/navigation.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 249, 249, 249),
          body: Stack(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Image.asset('assets/images/kee_logo.png',
                        width: 150, height: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 50),
                    child: Text(
                      'You need to login to complete the booking process',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Monserrat',
                        color: Color.fromRGBO(50, 62, 72, 1),
                      ),
                      textAlign: TextAlign.center,
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
                              backgroundColor:
                                  Color.fromARGB(255, 41, 123, 230),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              String email = _emailController.text.trim();
                              String password = _passwordController.text.trim();
                              userProvider.logIn(context, email, password);
                            },
                            child: Text(
                              'LOG IN',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Monserrat',
                                fontSize: 16,
                              ),
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
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 50, 62, 72),
                          fontFamily: 'Monserrat',
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigation().pushReplacementNamed(AppRoutes.signUp),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Color.fromARGB(255, 41, 123, 230),
                            fontFamily: 'Monserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            userProvider.isLoading ? LoadingCircle() : SizedBox.fromSize()
          ]));
    });
  }
}
