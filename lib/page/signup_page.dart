import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscureText = true;
  bool _obscureTextConfirm = true;


  void _checkPasswordValidation() {

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
                  // Image.asset(
                  //   "assets/hongconen_resized.png",
                  //   width: MediaQuery.of(context).size.width * 0.5,
                  // ),
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
                            // Handle sign up logic here
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
                      // Text(
                      //   textAlign: TextAlign.center,
                      //   "By signing up, you agree to our Terms & Conditions",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey,
                      //     fontWeight: FontWeight.w300,
                        
                      //   ),
                      // ),
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
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: IconButton(
                              icon: Image.asset("assets/google.png"),
                              iconSize: 20,
                              onPressed: () {
                                // Handle Google sign up logic here
                              },
                            ),
                          ),
                          SizedBox(width: 40),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: IconButton(
                              icon: Image.asset("assets/facebook.png"),
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
