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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 3500), // Adjust this value
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Hello, Seller.',
                    style: GoogleFonts.poppins(
                      fontSize: 64,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // KPI Cards
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: const [
                      KpiCard(title: 'Total Sales', value: '\$1700', icon: Icons.attach_money),
                      KpiCard(title: 'New Orders', value: '150', icon: Icons.shopping_basket),
                      KpiCard(title: 'Total Products', value: '112', icon: Icons.inventory_2),
                      KpiCard(title: 'Total Customers', value: '245', icon: Icons.people_alt),
                    ],
                  ),
                  const SizedBox(height: 80),

                  // Charts and Table Section
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1500),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: const LineChartWidget(),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                child: const OrderTable(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),

                        // Right Column
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: const ProductViewsChart(),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: const TopSoldItemsCard(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
    ))));
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
  final String title;
  final String value;
  final IconData icon;

  const KpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.green[700],
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 315,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DataTable(
        horizontalMargin: 0, // Remove default margin
        columnSpacing: 20, // Adjust spacing between columns
        headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
        columns: [
          DataColumn(label: Text('Product', style: GoogleFonts.poppins())),
          DataColumn(label: Text('Order ID', style: GoogleFonts.poppins())),
          DataColumn(label: Text('Customer', style: GoogleFonts.poppins())),
          DataColumn(label: Text('Date', style: GoogleFonts.poppins())),
          DataColumn(label: Text('Price', style: GoogleFonts.poppins())),
          DataColumn(label: Text('Status', style: GoogleFonts.poppins())),
        ],
        rows: [
          _buildDataRow(
            'Leskebox - escape Chrome',
            '#2017/09',
            'Admin Reyes',
            '03-15-25',
            267.00,
            'Completed',
          ),
          _buildDataRow(
            'Eco-friendly Shampoo',
            '#2017/09',
            'Ady Reyes',
            '03-29-25',
            78.00,
            'Pending',
          ),
          _buildDataRow(
            'Wooden Desk',
            '#2017/08',
            'Meggy Vil',
            '03-29-25',
            3000.00,
            'Processing',
          ),
          _buildDataRow(
            'Organic Vitamins',
            '#2014/05',
            'Sarah Boys',
            '03-24-25',
            1500.00,
            'Completed',
          ),
        ],
      ),
    );
  }

   DataRow _buildDataRow(String product, String id, String customer, 
                    String date, double price, String status) {
  // Custom number formatting function
  String formatPrice(double price) {
    String priceString = price.toStringAsFixed(0);
    String formatted = '';
    int count = 0;
    
    for (int i = priceString.length - 1; i >= 0; i--) {
      formatted = priceString[i] + formatted;
      count++;
      if (count % 3 == 0 && i != 0) {
        formatted = ',$formatted';
      }
    }
    return '\$$formatted';
  }

  return DataRow(cells: [
    DataCell(Text(product)),
    DataCell(Text(id)),
    DataCell(Text(customer)),
    DataCell(Text(date)),
    DataCell(Text(formatPrice(price))),
    DataCell(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: status == 'Completed' 
              ? Colors.green.shade100 
              : status == 'Pending'
                  ? Colors.orange.shade100
                  : Colors.blue.shade100,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(status),
      ),
    ),
  ]);
}
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Legend Row
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildLegendItem(Colors.green, 'Current Year'),
              const SizedBox(width: 20),
              _buildLegendItem(Colors.amber, 'Last Year'),
            ],
          ),
        ),
        
        // Chart
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          months[value.toInt()],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 1.5),
                    FlSpot(1, 2.5),
                    FlSpot(2, 1.5),
                    FlSpot(3, 3),
                    FlSpot(4, 1),
                    FlSpot(5, 4),
                  ],
                  color: Colors.green,
                  barWidth: 2,
                  isCurved: true,
                  dotData: FlDotData(show: false),
                ),
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 2),
                    FlSpot(1, 1.8),
                    FlSpot(2, 2.5),
                    FlSpot(3, 1.5),
                    FlSpot(4, 2.2),
                    FlSpot(5, 2),
                  ],
                  color: Colors.amber,
                  barWidth: 2,
                  isCurved: true,
                  dotData: FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

 Widget _buildProgressItem(String label, double percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: GoogleFonts.poppins(fontSize: 14)),
              Text('${(percent * 100).toInt()}%',
                  style: GoogleFonts.poppins(fontSize: 14)),
            ],
          ),
          LinearPercentIndicator(
            percent: percent,
            progressColor: Colors.green[700],
            backgroundColor: Colors.grey.shade200,
            lineHeight: 6,
            barRadius: const Radius.circular(3),
          ),
        ],
      ),
    );
  }

class ProductViewsChart extends StatelessWidget {
  const ProductViewsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'Product Views',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 10,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '${(value * 1).toInt()}k',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          days[value.toInt()],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [BarChartRodData(toY: 10, color: Colors.green)],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [BarChartRodData(toY: 8, color: Colors.green)],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [BarChartRodData(toY: 6, color: Colors.green)],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [BarChartRodData(toY: 4, color: Colors.green)],
                ),
                BarChartGroupData(
                  x: 4,
                  barRods: [BarChartRodData(toY: 2, color: Colors.green)],
                ),
                BarChartGroupData(
                  x: 5,
                  barRods: [BarChartRodData(toY: 6, color: Colors.green)],
                ),
                BarChartGroupData(
                  x: 6,
                  barRods: [BarChartRodData(toY: 8, color: Colors.green)],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TopSoldItemsCard extends StatelessWidget {
  const TopSoldItemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Sold Items',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          _buildProgressItem('Food', 0.90),
          _buildProgressItem('Toiletries', 0.15),
          _buildProgressItem('Furnitures', 0.55),
          _buildProgressItem('Accessories', 0.40),
          _buildProgressItem('Vitamins', 0.20),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String label, double percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, 
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                )),
              Text('${(percent * 100).toInt()}%',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.green[700],
                )),
            ],
          ),
          const SizedBox(height: 4),
          LinearPercentIndicator(
            percent: percent,
            progressColor: Colors.green[700],
            backgroundColor: Colors.grey.shade200,
            lineHeight: 6,
            barRadius: const Radius.circular(4),
          ),
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
