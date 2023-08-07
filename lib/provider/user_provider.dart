import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String firstName = '';
  String lastName = '';

  void setUser(String newFirstName, String newLastName) {
    firstName = newFirstName;
    lastName = newLastName;
    notifyListeners();
  }
}
