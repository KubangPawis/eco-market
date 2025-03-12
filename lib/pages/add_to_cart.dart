import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key});

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  // Sample Cart item list
  List<Map<String, dynamic>> cartItems = [
     {"name": "Organic Apples", "price": 50.0, "quantity": 1, "image": "assets/images/apple.png"},
    {"name": "Brown Rice", "price": 80.0, "quantity": 2, "image": "assets/images/rice.png"},
    {"name": "Almond Milk", "price": 120.0, "quantity": 1, "image": "assets/images/milk.png"},
  ];

  // Increase Quantity
  void increaseQuantity(int index){
    setState(() {
      cartItems[index]["quantity"]++;
    });
  }

  //decrease quantity
  void decreaseQuantity(int index){
    setState((){
      if (cartItems[index]["quantity"] > 1) {
        cartItems[index]["quantity"]--;
      }
    });
  }

  // remove an item from the cart
  void removeItem(int index){
    setState((){
      cartItems.removeAt(index);
    });
  }

  //calculate the price
   double getTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + (item["price"] * item["quantity"]));
  }

  @override
  Widget build(BuildContext context) {
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
          children: ["Home", "Store", "Favorites", "Orders"].map((text) => _buildNavItem(text)).toList(),
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
            SizedBox(  // ✅ Wrap the list in a SizedBox to give it a defined height
              height: MediaQuery.of(context).size.height * 0.7,  // Adjust the height as needed
              child: cartItems.isEmpty
                  ? Center(
                      child: Text(
                        "Your cart is empty",
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        var item = cartItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: ListTile(
                            leading: Image.asset(item["image"], width: 50, height: 50),
                            title: Text(
                              item["name"],
                              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              "₱${item["price"].toStringAsFixed(2)} each",
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.remove_circle_outline),
                                    onPressed: () => decreaseQuantity(index)),
                                Text(
                                  item["quantity"].toString(),
                                  style: GoogleFonts.poppins(fontSize: 16),
                                ),
                                IconButton(
                                    icon: Icon(Icons.add_circle_outline),
                                    onPressed: () => increaseQuantity(index)),
                                IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => removeItem(index)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            _buildCartSummary(),  // ✅ Cart summary below the list
            const SizedBox(height: 10),
            _buildFooter(),  // ✅ Footer at the very bottom
          ],
        ),
      ),
    );
  }
  Widget _buildCartSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total:", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
              Text("₱${getTotalPrice().toStringAsFixed(2)}", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Handle checkout process
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text("Proceed to Checkout", style: GoogleFonts.poppins(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: IconButton(icon: Icon(icon, color: Colors.black), onPressed: () {}),
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
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: const [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 5),
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(hintText: "Search", border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildFooter() {
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
      );
  }
}
