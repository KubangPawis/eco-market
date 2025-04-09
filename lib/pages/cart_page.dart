import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_market/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eco_market/pages/shop_page.dart';
import 'package:eco_market/pages/landing_page.dart';
import 'package:eco_market/pages/profile_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Tracks the local quantity of each cart item by doc ID
  final Map<String, int> _quantities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---------------- HEADER (from landing_page.dart) ----------------
      backgroundColor: Colors.white,
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

      // ---------------- BODY: StreamBuilder to read 'cart' collection ----------------
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cart content (with 145px side padding)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 145.0, vertical: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column: Cart Items
                  Expanded(
                    flex: 2,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('cart')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            style: GoogleFonts.poppins(),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final docs = snapshot.data?.docs ?? [];
                        if (docs.isEmpty) {
                          return Text(
                            "Your cart is empty.",
                            style: GoogleFonts.poppins(fontSize: 18),
                          );
                        }

                        // Build a list of cart item rows
                        final List<Widget> cartItemWidgets = [];
                        for (var doc in docs) {
                          final data = doc.data() as Map<String, dynamic>;
                          final docId = doc.id;

                          // Initialize quantity to 1 if not present in _quantities
                          if (!_quantities.containsKey(docId)) {
                            _quantities[docId] = 1;
                          }

                          // Extract Firestore fields
                          final name = data['name'] ?? 'Unnamed';
                          final shortDesc = data['short_description'] ?? '';
                          final price = data['price']?.toDouble() ?? 0.0;
                          final imageUrl = data['imageUrl'] ?? '';

                          cartItemWidgets.add(
                            Column(
                              children: [
                                // Single cart item row
                                Row(
                                  children: [
                                    // Product image or fallback
                                    Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey[300],
                                      child: imageUrl.isEmpty
                                          ? Center(
                                              child: Text(
                                                "No Image",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12),
                                              ),
                                            )
                                          : Image.network(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Product details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            shortDesc,
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          // Quantity row
                                          Row(
                                            children: [
                                              Text(
                                                "Quantity: ",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (_quantities[docId]! >
                                                        1) {
                                                      _quantities[docId] =
                                                          _quantities[docId]! -
                                                              1;
                                                    }
                                                  });
                                                },
                                                icon: const Icon(Icons.remove),
                                              ),
                                              Text(
                                                "${_quantities[docId]}",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _quantities[docId] =
                                                        _quantities[docId]! + 1;
                                                  });
                                                },
                                                icon: const Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Price + Remove link
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "₱${price.toStringAsFixed(2)}",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            // Delete item from Firestore
                                            await doc.reference.delete();
                                          },
                                          child: Text(
                                            "Remove",
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your cart",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Not ready to checkout? Continue Shopping",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // All cart items
                            ...cartItemWidgets,
                            const SizedBox(height: 24),
                            // Order Information
                            Text(
                              "Order Information",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Return Policy",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "This is our example return policy which is everything you need to know about our returns.",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 80),
                  // Right Column: Order Summary
                  Container(
                    width: 300,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('cart')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          // If cart is empty, just show an empty summary
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order Summary",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "No items in cart.",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        }

                        final docs = snapshot.data!.docs;
                        double subtotal = 0.0;
                        for (var doc in docs) {
                          final data = doc.data() as Map<String, dynamic>;
                          final docId = doc.id;
                          final price = data['price']?.toDouble() ?? 0.0;
                          final qty = _quantities[docId] ?? 1;
                          subtotal += (price * qty);
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Summary",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Coupon code input
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Enter coupon code here",
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 14),
                                ),
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Subtotal
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Text(
                                  "₱${subtotal.toStringAsFixed(2)}",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Shipping
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Shipping",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Text(
                                  "Calculated at the next step",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Total (for now same as subtotal, if no additional fees)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "₱${subtotal.toStringAsFixed(2)}",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Checkout button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: ()
                                {
                                   Navigator.push
                                   (
                                   context, MaterialPageRoute(builder: (context) => const CheckoutPage()),
                                   );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                child: const Text("Continue to checkout"),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- FOOTER (from landing_page.dart) ----------------
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // ---------------- Header Helper Widgets ----------------

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
        if (text == "Home") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LandingPage()),
          );
        } else if (text == "Store") {
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

  // ---------------- Footer (same structure as landing_page.dart) ----------------
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        Text(
                          'Subscribe to our newsletter',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 700, maxWidth: 700),
                          child: TextFormField(
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(255, 255, 255, 0.63),
                                ),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
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
                        Text(
                          'Subscribe to our newsletter to be the first to know about news and offers',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(255, 255, 255, 0.63),
                            ),
                          ),
                        ),
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
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                      const SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Home',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('About Us',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('Menu',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('Blog',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('Deals',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
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
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                      const SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lucena',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('Tayabas',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('Candelaria',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('Sariaya',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('Lucban',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('Tiaong',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('Pagbilao',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('Padre Burgos',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )),
                          Text('San Pablo',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
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
                      // Hours of Operation
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hours of Operation',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Open Daily',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  )),
                              Text('Mon-Sun (9:00am - 5:00pm)',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      // Our Vista Location
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Our Vista Location',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('10171 Synamore Ave. Vista St. CA 92081',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
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
    );
  }
}
