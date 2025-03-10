import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eco_market/services/auth.dart'; // Make sure this file contains your Firebase Auth logic

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for the text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Instance of AuthService to handle authentication
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Function to handle account creation
  Future<void> _createAccount() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Check if passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      // Call signUp method from AuthService
      final user = await _authService.signUp(email, password);
      print('User signed up: ${user?.email}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      // Optionally, navigate to another page after sign up
    } catch (e) {
      print('Sign up error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed: $e')),
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
            // Sign Up Splash Image
            Image.asset('assets/images/sign_up_splash.png', width: 600, height: 500),

            // Spacer
            const SizedBox(width: 50),

            // Sign Up Form
            Flexible(
<<<<<<< HEAD
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
=======
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // EMAIL TEXT FIELD
                  SizedBox(height: 20),
                  Text(
                    'EMAIL',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 800,
                      child: TextFormField(
                        decoration: InputDecoration(
                          //labelText: 'Enter your name',
                          border: OutlineInputBorder(),
                        ),
>>>>>>> 56e41fa8bd4f3e270a57b8b183c42b25f81208af
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Email Text Field
                    Text(
                      'EMAIL',
                      style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 20)),
                    ),
<<<<<<< HEAD
                    SizedBox(
                      width: 800,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
=======
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 800,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
>>>>>>> 56e41fa8bd4f3e270a57b8b183c42b25f81208af
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Password Text Field
                    Text(
                      'PASSWORD',
                      style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 20)),
                    ),
<<<<<<< HEAD
                    SizedBox(
                      width: 800,
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
=======
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 800,
                      child: TextFormField(
                        decoration: InputDecoration(
>>>>>>> 56e41fa8bd4f3e270a57b8b183c42b25f81208af
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ),
<<<<<<< HEAD
                    const SizedBox(height: 10),
                    // Confirm Password Text Field
                    Text(
                      'CONFIRM PASSWORD',
                      style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      width: 800,
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 700,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // CREATE ACCOUNT BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: _createAccount,
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: Colors.yellow,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.all(15),
                              ),
                              child: Text(
                                'CREATE ACCOUNT',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
=======
                  ),

                  // BUTTON GROUP
                  SizedBox(height: 20),
                  SizedBox(
                    width: 800,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //LOG IN BUTTON
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: FractionallySizedBox(
                              widthFactor: 0.8,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: Colors.yellow,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.all(15),
                                ),
                                child: Text(
                                  'CREATE ACCOUNT',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )),
                        ),

                        //SIGN UP BUTTON
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: FractionallySizedBox(
                                widthFactor: 0.8,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: Colors.black, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.all(15),
                                  ),
                                  child: Text(
                                    'BACK TO LOGIN',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
>>>>>>> 56e41fa8bd4f3e270a57b8b183c42b25f81208af
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // BACK TO LOGIN BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/login');
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
                                'BACK TO LOGIN',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
