import 'package:eco_market/pages/landing_page.dart';
import 'package:eco_market/pages/login_page.dart';
import 'package:eco_market/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EcoMarket',
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/landing': (context) => LandingPage(),
        });
  }
}
