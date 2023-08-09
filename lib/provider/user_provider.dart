import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/users.dart';
import '../presentation/screens/home_page_screen.dart';
import '../presentation/shared_widgets/snackbar.dart';
import '../service/user_firebase.dart';

class UserProvider extends ChangeNotifier {
  String firstName = '';
  String lastName = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> setUser(String newFirstName, String newLastName) async {
    firstName = newFirstName;
    lastName = newLastName;
    notifyListeners();
  }

  Future<UserModel?> getUser(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(userId).get();

    if (snapshot.exists) {
      firstName = snapshot.data()!['first name'] ?? '';
      lastName = snapshot.data()!['last name'] ?? '';
    }
    return null;
  }

  Future<void> setLoading() async {
    _isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> logIn(
      BuildContext context, String email, String password) async {
    String errorMessage = '';

    try {
      setLoading();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = FirebaseAuth.instance.currentUser;
      getUser(user!.uid);
      setLoading();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setLoading();
      if (email.isEmpty || password.isEmpty) {
        errorMessage =
            email.isEmpty ? 'Enter your email' : 'Enter your password';
      }

      if (errorMessage.isNotEmpty) {
        showCustomSnackBar(context, errorMessage);
        return;
      }
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user';
          break;
        case 'invalid-email':
          errorMessage = 'Email incorrect';
          break;
        default:
          errorMessage = 'An error occurred';
          break;
      }
      showCustomSnackBar(context, errorMessage);
    } catch (e) {
      setLoading();
    }
  }

  Future<void> signUp(BuildContext context, String firstName, String lastName,
      String email, String password) async {
    String errorMessage = '';

    try {
      setLoading();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        addUserData(firstName, lastName, user.uid, email);
      }
      getUser(user!.uid);
      setLoading();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setLoading();
      if (firstName.isEmpty || lastName.isEmpty) {
        errorMessage = firstName.isEmpty
            ? 'First name is required'
            : 'Last name is required';
      }

      if (errorMessage.isNotEmpty) {
        showCustomSnackBar(context, errorMessage);
        return;
      }
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'Password must be at least 6 characters';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email';
          break;
        case 'invalid-email':
          errorMessage = 'Email incorrect';
          break;
        default:
          errorMessage = 'An error occurred';
          break;
      }
      showCustomSnackBar(context, errorMessage);
    } catch (e) {
      setLoading();
    }
  }
}
