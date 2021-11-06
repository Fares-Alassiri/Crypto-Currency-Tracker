import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Here we will put favorite page, in 4th sprint',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
