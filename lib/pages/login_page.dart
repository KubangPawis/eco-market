import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eco_market/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toastification/toastification.dart';

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

  String _getFirebaseAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already associated with another account.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';
      case 'weak-password':
        return 'The password is too weak. Try a stronger one.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  // Function to handle login
  Future<void> _login(BuildContext context) async {
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();

  try {
      // Call signIn method from AuthService
    final user = await _authService.signIn(email, password);

      // Ensure widget is still in the widget tree
      if (!context.mounted) return;

      // Disimiss existing toasts
      toastification.dismissAll();

      toastification.show(
        context: context,
        title: Text('Login Successful!'),
        description: Text('Welcome back! Redirecting...'),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        alignment: Alignment.bottomRight,
        autoCloseDuration: Duration(seconds: 3),
        showProgressBar: false,
      );
      await Future.delayed(Duration(milliseconds: 500));
      Navigator.pushReplacementNamed(context, '/landing');

      // Optionally, navigate to another page after login
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFirebaseAuthErrorMessage(e.code);

      // Ensure widget is still mounted before showing toast
      if (!context.mounted) return;

      // Disimiss existing toasts
      toastification.dismissAll();

      // Error Toast
      toastification.show(
        context: context,
        title: Text('Login Failed!'),
        description: Text(errorMessage),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        alignment: Alignment.bottomRight,
        autoCloseDuration: Duration(seconds: 3),
        showProgressBar: false,
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
            child:
                Image.asset('assets/images/app_logo.png', fit: BoxFit.contain),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 30,
                  children: [
                    // LOGIN SPLASH IMAGE
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/login_splash.png',
                          width: 600, height: 500),
                    ),

                    // SPACER
                    SizedBox(
                      width: 50,
                    ),

                    // LOGIN FORM
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Log In',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
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
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),

                          // PASSWORD TEXT FIELD
                          SizedBox(height: 10),
                          Text(
                            'PASSWORD',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: SizedBox(
                              width: 800,
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),

                          // BUTTON GROUP
                          SizedBox(height: 20),
                          SizedBox(
                            width: 800,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //LOG IN BUTTON
                                Padding(
                                  padding: EdgeInsets.only(right: 16.0),
                                  child: FractionallySizedBox(
                                      widthFactor: 0.8,
                                      child: TextButton(
                                        onPressed: () {
                                          _login(context);
                                        },
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          backgroundColor: Colors.yellow,
                                          foregroundColor: Colors.black,
                                          padding: EdgeInsets.all(15),
                                        ),
                                        child: Text(
                                          'LOG IN',
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
                                                context, '/signup');
                                          },
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                color: Colors.black, width: 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            foregroundColor: Colors.black,
                                            padding: EdgeInsets.all(15),
                                          ),
                                          child: Text(
                                            'SIGN UP',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // FOOTER
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 16, 47, 21),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 64, vertical: 80),
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 30,
                    runSpacing: 50,
                    children: [
                      // COLUMN 1
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minWidth: 200, maxWidth: 400),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('EcoMarket',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 55,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                            ),
                            SizedBox(height: 40),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Subscribe to our newsletter',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 24, color: Colors.white),
                                    )),
                                SizedBox(height: 20),

                                // NEWSLETTER EMAIL INPUT TEXT FIELD
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth: 700, maxWidth: 700),
                                  child: TextFormField(
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.63)),
                                      ),
                                      contentPadding: EdgeInsets.all(15),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            backgroundColor: Colors.yellow,
                                            foregroundColor: Colors.black,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                          ),
                                          child: Text(
                                            'Subscribe',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      border: OutlineInputBorder()),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                    'Subscribe to our newsletter to be the first to know about news and offers',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.63)),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 120,
                        runSpacing: 50,
                        children: [
                      // COLUMN 2
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quick Links',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )),

                              // SPACER
                              SizedBox(
                                height: 25,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Home',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('About Us',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('Menu',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('Blog',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('Deals',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                ],
                              ),
                            ],
                          ),

                      // COLUMN 3
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Neighbors We Serve',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )),

                              // SPACER
                              SizedBox(
                                height: 25,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Lucena',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('Tayabas',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('Candelaria',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('Sariaya',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('Lucban',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('Tiaong',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('Pagbilao',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('Padre Burgos',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Text('San Pablo',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                ],
                              ),
                            ],
                          ),

                      // COLUMN 4
                          Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // HOURS OF OPERATION
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hours of Operation',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )),

                                // SPACER
                                SizedBox(
                                  height: 25,
                                ),

                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  children: [
                                    Text('Open Daily',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        )),
                                    Text('Mon-Sun (9:00am - 5:00pm)',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ))
                                  ],
                                ),
                              ],
                            ),

                            // SPACER
                            SizedBox(
                              height: 50,
                            ),

                            // OUR VISTA LOCATION
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Our Vista Location',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )),

                                // SPACER
                                SizedBox(
                                  height: 25,
                                ),

                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '10171 Synamore Ave. Vista St. CA 92081',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
