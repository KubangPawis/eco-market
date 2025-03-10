import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              child: Image.asset('assets/images/app_logo.png',
                  fit: BoxFit.contain)),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomAppBar(
          color: Color.fromARGB(255, 16, 47, 21),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LOGIN SPLASH IMAGE
            Image.asset('assets/images/sign_up_splash.png',
                width: 600, height: 500),

            // SPACER
            SizedBox(
              width: 50,
            ),

            // LOGIN FORM
            Flexible(
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ),

                  // CONFIRM PASSWORD TEXT FIELD
                  SizedBox(height: 10),
                  Text(
                    'CONFIRM PASSWORD',
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
            )
          ],
        ),
      ),
    );
  }
}
