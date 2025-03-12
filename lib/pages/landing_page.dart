import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    // A custom color palette (optional)
    const Color primaryGreen = Color(0xFF74B72E);
    const Color darkGreen = Color(0xFF2B7A0B);
    const Color lightGreen = Color(0xFFA7D129);
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.1; // Adjust title size dynamically

    return Scaffold(
      // A transparent or themed AppBar that resembles the top bar in the design
      appBar: AppBar(backgroundColor: Colors.white,
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
      centerTitle: true, // Ensure centering works well
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0), // Add padding on right edge
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
            margin: const EdgeInsets.symmetric(horizontal: 16), // Add margin for spacing
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24), // Rounded edges
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1, // Reduced spread for softer effect
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Center content vertically
              children: [
                // COLUMN 1: Left Image (Colored Vegetables)
                Flexible(
                  flex: 3,
                  child: _resizableRoundedImage('assets/images/tomatoes.png', 396, 430),
                ),

                const SizedBox(width: 16), // Space between images

                // COLUMN 2: Center Image (Grayscale Market Scene) - LOWERED
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40), // Moves second image lower
                      _resizableRoundedImage('assets/images/banana.png', 250, 430, isGrayscale: true),
                    ],
                  ),
                ),

                const SizedBox(width: 16), // Space before text

                // COLUMN 3: Text Content
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // WELCOME TEXT (Bold, Responsive)
                        Text(
                          'WELCOME TO',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18, // Adjust dynamically
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5, // Reduced for better readability
                          ),
                        ),
                        const SizedBox(height: 8),

                        // TITLE (Responsive, Semi-Bold)
                        FittedBox(
                          fit: BoxFit.scaleDown, // Prevent overflow
                          child: Text(
                            'The',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: titleFontSize.clamp(36, 60), // Min 36, Max 96
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        FittedBox(
                          fit: BoxFit.scaleDown, // Prevent overflow
                          child: Text(
                            'EcoMarket',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: titleFontSize.clamp(36, 60), // Min 36, Max 96
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // DESCRIPTION (RichText with better spacing)
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: screenWidth * 0.015, // Dynamic font size
                              color: Colors.black87,
                              height: 1.6, // Improved line height
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
                // Title Section
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

                // Grid of Categories (Now Multi-Row)
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16, // Space between items horizontally
                  runSpacing: 16, // Space between rows
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
          Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.symmetric(horizontal: 16), // Add margin for spacing
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24), // Rounded edges
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1, // Reduced spread for softer effect
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 800,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/pineapple.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                ),
                Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
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

                // **Carousel of Favorite Products**
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    viewportFraction: 0.5,
                    enlargeCenterPage: true,
                  ),
                  items: _productList.map((product) {
                    return _productCard(product);
                  }).toList(),
                ),

                const SizedBox(height: 16),

                // **All Products Button**
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            // FAVORITE PRODUCTS
            // =======================
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Our Favorite Products',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 240, // enough height for carousel items
                    child: ProductCarousel(),
                  ),
                ],
              ),
            ),
            // =======================
            // BADGES &FAQs
            // =======================
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1: Badges
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) => Image.asset('assets/images/badge${index + 1}.png', width: 240, height: 240)),
                  ),
                ),

                // Row 2: FAQ Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column 1: Info, FAQ Title, Image
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('INFO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            SizedBox(height: 8),
                            Text('FAQ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            SizedBox(height: 16),
                            Image.asset('assets/images/plant.png', fit: BoxFit.cover),
                          ],
                        ),
                      ),

                      SizedBox(width: 16), // Spacing between columns

                      // Column 2: FAQ Collapsible Items
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            FAQItem(title: 'What is EcoMarket?', content: 'EcoMarket is an online platform dedicated to offering eco-friendly products.'),
                            FAQItem(title: 'How do I know if a product is eco-friendly?', content: 'We ensure all products meet sustainability standards.'),
                            FAQItem(title: 'What payment methods do you accept?', content: 'We accept credit cards, PayPal, and eco-friendly payments.'),
                            FAQItem(title: 'Do you offer carbon-neutral shipping?', content: 'Yes, we offset emissions by supporting green initiatives.'),
                            FAQItem(title: 'How does the rewards program work?', content: 'Earn points for purchases and redeem them for discounts.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // =======================
            // FOOTER
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
                  // Example of multi-column footer
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
                            Text(
                              '- Home',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '- Shop',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '- About Us',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '- Contact',
                              style: TextStyle(color: Colors.white),
                            ),
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
                            Text(
                              '- Food',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '- Skincare',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '- Clothes',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '- Accessories',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '- Furniture',
                              style: TextStyle(color: Colors.white),
                            ),
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
                            Text(
                              'Email: info@ecomarket.com',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Phone: +1 234 567 890',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Mon - Fri: 9am - 5pm',
                              style: TextStyle(color: Colors.white),
                            ),
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

  // Small helper widget for hero images
  Widget _heroMiniImage(String assetPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        assetPath,
        width: 100,
        height: 80,
        fit: BoxFit.cover,
      ),
    );
  }

  // Small helper widget for Info badges in FAQ section
  Widget _infoBadge(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 24,
          child: Icon(
            icon,
            color: Colors.green,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// =======================
// CATEGORY BUTTON
// =======================
class CategoryButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const CategoryButton(this.title, this.icon, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================
// PRODUCT CAROUSEL
// =======================
class ProductCarousel extends StatelessWidget {
  const ProductCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          width: 160,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  'assets/images/product${index + 1}.png',
                  width: 160,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              // Product details
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Product ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Short product description goes here...',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\$${(index + 1) * 10}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// =======================
// FAQ CARD
// =======================
class FAQCard extends StatelessWidget {
  final String question;
  final String answer;

  const FAQCard({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
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
              textAlignVertical: TextAlignVertical.center, // Fix alignment
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                isCollapsed: true, // Prevents extra padding
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(60);

    Widget _resizableRoundedImage(String imagePath, double width, double height, {bool isGrayscale = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColorFiltered(
        colorFilter: isGrayscale
            ? const ColorFilter.mode(
                Colors.grey, BlendMode.saturation)
            : const ColorFilter.mode(
                Colors.transparent, BlendMode.multiply),
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
        // You can replace the above line with navigation, e.g.:
        // Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(label)));
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
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

final List<Map<String, String>> _productList = [
    {"name": "Basket", "price": "₱800", "image": "assets/images/product1.png"},
    {"name": "Sofa", "price": "₱24,000", "image": "assets/images/product2.png"},
    {"name": "Hair Mask", "price": "₱900", "image": "assets/images/product3.png"},
    {"name": "Lemon", "price": "₱800", "image": "assets/images/product4.png"},
  ];

  // Widget for Product Card
  Widget _productCard(Map<String, String> product) {
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
            child: Image.asset(
              product["image"]!,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product["name"]!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            product["price"]!,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

class FAQItem extends StatelessWidget {
  final String title;
  final String content;

  FAQItem({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(content, style: TextStyle(fontSize: 14)),
          )
        ],
      ),
    );
  }
}