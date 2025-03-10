import 'package:eco_market/pages/login_page.dart';
import 'package:eco_market/pages/profile_page.dart';
import 'package:eco_market/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase manually with your config
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyB8QHrWMHJIrjeb3eokI3IGSG8uqKaYFh8",
      authDomain: "ecomarket-60acd.firebaseapp.com",
      projectId: "ecomarket-60acd",
      storageBucket: "ecomarket-60acd.firebasestorage.app",
      messagingSenderId: "909870506837",
      appId: "1:909870506837:web:a2be61c3fd1268387585dc",
      measurementId: "G-0TK03F8FLK",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
        title: 'EcoMarket',
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/profile': (context) => ProfilePage()
        });
=======
      title: 'EcoMarket',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
      },
    );
>>>>>>> a8c9abf3869fe62f2fc4ec2842ccac15996cbd23
  }
}
