import 'package:eco_market/pages/cart_page.dart';
import 'package:eco_market/pages/add_to_cart.dart';
import 'package:eco_market/pages/congratulation.dart';
import 'package:eco_market/pages/landing_page.dart';
import 'package:eco_market/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eco_market/pages/login_page.dart';
import 'package:eco_market/pages/sign_up_page.dart';
import 'package:eco_market/pages/profile_page.dart';
import 'package:eco_market/pages/landing_page.dart';
import 'package:eco_market/pages/shop_page.dart';
import 'package:eco_market/pages/checkout_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the .env file
  await dotenv.load(fileName: ".env");
  print("API_KEY: ${dotenv.env['API_KEY']}");

  // Initialize Firebase using values from the .env file
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['API_KEY']!,
      authDomain: dotenv.env['AUTH_DOMAIN']!,
      projectId: dotenv.env['PROJECT_ID']!,
      storageBucket: dotenv.env['STORAGE_BUCKET']!,
      messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
      appId: dotenv.env['APP_ID']!,
      measurementId: dotenv.env['MEASUREMENT_ID']!,
    ),
  );

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
        '/profile': (context) => ProfilePage(),
        '/landing': (context) => LandingPage(),
        '/add_to_cart': (context) => AddToCartPage(),
        '/shop': (context) => ShopPage(),
        '/product': (context) => ProductPage(),
        '/cart': (context) => CartPage(),
        '/checkout': (context) => CheckoutPage(),
        '/congratulations': (context) => CongratulationsPage()
      },
    );
  }
}
