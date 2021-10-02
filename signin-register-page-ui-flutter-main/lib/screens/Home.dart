import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/authentication_service.dart';
import 'package:provider/provider.dart';



class HomePage extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Center(child: Text("Home")),
              RaisedButton(
                onPressed: (){
                  context.read<AuthenticationService>().signOut();
                },
                child: Text ("sign out"),
              )
            ]
          )
        ),
      )
    );
  }


}

