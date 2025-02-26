import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('EcoMarket',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
      ),
      bottomNavigationBar: BottomAppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LOGIN SPLASH IMAGE
            Image.asset('assets/images/login_splash.png',
                width: 600, height: 500),

            // SPACER
            SizedBox(
              width: 400,
            ),

            // LOGIN FORM
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Log In',
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
                SizedBox(
                  width: 800,
                  child: TextFormField(
                    decoration: InputDecoration(
                      //labelText: 'Enter your name',
                      border: OutlineInputBorder(),
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
                SizedBox(
                  width: 800,
                  child: TextFormField(
                    decoration: InputDecoration(
                      //labelText: 'Enter your password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                ),

                SizedBox(height: 20),

                Column(
                  children: [
                    //LOG IN BUTTON
                    SizedBox(
                      width: 600,
                      height: 50,
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
                          'LOG IN',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),

                    //SIGN UP BUTTON
                    SizedBox(height: 10),
                    SizedBox(
                      width: 600,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.all(15),
                        ),
                        child: Text(
                          'SIGN UP',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
