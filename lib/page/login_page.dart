import 'dart:convert';

import 'package:ankmei_app/env.dart';
import 'package:ankmei_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<DateTime?> _confirmDialog(BuildContext context, String content) {
    return showDialog<DateTime>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            titlePadding: EdgeInsets.all(0.0),
            title: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.0457),
              child: new Center(
                child: new Text(
                  content,
                  textAlign: TextAlign.justify,
                  style: new TextStyle(
                      color: Colors.black,
                      height: 1.5,
                      fontFamily: "Roboto Medium",
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Return"),
              ),
            ],
          );
        });
  }


  void loginUser() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _confirmDialog(context, "Please fill in all fields!? ");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: const ModalBarrier(dismissible: false, color: Color.fromARGB(255, 218, 218, 218)),
            ),
            Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );

    final ok = await AuthService.instance.login(
      username: _usernameController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop();

    if (ok) {
      Navigator.pushNamed(context, '/home');
    } else {
      _confirmDialog(context, "Login failed!? Please check your credentials.");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 168, 168, 1),
                  Color.fromRGBO(184, 207, 255, 1),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.82,
              height: MediaQuery.of(context).size.height * 0.73,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/hongconen_resized.png",
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        Text(
                          "Dive into memories ₍^ >ヮ<^₎",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromRGBO(154, 180, 237, 1),
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 40),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: "Username",
                            hintText: "Enter your username",
                            hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.only(left: 5),
                            floatingLabelStyle: TextStyle(
                              // color: Color.fromRGBO(255, 168, 168, 1),
                              color: Color.fromRGBO(102, 141, 225, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: "Roboto Medium",
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(Icons.person),
                            prefixIconColor: Color.fromRGBO(184, 207, 255, 1),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter your password",
                            hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.only(left: 5),
                            floatingLabelStyle: TextStyle(
                              // color: Color.fromRGBO(255, 168, 168, 1),
                              color: Color.fromRGBO(102, 141, 225, 1),
                              fontFamily: "Roboto Medium",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            prefixIconColor: Color.fromRGBO(184, 207, 255, 1),
                          ),
                        ),
                        // SizedBox(height: 20),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       child: TextField(
                        //         decoration: InputDecoration(
                        //           labelText: "Captcha",
                        //           hintText: "Enter captcha",
                        //           hintStyle: TextStyle(
                        //             fontSize: 15,
                        //             fontWeight: FontWeight.w300,
                        //           ),
                        //           labelStyle: TextStyle(
                        //             fontWeight: FontWeight.w400,
                        //           ),
                        //           contentPadding: EdgeInsets.only(left: 5),
                        //           floatingLabelStyle: TextStyle(
                        //             // color: Color.fromRGBO(255, 168, 168, 1),
                        //             color: Color.fromRGBO(102, 141, 225, 1),
                        //             fontFamily: "Roboto Medium",
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //           border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(30),
                        //           ),
                        //           prefixIcon: Icon(Icons.verified_user),
                        //           prefixIconColor: Color.fromRGBO(
                        //             184,
                        //             207,
                        //             255,
                        //             1,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 10),
                        //     Image.asset(
                        //       "assets/captcha_ph.png",
                        //       width: MediaQuery.of(context).size.width * 0.25,
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 30),
                        SizedBox(
                          height: 50,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                loginUser();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(
                                  134,
                                  146,
                                  247,
                                  1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Roboto Medium",
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Or login with",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: "Roboto Medium",
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //   width: 50,
                            //   height: 50,
                            //   child: IconButton(
                            //     icon: Image.asset("assets/google.png"),
                            //     onPressed: () {
                            //       // Handle Google login logic here
                            //     },
                            //   ),
                            // ),
                            // SizedBox(width: 40),
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                icon: Image.asset("assets/github.png"),
                                onPressed: () {
                                  // Handle Facebook login logic here
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                onPressed: () {
                                  // Handle forgot password logic here
                                },
                                child: Text(
                                  "Forgot password",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(102, 141, 225, 1),
                                    fontFamily: "Roboto Medium",
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: Text(
                                  "Create new account",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(102, 141, 225, 1),
                                    fontFamily: "Roboto Medium",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
