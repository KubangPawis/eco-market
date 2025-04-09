import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color(0xFF102F15);

class CongratulationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 124, vertical: 48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Congratulations Text
                    Text(
                      "Congratulations",
                      style: GoogleFonts.poppins(
                        fontSize: 72,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[900],
                      ),
                    ),

                    SizedBox(height: 36),

                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/images/congratulations.png", // Replace with your image asset
                        width: 600,
                        height: 480,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 36),

                    // Message
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "\"You are one purchase closer to an eco-friendly and sustainable future.\"",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                    ),

                    SizedBox(height: 64),

                    // Back to Merchant Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Go back to previous page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding:
                            EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Back to Merchant",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Footer
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // Navigation Bar
  AppBar _buildNavBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 160,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Image.asset('assets/images/app_logo.png', fit: BoxFit.contain),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavItem("Home"),
          _buildNavItem("Store"),
          _buildNavItem("Favorites"),
          _buildNavItem("Orders"),
        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Row(
            children: [
              _buildSearchBar(),
              const SizedBox(width: 10),
              _buildIcon(Icons.person),
              _buildIcon(Icons.menu),
              _buildIcon(Icons.shopping_cart),
            ],
          ),
        ),
      ],
    );
  }

  // Navigation Item
  Widget _buildNavItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Container(
      width: 180,
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 5),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Icon Buttons
  Widget _buildIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: IconButton(
          icon: Icon(icon, color: Colors.black),
          onPressed: () {},
        ),
      ),
    );
  }

  // Footer Section
  Widget _buildFooter(context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      constraints: BoxConstraints(minWidth: 200, maxWidth: 400),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
