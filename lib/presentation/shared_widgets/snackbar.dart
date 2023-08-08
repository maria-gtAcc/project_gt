import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Color(0xFFAE2D3C),
          fontFamily: 'Montserrat',
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: const Color(0xFFEAD5D8),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Color(0xFFAE2D3C),
        ),
      ),
    ),
  );
}
