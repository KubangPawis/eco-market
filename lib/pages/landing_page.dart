import 'package:flutter/material.dart';

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
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // COLUMN 1: Left Image (Colored Vegetables)
                _roundedImage('assets/images/tomatoes.png'),

                // COLUMN 2: Center Image (Grayscale Market Scene)
                _roundedImage('assets/images/banana.png', isGrayscale: true),

                // COLUMN 3: Text Content
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // WELCOME TEXT
                        Text(
                          'WELCOME TO',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // TITLE
                        Text(
                          'The EcoMarket',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // DESCRIPTION
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
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
            // =======================
            // CATEGORIES SECTION
            // =======================
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'We Offer',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      CategoryButton('Food', Icons.restaurant, lightGreen),
                      CategoryButton('Skincare', Icons.face, Colors.pinkAccent),
                      CategoryButton('Clothes', Icons.shopping_bag, Colors.blueAccent),
                      CategoryButton('Accessories', Icons.access_time, Colors.purpleAccent),
                      CategoryButton('Furniture', Icons.chair, Colors.brown.shade300),
                    ],
                  ),
                ],
              ),
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
            // INFO / FAQ SECTION
            // =======================
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              decoration: BoxDecoration(
                color: lightGreen.withOpacity(0.2),
              ),
              child: Column(
                children: [
                  Text(
                    'INFO',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Some icons or bullet points
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _infoBadge(Icons.eco, 'Organic Produce'),
                      _infoBadge(Icons.agriculture, 'Locally Grown'),
                      _infoBadge(Icons.recycling, 'Sustainable Packaging'),
                      _infoBadge(Icons.public, 'Eco-Friendly'),
                      _infoBadge(Icons.handshake, 'Fair Trade'),
                      _infoBadge(Icons.verified, 'Quality Guaranteed'),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Actual FAQ
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FAQCard(
                    question: 'What is EcoMarket?',
                    answer:
                        'We are an online marketplace offering a curated selection of eco-friendly products for everyday life.',
                  ),
                  const Divider(),
                  FAQCard(
                    question: 'Do you offer carbon-neutral shipping?',
                    answer:
                        'Yes, we do! We partner with shipping providers who prioritize carbon offsets and sustainable packaging.',
                  ),
                  const Divider(),
                  FAQCard(
                    question: 'Where do you source your products?',
                    answer:
                        'Our products are sourced from local farms and fair-trade suppliers who meet our eco-friendly criteria.',
                  ),
                ],
              ),
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

   Widget _roundedImage(String imagePath, {bool isGrayscale = false}) {
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
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }