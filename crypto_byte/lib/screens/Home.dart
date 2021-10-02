import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
              child: Column(children: [
            Center(child: Text("Home")),
            RaisedButton(
              onPressed: () {},
              child: Text("sign out"),
            )
          ])),
        ));
  }
}
