import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/screen.dart';
import '../widgets/my_password_field.dart';
import '../widgets/my_text_field.dart';
import 'Home.dart';

HomePage p = HomePage();

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        //to make page scrollable
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back.",
                            style: kHeadline,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "You've been missed!",
                            style: kBodyText2,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          // TextField(
                          //   controller: emailController,
                          //   decoration: InputDecoration(labelText: "Email"),
                          // ),
                          MyTextField(
                            controller: emailController,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          MyPasswordField(
                            controller: passwordController,
                            title: 'Enter your password',
                            isPasswordVisible: isPasswordVisible,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont't have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: kBodyText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("sign in"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
