import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_market/pages/shop_page.dart';
import 'package:eco_market/pages/cart_page.dart';
import 'package:eco_market/pages/profile_page.dart';

Color primaryColor = Color(0xFF102F15);
Color accentColor = Color(0xFFFCDC1A);

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    // Custom color palette
    const Color primaryGreen = Color(0xFF74B72E);
    const Color darkGreen = Color(0xFF2B7A0B);
    const Color lightGreen = Color(0xFFA7D129);
    const Color appGreen = Color(0xFF102F15);
    const Color appGreen1 = Color(0xFF728C5A);
    const Color carouselGreen = Color(0xFFE5F5D6);

    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.1; // Adjust title size dynamically

    return Scaffold(
      appBar: AppBar(
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
                _buildIcon(context, Icons.person),
                _buildIcon(context, Icons.menu),
                _buildIcon(context, Icons.shopping_cart),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1200,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // =======================
                  // ROW 1: HERO IMAGE
                  // =======================
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 700,
                      child: Image.asset(
                        'assets/images/hero_background.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // =======================
                  // ROW 2: WHITE SECTION (3 COLUMNS)
                  // =======================
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(64),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // COLUMN 1: Left Image (Colored Vegetables)
                          Flexible(
                            flex: 3,
                            child: _resizableRoundedImage(
                                'assets/images/tomatoes.png', 396, 430),
                          ),
                          const SizedBox(width: 16),
                          // COLUMN 2: Center Image (Grayscale Market Scene)
                          Flexible(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 40),
                                _resizableRoundedImage(
                                  'assets/images/banana.png',
                                  250,
                                  430,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 64),
                          // COLUMN 3: Text Content
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'WELCOME TO',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),

                                  //SPACER
                                  SizedBox(height: 8),

                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'The \nEcoMarket',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: appGreen,
                                          fontSize: titleFontSize.clamp(36, 96),
                                          fontWeight: FontWeight.w600,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ),

                                  //SPACER
                                  SizedBox(height: 60),

                                  ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black87,
                                          height: 1.8,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Eco',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Market',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                color: appGreen1,
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' is your go-to platform for eco-friendly and sustainable products. Discover a wide range of items that prioritize the planet, from reusable essentials to organic goods. Shop with purpose and make a positive impact on the environment.',
                                            style: GoogleFonts.poppins(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ================
            // ABOUT US SECTION
            // ================
            Container(
              padding: const EdgeInsets.only(bottom: 70),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    "ABOUT US",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "We Offer",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _categoryItem(context, Icons.fastfood, "Food"),
                      _categoryItem(context, Icons.spa, "Skincare"),
                      _categoryItem(context, Icons.checkroom, "Clothes"),
                      _categoryItem(context, Icons.shopping_bag, "Accessories"),
                      _categoryItem(context, Icons.chair, "Furniture"),
                    ],
                  ),
                ],
              ),
            ),
            // =======================
            // PRODUCTS CAROUSEL SECTION (from Firestore)
            // =======================
            Column(
              children: [
                SizedBox(
                  height: 1400,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // =======================
                      // ROW 1: FILLER IMAGE
                      // =======================
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 900,
                          child: Image.asset(
                            'assets/images/pineapple.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // =======================
                      // ROW 2: PRODUCT CAROUSEL
                      // =======================
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 80, horizontal: 24),
                          decoration: BoxDecoration(
                            color:
                                carouselGreen, // Matches reference design background
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 16),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('products')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (!snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty) {
                                    return const Center(
                                        child: Text('No products available.'));
                                  }

                                  final products =
                                      snapshot.data!.docs.map((doc) {
                                    return doc.data() as Map<String, dynamic>;
                                  }).toList();

                                  return Column(
                                    children: [
                                      // FAVORITE PRODUCTS - TITLE SECTION
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 92,
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "PRODUCTS",
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                "Our Favorite Products",
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 56,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // CAROUSEL
                                      SizedBox(
                                        width: 1200,
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            height: 320,
                                            enableInfiniteScroll: true,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                const Duration(seconds: 4),
                                            viewportFraction: 0.3,
                                            enlargeCenterPage: false,
                                            scrollPhysics:
                                                const BouncingScrollPhysics(),
                                          ),
                                          items: products.map((product) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: _buildShopItemCard(
                                                  context: context, productData: product),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      const SizedBox(height: 24),

                                      // ALL PRODUCTS BUTTON
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 32,
                                          right: 48,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: ()
                                            {
                                              Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => const ShopPage()),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        "Viewing all products!")),
                                                        
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: accentColor,
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding: EdgeInsets.all(15),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "All Products",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                                ),
                                                SizedBox(width: 8),
                                                Icon(
                                                  Icons.arrow_forward_outlined,
                                                  color: Colors.black,
                                                  size: 32,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // =======================
            // BADGES & FAQ SECTION
            // =======================
            Container(
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 80),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge Section
                  Padding(
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          5,
                          (index) => Image.asset(
                            'assets/images/badge${index + 1}.png',
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // SPACER
                  SizedBox(
                    height: 32,
                  ),

                  // FAQ Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Side: Title & Image
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'INFO',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors
                                    .grey[700], // Lighter shade for subtlety
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'FAQ',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 96, // Larger and bolder
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Image.asset('assets/images/plant.png',
                              fit: BoxFit.cover),
                        ],
                      ),

                      // SPACER
                      SizedBox(width: 64),

                      // Right Side: FAQ Items
                      Expanded(
                        child: Column(
                          children: [
                            FAQItem(
                              title: 'What is EcoMarket?',
                              content:
                                  'EcoMarket is an online platform dedicated to offering eco-friendly and sustainable products that help reduce environmental impact while meeting everyday needs.',
                            ),
                            const SizedBox(height: 24),
                            FAQItem(
                              title:
                                  'How do I know if a product is eco-friendly?',
                              content:
                                  'We ensure all products meet sustainability standards.',
                            ),
                            const SizedBox(height: 24),
                            FAQItem(
                              title: 'What payment methods do you accept?',
                              content:
                                  'We accept credit cards, PayPal, and eco-friendly payments.',
                            ),
                            const SizedBox(height: 24),
                            FAQItem(
                              title: 'Do you offer carbon-neutral shipping?',
                              content:
                                  'Yes, we offset emissions by supporting green initiatives.',
                            ),
                            const SizedBox(height: 24),
                            FAQItem(
                              title: 'How does the rewards program work?',
                              content:
                                  'Earn points for purchases and redeem them for discounts.',
                            ),
                            const SizedBox(height: 24),
                            FAQItem(
                              title: 'Can I return or exchange a product?',
                              content:
                                  'Yes, returns and exchanges are accepted within 30 days.',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // =======================
            // FOOTER SECTION
            // =======================
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

  // Helper methods

Widget _buildIcon(BuildContext context, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: CircleAvatar(
      backgroundColor: Colors.yellow,
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: () {
          if (icon == Icons.person) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          } else if (icon == Icons.shopping_cart) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          } else if (icon == Icons.menu) {
            // Optionally, handle the menu icon navigation or action.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Menu icon clicked!")),
            );
          }
        },
      ),
    ),
  );
}


Widget _buildNavItem(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: TextButton(
      onPressed: () {
        if (text == "Store") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ShopPage()),
          );
        } else if (text == "Favorites") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const FavoritesPage()),
          // );
        } else if (text == "Orders") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const OrdersPage()),
          // );
        }
      },
      child: Text(text, style: const TextStyle(color: Colors.black)),
    ),
  );
}


  Widget _buildSearchBar() {
    return Container(
      width: 150,
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
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                isCollapsed: true,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resizableRoundedImage(String imagePath, double width, double height,
      {bool isGrayscale = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColorFiltered(
        colorFilter: isGrayscale
            ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
            : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
        child: Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _categoryItem(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label clicked!')),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 120,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Colors.green),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for building a product card from Firestore data
  Widget _buildProductCardFromFirestore(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              product["imageUrl"] ?? '',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product["name"] ?? 'Unnamed',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            product["price"] != null ? '₱${product["price"]}' : '',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String title;
  final String content;

  const FAQItem({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(6),
      color: Color(0xFFF2F2F2),
      elevation: 2,
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(content, style: const TextStyle(fontSize: 14)),
          )
        ],
      ),
    );
  }
}

// Product Card Widget
Widget _buildShopItemCard({required BuildContext context, required Map<String, dynamic> productData}) {
  return Container(
    width: 240,
    height: 300,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITLE ROW
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productData['name'] ?? 'No Name',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CircleAvatar(
              backgroundColor: primaryColor,
              child: IconButton(
                icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
                onPressed: () async {
                  try {
                    // Add the clicked product to the 'cart' collection in Firestore.
                    await FirebaseFirestore.instance
                        .collection('cart')
                        .add(productData);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${productData['name']} added to cart!',
                        ),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Error adding product to cart: ${e.toString()}'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),

        // SPACER
        SizedBox(height: 10),

        // PRODUCT IMAGE (Placeholder or add URL handling)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 160,
              height: 130,
              child: Image.network(
                productData["imageUrl"] ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),

        // SPACER
        SizedBox(height: 10),

        // DETAILS SECTION
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productData['short_description'] ?? '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFC4C4C4)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '₱ ${productData['price']?.toStringAsFixed(2) ?? '0.00'}',
                style: TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
