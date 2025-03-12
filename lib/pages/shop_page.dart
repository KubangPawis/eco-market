import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_market/pages/cart_page.dart';
import 'package:eco_market/pages/landing_page.dart';
import 'package:eco_market/pages/profile_page.dart';

// For demonstration, we'll define placeholders inline.
// Replace these with your actual pages or separate them into their own files.
// --------------------------------------------------------------------------
// The actual ShopPage code
// --------------------------------------------------------------------------

Color primaryColor = Color(0xFF102F15);

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 150,
        leading: Padding(
            padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 30,
              child: Image.asset('assets/images/app_logo.png',
                  fit: BoxFit.contain),
          ),
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
                _buildIcon(Icons.person),        // Profile
                _buildIcon(Icons.menu),          // Menu
                _buildIcon(Icons.shopping_cart), // Cart
              ],
            ),
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                // =======================
            // MAIN CONTENT
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              child: Column(
                children: [
                  // PRODUCTS SECTION
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TITLE SECTION
                        Padding(
                            padding: EdgeInsets.all(32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text('EcoMarket',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                          color: primaryColor),
                                    )),
                              ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 700,
                                  ),
                                child: Text(
                                  'Explore our collection of eco-friendly products, carefully curated to help you live sustainably and responsibly.',
                                  style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      )),
                              ),
                            ],
                          ),
                        ),
                        // MID SECTION
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                // PRODUCT LISTING with Firestore data
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('products')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                      }
                                      final productDocs = snapshot.data!.docs;
                                      return GridView.builder(
                                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 300,
                                          crossAxisSpacing: 40,
                                          mainAxisSpacing: 25,
                                          childAspectRatio: 240 / 350,
                                        ),
                                        itemCount: productDocs.length,
                                        shrinkWrap: true,
                                          padding: EdgeInsets.symmetric(horizontal: 64),
                                          physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                            final productData =
                                                productDocs[index].data() as Map<String, dynamic>;
                                            return _buildShopItemCard(context: context, productData: productData);
                                        },
                                      );

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
                // =======================
                // FOOTER
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
                                              horizontal: 20,
                                                      vertical: 15),
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
                                  SizedBox(
                                    height: 50,
                                  ),
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
      ),
    );
}

  // ========== HEADER HELPERS ==========

  Widget _buildNavItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: () {
          if (text == "Home") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LandingPage()),
            );
          } else if (text == "Store") {
            // If you want to replace instead of stacking, use pushReplacement
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

  Widget _buildIcon(IconData icon) {
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
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            } else if (icon == Icons.menu) {
              // If you have a menu page or drawer, handle it here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Menu icon clicked!")),
              );
            }
          },
        ),
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

  // ========== SHOP ITEM CARD ==========

  Widget _buildShopItemCard({
    required BuildContext context,
    required Map<String, dynamic> productData,
  }) {
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
}