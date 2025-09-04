import 'package:ankmei_app/page/home_page.dart';
import 'package:ankmei_app/page/loading_page.dart';
import 'package:ankmei_app/page/login_page.dart';
import 'package:ankmei_app/page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AnkMei",
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: const Color.fromARGB(255, 225, 139, 168),
        //   primary: const Color(0xFF00BFFF),
        //   secondary: const Color(0xFF1E90FF),
        // ),
        textTheme: TextTheme(
          displayMedium: TextStyle(
            fontFamily: "Roboto Medium",
          ),
          headlineMedium: TextStyle(
            fontFamily: "Roboto Medium",
          ),
          bodyMedium: TextStyle(
            fontFamily: "Roboto Medium",
          ),
          titleMedium: TextStyle(
            fontFamily: "Roboto Medium",
          ),
          labelMedium: TextStyle(
            fontFamily: "Roboto Medium",
          ),
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      }
    );
  }
}