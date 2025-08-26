import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontFamily: "Roboto Medium",
          fontSize: MediaQuery.of(context).size.width * 0.05,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}