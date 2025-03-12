import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.1; // Adjust title size dynamically

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 160,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Image.asset('assets/images/app_logo.png', fit: BoxFit.contain),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // =======================
            // ROW 1: HERO IMAGE
            // =======================
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Image.asset(
                'assets/images/hero_background.png',
                fit: BoxFit.cover,
              ),
            ),

            // =======================
            // ROW 2: WHITE SECTION (3 COLUMNS)
            // =======================
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
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
                            'assets/images/banana.png', 250, 430,
                            isGrayscale: true),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
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
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'The',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: titleFontSize.clamp(36, 60),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'EcoMarket',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: titleFontSize.clamp(36, 60),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: screenWidth * 0.015,
                                color: Colors.black87,
                                height: 1.6,
                              ),
                              children: [
                                const TextSpan(text: 'Eco'),
                                TextSpan(
                                  text: 'Market',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(
                                  text:
                                      ' is your go-to platform for eco-friendly and sustainable products. Discover a wide range of items that prioritize the planet, from reusable essentials to organic goods. Shop with purpose and make a positive impact on the environment.',
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

            // ABOUT US SECTION
            Container(
              padding: const EdgeInsets.all(32),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
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

            // Example Image Section
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SizedBox(
                height: 800,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/pineapple.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // =======================
            // PRODUCTS CAROUSEL SECTION (from Firestore)
            // =======================
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "PRODUCTS",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Our Favorite Products",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('products').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No products available.'));
                    }

                    final products = snapshot.data!.docs.map((doc) {
                      return doc.data() as Map<String, dynamic>;
                    }).toList();

                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        viewportFraction: 0.5,
                        enlargeCenterPage: true,
                      ),
                      items: products.map((product) {
                        return _buildProductCardFromFirestore(product);
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Viewing all products!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("All Products"),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),

            // =======================
            // BADGES & FAQ SECTION
            // =======================
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      5,
                      (index) => Image.asset('assets/images/badge${index + 1}.png',
                          width: 240, height: 240),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('INFO',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            Text('FAQ',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            Image.asset('assets/images/plant.png',
                                fit: BoxFit.cover),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            FAQItem(
                                title: 'What is EcoMarket?',
                                content:
                                    'EcoMarket is an online platform dedicated to offering eco-friendly products.'),
                            FAQItem(
                                title: 'How do I know if a product is eco-friendly?',
                                content:
                                    'We ensure all products meet sustainability standards.'),
                            FAQItem(
                                title: 'What payment methods do you accept?',
                                content:
                                    'We accept credit cards, PayPal, and eco-friendly payments.'),
                            FAQItem(
                                title: 'Do you offer carbon-neutral shipping?',
                                content:
                                    'Yes, we offset emissions by supporting green initiatives.'),
                            FAQItem(
                                title: 'How does the rewards program work?',
                                content:
                                    'Earn points for purchases and redeem them for discounts.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // =======================
            // FOOTER SECTION
            // =======================
            Container(
              width: double.infinity,
              color: darkGreen,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EcoMarket',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Quick Links',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('- Home', style: TextStyle(color: Colors.white)),
                            Text('- Shop', style: TextStyle(color: Colors.white)),
                            Text('- About Us',
                                style: TextStyle(color: Colors.white)),
                            Text('- Contact',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('- Food', style: TextStyle(color: Colors.white)),
                            Text('- Skincare',
                                style: TextStyle(color: Colors.white)),
                            Text('- Clothes',
                                style: TextStyle(color: Colors.white)),
                            Text('- Accessories',
                                style: TextStyle(color: Colors.white)),
                            Text('- Furniture',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Contact Us',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('Email: info@ecomarket.com',
                                style: TextStyle(color: Colors.white)),
                            Text('Phone: +1 234 567 890',
                                style: TextStyle(color: Colors.white)),
                            Text('Mon - Fri: 9am - 5pm',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.white.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '© 2025 EcoMarket - All rights reserved.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper methods
  
  Widget _buildIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: IconButton(
          icon: Icon(icon, color: Colors.black),
          onPressed: () {},
        ),
      ),
    );
  }
  
  Widget _buildNavItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: () {},
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
