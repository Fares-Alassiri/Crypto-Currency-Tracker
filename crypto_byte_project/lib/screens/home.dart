import 'package:crypto_byte_project/screens/screen.dart';
import 'package:crypto_byte_project/widgets/my_password_field.dart';
import 'package:crypto_byte_project/widgets/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../constants.dart';

bool isName = false;
bool isEmail = false;
bool isPass = false;
bool passwordVisibility = true;
bool isPError = false;
bool isEError = false;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  String email = '';
  String name = '';

  void getEmail() async {
    email = await FirebaseAuth.instance.currentUser.email;
    setState(() {
      email = email;
      print(email);
    });
  }

  void getName() async {
    name = await FirebaseAuth.instance.currentUser.email.split('@')[0];
    setState(() {
      print(name);
      name = name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
    getName();
    isName = false;
    isEmail = false;
    isPass = false;
    passwordVisibility = true;
    isPError = false;
    isEError = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi ${name.toUpperCase()}",
                            style: kHeadline,
                          ),
                          SizedBox(
                            height: 78,
                          ),
                          SizedBox(
                            height: 2,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                          DetailCard(
                            icon: Icons.email_outlined,
                            data: email,
                            tData: 'email',
                            onTap: () {
                              setState(() {
                                isEmail = !isEmail;
                                isPass = false;
                                print(isEmail);
                              });
                            },
                          ),
                          Container(
                            child: isEmail
                                ? Column(
                                    children: [
                                      MyTextField(
                                        error: isEError
                                            ? 'invalid email address'
                                            : null,
                                        hintText: 'Email',
                                        inputType: TextInputType.emailAddress,
                                        controller: emailController,
                                      ),
                                      RaisedButton(
                                        color: Colors.black,
                                        onPressed: () {
                                          if (emailController.text.length > 3 &&
                                              emailController.text
                                                  .contains('@') &&
                                              emailController.text
                                                      .split('@')[0]
                                                      .length >
                                                  0 &&
                                              emailController.text
                                                      .split('@')[1]
                                                      .length >
                                                  0) {
                                            setState(() {
                                              isEmail = false;
                                              email = emailController.text;
                                              name = emailController.text
                                                  .split('@')[0];
                                            });
                                            FirebaseAuth.instance.currentUser
                                                .updateEmail(emailController
                                                    .text
                                                    .trim());
                                            isEError = false;
                                          } else
                                            setState(() {
                                              isEError = true;
                                            });
                                        },
                                        child: Icon(
                                          Icons.save_alt,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      )
                                    ],
                                  )
                                : null,
                          ),
                          SizedBox(
                            height: 2,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                          DetailCard(
                            icon: Icons.password,
                            data: 'Tap to change your password',
                            tData: 'pass',
                            onTap: () {
                              setState(() {
                                isPass = !isPass;
                                isEmail = false;
                                print(isPass);
                              });
                            },
                          ),
                          Container(
                            child: isPass
                                ? Column(
                                    children: [
                                      MyPasswordField(
                                        error: isPError ? '' : null,
                                        controller: oldpasswordController,
                                        text: 'Old password',
                                        isPasswordVisible: passwordVisibility,
                                        onTap: () {
                                          setState(() {
                                            passwordVisibility =
                                                !passwordVisibility;
                                          });
                                        },
                                      ),
                                      MyPasswordField(
                                        error: isPError
                                            ? 'old or new password is wrong'
                                            : null,
                                        controller: newpasswordController,
                                        text: 'New password',
                                        isPasswordVisible: passwordVisibility,
                                        onTap: () {
                                          setState(() {
                                            passwordVisibility =
                                                !passwordVisibility;
                                          });
                                        },
                                      ),
                                      RaisedButton(
                                        color: Colors.black,
                                        onPressed: () async {
                                          var credential;
                                          var result;
                                          try {
                                            credential =
                                                EmailAuthProvider.getCredential(
                                                    email: FirebaseAuth.instance
                                                        .currentUser.email,
                                                    password:
                                                        oldpasswordController
                                                            .text
                                                            .trim());

                                            result = await FirebaseAuth
                                                .instance.currentUser
                                                .reauthenticateWithCredential(
                                                    credential);
                                          } catch (e) {
                                            setState(() {
                                              isPError = true;
                                            });
                                          }
                                          if (result != null) {
                                            try {
                                              FirebaseAuth.instance.currentUser
                                                  .updatePassword(
                                                      newpasswordController.text
                                                          .trim())
                                                  .catchError(() {
                                                setState(() {
                                                  isPError = true;
                                                  isPass = true;
                                                });
                                              });
                                              print('g');
                                              setState(() {
                                                isPError = false;
                                                isPass = false;
                                              });
                                            } catch (e) {
                                              setState(() {
                                                isPError = true;
                                                isPass = true;
                                              });
                                            }
                                          } else {
                                            print('wrong old');
                                            setState(() {
                                              isPError = true;
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.save_alt,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      )
                                    ],
                                  )
                                : null,
                          ),
                          SizedBox(
                            height: 2,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                          RaisedButton(
                            color: Colors.black,
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              isPError = false;
                              isEError = false;
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignInPage();
                              }));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 70,
                                ),
                                Text(
                                  'Sign Out',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
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

class DetailCard extends StatelessWidget {
  final IconData icon;
  final String data;
  final String tData;
  final VoidCallback onTap;

  DetailCard(
      {required this.icon,
      required this.data,
      required this.tData,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 70,
        ),
        Expanded(
          flex: 1,
          child: Icon(
            this.icon,
            color: Colors.white,
            size: 50,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 10,
          child: Text(
            this.data,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        RaisedButton(
          color: Colors.black,
          onPressed: onTap,
          child: const Expanded(
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
