import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eco_market/pages/shop_page.dart';
  
Color primaryColor = const Color(0xFF102F15);
Color accentColor = const Color(0xFFFCDC1A);

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // Dummy static favorites data (placeholder)
  final List<Map<String, dynamic>> favorites = [
    {
      'name': 'Eco Bottle',
      'short_description': 'Reusable, BPA free.',
      'price': 25.00,
      'imageUrl': 'https://via.placeholder.com/200x150',
    },
    {
      'name': 'Organic T-Shirt',
      'short_description': '100% cotton, sustainable.',
      'price': 45.50,
      'imageUrl': 'https://via.placeholder.com/200x150',
    },
    {
      'name': 'Bamboo Toothbrush',
      'short_description': 'Eco-friendly alternative.',
      'price': 10.00,
      'imageUrl': 'https://via.placeholder.com/200x150',
    },
    {
      'name': 'Reusable Bag',
      'short_description': 'Stylish and durable.',
      'price': 15.00,
      'imageUrl': 'https://via.placeholder.com/200x150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---------------- HEADER ----------------
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
                _buildIcon(Icons.person),
                _buildIcon(Icons.menu),
                _buildIcon(Icons.shopping_cart),
              ],
            ),
          ),
        ],
      ),
      // ---------------- BODY ----------------
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main content padding (you can change the value if needed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 145.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Title
                  Text(
                    "Favorites",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    "Here you will find all your favorite eco-friendly picks.",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // "Shop All" Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ShopPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Shop All",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // GridView of favorite items (static placeholders)
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 25,
                      childAspectRatio: 240 / 350,
                    ),
                    itemCount: favorites.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = favorites[index];
                      return _buildFavoriteItemCard(context, product);
                    },
                  ),
                ],
              ),
            ),
            // ---------------- FOOTER ----------------
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // ---------------- Helper Methods ----------------

  Widget _buildFavoriteItemCard(BuildContext context, Map<String, dynamic> product) {
    return Container(
      width: 240,
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE ROW with product name and favorite icon placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product['name'] ?? 'No Name',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // PRODUCT IMAGE
          Center(
            child: SizedBox(
              width: 160,
              height: 130,
              child: Image.network(
                product["imageUrl"] ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // DETAILS SECTION
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product['short_description'] ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFC4C4C4)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '₱ ${product['price']?.toStringAsFixed(2) ?? '0.00'}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Reusable header helper methods
  
  Widget _buildNavItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: () {
          // Navigation logic – modify as needed
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
            // Navigation logic – modify as needed
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
  
  // Footer helper method (similar to what you have in your landing page)
  
  Widget _buildFooter(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 16, 47, 21),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 80),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 30,
            runSpacing: 50,
            children: [
              // COLUMN 1
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('EcoMarket',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                    const SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subscribe to our newsletter',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 24, color: Colors.white),
                            )),
                        const SizedBox(height: 20),
                        ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 700, maxWidth: 700),
                          child: TextFormField(
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 20, color: Color.fromRGBO(255, 255, 255, 0.63)),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor: Colors.yellow,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  ),
                                  child: Text(
                                    'Subscribe',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text('Subscribe to our newsletter to be the first to know about news and offers',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300, color: Color.fromRGBO(255, 255, 255, 0.63)),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              // Other footer columns (omitted for brevity, copy them from your shop page or landing page)
            ],
          ),
        ),
      ),
    );
  }
}
