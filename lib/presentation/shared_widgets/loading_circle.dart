import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 0.2),
      child: Center(
        child: Container(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
