import 'package:eco_market/pages/congratulation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_market/pages/profile_page.dart';
import 'package:eco_market/pages/landing_page.dart';
import 'package:eco_market/pages/shop_page.dart';
import 'package:eco_market/pages/cart_page.dart';

Color primaryColor = Color(0xFF102F15);

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Map<String, int> _quantities = {};
  final TextEditingController _cardHolderNameCtrl = TextEditingController();
  final TextEditingController _cardNumCtrl = TextEditingController();
  final TextEditingController _monthCtrl = TextEditingController();
  final TextEditingController _yearCtrl = TextEditingController();
  final TextEditingController _cvcCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _mobileNumCtrl = TextEditingController();

  bool _saveCardData = false;
  Widget? _activeWidget;

  void _showWidget(Widget widgetToShow) {
    setState(() {
      _activeWidget = widgetToShow;
    });
  }

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

      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 124,
                  vertical: 48,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // "Checkout" heading
                          Text(
                            "Checkout",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Progress bar row: Address - Shipping - Payment
                          Row(
                            children: [
                              // Address
                              Text(
                                "Address",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              // Separator
                              const SizedBox(width: 8),
                              Text(
                                "—",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Shipping
                              Text(
                                "Shipping",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              // Separator
                              const SizedBox(width: 8),
                              Text(
                                "—",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Payment
                              Text(
                                "Payment",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              // GCash Payment Button
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OutlinedButton(
                                    onPressed: () => _showWidget(
                                        _buildGCashPayment(context)),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: Color(0xFF1D4D90), width: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 48, vertical: 18),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            'assets/images/gcash_logo.png',
                                            height: 20,
                                            fit: BoxFit.contain),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(width: 8),

                              // Card Payment Button
                              TextButton(
                                onPressed: () =>
                                    _showWidget(_buildCardPayment(context)),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: Colors.yellow,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 36, vertical: 18),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.credit_card,
                                        color: Colors.black, size: 16),
                                    SizedBox(width: 8),
                                    Text(
                                      'Credit Card',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // "Shipping Information"
                          Text(
                            "Payment Details",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          _activeWidget ?? _buildGCashPayment(context),

                          const SizedBox(height: 16),

                          // Save contact information checkbox
                          Row(
                            children: [
                              Switch(
                                value: _saveCardData,
                                onChanged: (bool value) {
                                  setState(() {
                                    _saveCardData = value ?? false;
                                  });
                                },
                                activeTrackColor: primaryColor,
                                inactiveTrackColor: Colors.white,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                "Save card data for future payments?",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // "Continue to shipping" Button
                          SizedBox(
                            height: 48,
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CongratulationsPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                foregroundColor: Colors.black,
                                textStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Confirm Payment"),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 160),

                    // Right Column: Cart Summary
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
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final docs = snapshot.data?.docs ?? [];
                          if (docs.isEmpty) {
                            // No items in cart
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your cart",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Your cart is empty.",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            );
                          }

                          // Calculate Subtotal
                          double subtotal = 0.0;
                          List<Widget> itemWidgets = [];
                          for (var doc in docs) {
                            final data = doc.data() as Map<String, dynamic>;
                            final docId = doc.id;

                            // Ensure local quantity starts at 1
                            if (!_quantities.containsKey(docId)) {
                              _quantities[docId] = 1;
                            }

                            final name = data['name'] ?? 'Unnamed';
                            final shortDesc = data['short_description'] ?? '';
                            final price = (data['price']?.toDouble() ?? 0.0);
                            final imageUrl = data['imageUrl'] ?? '';

                            final qty = _quantities[docId] ?? 1;
                            subtotal += (price * qty);

                            itemWidgets.add(
                              Column(
                                children: [
                                  // Single cart item row
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Product image
                                      Container(
                                        width: 120,
                                        height: 120,
                                        color: Colors.grey[300],
                                        child: imageUrl.isEmpty
                                            ? Center(
                                                child: Text(
                                                  "No Image",
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              )
                                            : Image.network(
                                                imageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      const SizedBox(width: 10),
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
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              shortDesc,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                            // Quantity
                                            Wrap(
                                              spacing: 8.0,
                                              runSpacing: 4.0,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Text(
                                                  "Quantity: ",
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (_quantities[
                                                                  docId]! >
                                                              1) {
                                                            _quantities[docId] =
                                                                _quantities[
                                                                        docId]! -
                                                                    1;
                                                          }
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons.remove),
                                                    ),
                                                    Text(
                                                      "${_quantities[docId]}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 14),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _quantities[docId] =
                                                              _quantities[
                                                                      docId]! +
                                                                  1;
                                                        });
                                                      },
                                                      icon:
                                                          const Icon(Icons.add),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Price & Remove
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "₱${price.toStringAsFixed(2)}",
                                            style: GoogleFonts.poppins(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
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
                              // "Your cart"
                              Text(
                                "Your Cart",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              // Cart items
                              ...itemWidgets,
                              const SizedBox(height: 32),
                              // Coupon code
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
                              const SizedBox(height: 32),
                              // Subtotal
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              // Total
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ---------------- FOOTER (from landing_page.dart) ----------------
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER HELPERS ----------------
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

// ---------------- FOOTER (same as landing_page.dart) ----------------
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
                      child: Text(
                        'EcoMarket',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                      Text(
                        'Quick Links',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
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
                      Text(
                        'Neighbors We Serve',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
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
                          Text(
                            'Hours of Operation',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
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
                          Text(
                            'Our Vista Location',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
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

  Widget _buildGCashPayment(BuildContext context) {
    return Column(
      children: [
        // Cardholder Name
        TextField(
          controller: _cardHolderNameCtrl,
          decoration: InputDecoration(
            labelText: "Cardholder Name",
            labelStyle: GoogleFonts.poppins(),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // Card Number
        TextField(
          controller: _cardNumCtrl,
          decoration: InputDecoration(
            labelText: "Card Number",
            labelStyle: GoogleFonts.poppins(),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // MONTH, YEAR, CVC
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _monthCtrl,
                decoration: InputDecoration(
                  labelText: "Month",
                  labelStyle: GoogleFonts.poppins(),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _yearCtrl,
                decoration: InputDecoration(
                  labelText: "Year",
                  labelStyle: GoogleFonts.poppins(),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _cvcCtrl,
                decoration: InputDecoration(
                  labelText: "CVC",
                  labelStyle: GoogleFonts.poppins(),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardPayment(BuildContext context) {
    return Column(
      children: [
        // Card Payment - Email
        TextField(
          controller: _emailCtrl,
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: GoogleFonts.poppins(),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // Card Payment - Mobile Number
        TextField(
          controller: _mobileNumCtrl,
          decoration: InputDecoration(
            labelText: "Mobile Number",
            labelStyle: GoogleFonts.poppins(),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
