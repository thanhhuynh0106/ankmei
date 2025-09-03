import 'dart:async';
import 'package:ankmei_app/providers/current_user_store.dart';
import 'package:ankmei_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
    // Timer(const Duration(seconds: 2), () {
    //   Navigator.pushReplacementNamed(context, '/login');
    // });
  }

  Future<void> _bootstrap() async {
    await AuthService.instance.loadFromStorage();
    final isAuthed = CurrentUserStore.instance.isAuthenticated;
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, isAuthed ? '/home' : '/login');
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/hongconen_resized.png",
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    Padding(padding: EdgeInsetsGeometry.all(20)),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      "AnkMei",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "Roboto Medium",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsetsGeometry.only(top: 10)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
