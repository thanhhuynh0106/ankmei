import 'dart:convert';
import 'package:ankmei_app/env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void registerUser() async {
    debugPrint('DEBUG: username = \'${_usernameController.text}\'');
    debugPrint('DEBUG: email = \'${_emailController.text}\'');
    debugPrint('DEBUG: password = \'${_passwordController.text}\'');
    debugPrint('DEBUG: confirmPassword = \'${_confirmPasswordController.text}\'');

    if (_passwordController.text != _confirmPasswordController.text) {
      debugPrint('DEBUG: Password and Confirm Password do not match');
      _confirmDialog(context, "Password and confirm password do not match!?");
      return;
    }

    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      debugPrint('DEBUG: One or more fields are empty');
      _confirmDialog(context, "Please fill in all fields!?");
      return;
    }

    var registerBody = {
      "username": _usernameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
    };
    debugPrint('DEBUG: registerBody = $registerBody');

    var url = Uri.parse('${Env.apiUrl}/auth/register');
    debugPrint('DEBUG: POST url = $url');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(registerBody),
    );
    debugPrint('DEBUG: response.statusCode = ${response.statusCode}');
    debugPrint('DEBUG: response.body = ${response.body}');

    if (response.statusCode == 201) {
      debugPrint('DEBUG: Registration successful, showing loading spinner and navigating to login page after 5 seconds');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: const ModalBarrier(dismissible: false, color: Color.fromARGB(255, 121, 121, 121)),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ],
          );
        },
      );
      await Future.delayed(Duration(seconds: 4));
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushNamed(context, '/home');
      }
    } else {
      debugPrint('DEBUG: Registration failed, showing dialog');
      String errorMsg = 'Registration failed';
      try {
        var body = jsonDecode(response.body);
        if (body is Map && body['message'] != null) {
          errorMsg = body['message'].toString();
        } else if (body is String) {
          errorMsg = body;
        }
      } catch (e) {
        errorMsg = response.body;
      }
      _confirmDialog(context, errorMsg);
    }
  }

  Future<DateTime?> _confirmDialog(BuildContext context, String content) {
    return showDialog<DateTime>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.all(0.0),
            title: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.0457),
              child: Center(
                child: Text(
                  content,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
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
                child: Text("Return"),
              ),
            ],
          );
        });
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              height: MediaQuery.of(context).size.height * 0.76,
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
                  SizedBox(height: 30),
                  Text(
                    "Create an account to keep memories unforgettable!!!\n/ᐠ˵- ⩊ -˵マ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(154, 180, 237, 1),
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: "Enter your username",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                          labelStyle: TextStyle(fontWeight: FontWeight.w400),
                          contentPadding: EdgeInsets.only(left: 5),
                          floatingLabelStyle: TextStyle(
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
                      SizedBox(height: 15),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: "Enter your email",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                          labelStyle: TextStyle(fontWeight: FontWeight.w400),
                          contentPadding: EdgeInsets.only(left: 5),
                          floatingLabelStyle: TextStyle(
                            color: Color.fromRGBO(102, 141, 225, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "Roboto Medium",
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Color.fromRGBO(184, 207, 255, 1),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: "Enter your password",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                          labelStyle: TextStyle(fontWeight: FontWeight.w400),
                          contentPadding: EdgeInsets.only(left: 5),
                          floatingLabelStyle: TextStyle(
                            color: Color.fromRGBO(102, 141, 225, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "Roboto Medium",
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Color.fromRGBO(184, 207, 255, 1),
                          suffixIcon: IconButton( 
                            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                            onPressed:() {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }, 
                          ),
                          suffixIconColor: Color.fromRGBO(184, 207, 255, 1),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureTextConfirm,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: "Re-enter your password",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                          labelStyle: TextStyle(fontWeight: FontWeight.w400),
                          contentPadding: EdgeInsets.only(left: 5),
                          floatingLabelStyle: TextStyle(
                            color: Color.fromRGBO(102, 141, 225, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "Roboto Medium",
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Color.fromRGBO(184, 207, 255, 1),
                          suffixIcon: IconButton(
                            onPressed:() {
                              setState(() {
                                _obscureTextConfirm = !_obscureTextConfirm;
                              });
                            },
                            icon: Icon(_obscureTextConfirm ? Icons.visibility : Icons.visibility_off)
                          ),
                          suffixIconColor: Color.fromRGBO(184, 207, 255, 1)
                        ),
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            registerUser();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(102, 141, 225, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(height: 10),
                      Text(
                        "Or sign up with",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   width: 50,
                          //   height: 50,
                          //   child: IconButton(
                          //     icon: Image.asset("assets/google.png"),
                          //     iconSize: 20,
                          //     onPressed: () {
                          //       // Handle Google sign up logic here
                          //     },
                          //   ),
                          // ),
                          // SizedBox(width: 40),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: IconButton(
                              icon: Image.asset("assets/github.png"),
                              iconSize: 20,
                              onPressed: () {
                                // Handle Facebook sign up logic here
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      TextButton(
                        onPressed:() {
                          Navigator.pushNamed(context, '/login');
                        } 
                      , child: Text(
                        "Already have an account? Log in",
                        style: TextStyle(
                          color: Color.fromRGBO(102, 141, 225, 1),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                      )
                    ],
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
