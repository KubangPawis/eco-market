import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eco_market/services/auth.dart'; // Make sure this file contains your Firebase Auth logic

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for the text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Instance of AuthService to handle authentication
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to handle login
  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // Call signIn method from AuthService
      final user = await _authService.signIn(email, password);
      print('User logged in: ${user?.email}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged in successfully!')),
      );
      // Optionally, navigate to another page after login
    } catch (e) {
      print('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 30,
            child: Image.asset('assets/images/app_logo.png', fit: BoxFit.contain),
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomAppBar(
          color: const Color.fromARGB(255, 16, 47, 21),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LOGIN SPLASH IMAGE
            Image.asset('assets/images/login_splash.png', width: 600, height: 500),
            const SizedBox(width: 50),
            // LOGIN FORM
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log In',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'EMAIL',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 800,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'PASSWORD',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 800,
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 800,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // LOG IN BUTTON
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: TextButton(
                              onPressed: _login,
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: Colors.yellow,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.all(15),
                              ),
                              child: Text(
                                'LOG IN',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // SIGN UP BUTTON
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/signup');
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.black, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.all(15),
                              ),
                              child: Text(
                                'SIGN UP',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
