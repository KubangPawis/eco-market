import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:eco_market/pages/shop_page.dart';
import 'package:eco_market/pages/cart_page.dart';
import 'package:eco_market/pages/profile_page.dart';

void main() {
  runApp(const MaterialApp(home: SellerLandingPage()));
}

class SellerLandingPage extends StatelessWidget {
  const SellerLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                _buildIcon(context, Icons.person),
                _buildIcon(context, Icons.menu),
                _buildIcon(context, Icons.shopping_cart),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🟨 KPI Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                KpiCard(title: 'Total Sales', value: '1700'),
                KpiCard(title: 'New Orders', value: '150'),
                KpiCard(title: 'Total Products', value: '112'),
                KpiCard(title: 'Total Customers', value: '245'),
              ],
            ),
            const SizedBox(height: 20),

            // 📈 Charts Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Line Chart
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const LineChartWidget(),
                  ),
                ),
                const SizedBox(width: 16),
                // Bar Chart and Top Sold Items
                Expanded(
                  flex: 1,
                  child: Column(
                    children: const [
                      ProductViewsChart(),
                      SizedBox(height: 16),
                      TopSoldItemsCard(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 📦 Order Table
            const OrderTable(),

            const SizedBox(height: 30),
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
}

//Helper Functions

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
        //  Navigator.push(
        //    context,
        //    MaterialPageRoute(builder: (context) => const ShopPage()),
        //  );
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

class KpiCard extends StatelessWidget {
  final String title, value;
  const KpiCard({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber[400],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(Icons.bar_chart, size: 32),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: const [FlSpot(0, 1), FlSpot(1, 2), FlSpot(2, 1.5), FlSpot(3, 3)],
              isCurved: true,
              color: Colors.green,
            ),
            LineChartBarData(
              spots: const [FlSpot(0, 1.2), FlSpot(1, 1.5), FlSpot(2, 2), FlSpot(3, 2.5)],
              isCurved: true,
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductViewsChart extends StatelessWidget {
  const ProductViewsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: const [
          Text("Product Views", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          SizedBox(height: 150, child: Placeholder()), // Replace with Bar Chart
        ],
      ),
    );
  }
}

class TopSoldItemsCard extends StatelessWidget {
  const TopSoldItemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text("Top Sold Items", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          buildProgress("Food", 1.0),
          buildProgress("Toiletries", 0.9),
          buildProgress("Furniture", 0.75),
          buildProgress("Accessories", 0.5),
          buildProgress("Vitamins", 0.2),
        ],
      ),
    );
  }

  Widget buildProgress(String label, double percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: LinearPercentIndicator(
        lineHeight: 8,
        percent: percent,
        backgroundColor: Colors.grey.shade300,
        progressColor: Colors.green,
        center: Text("$label", style: const TextStyle(fontSize: 10)),
      ),
    );
  }
}

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {"id": "#093018", "customer": "Addison Reyes", "date": "03-12-25", "price": "257.00", "status": "Completed"},
      {"id": "#272387", "customer": "Andy Reyes", "date": "02-23-25", "price": "750.00", "status": "Pending"},
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text("All Orders", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...orders.map((order) => ListTile(
                title: Text(order['customer']!),
                subtitle: Text("Order ID: ${order['id']} • ${order['date']}"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("\$${order['price']}"),
                    Badge(status: order['status']!),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final String status;
  const Badge({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final color = status == "Completed" ? Colors.green : Colors.orange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status, style: TextStyle(color: color, fontSize: 12)),
    );
  }
}
