import 'package:coffee/farm/profile/branch/AddNewCoffeePage.dart';
import 'package:coffee/farm/profile/branch/EditCoffeeInformationPage.dart';
import 'package:coffee/home/coffee_event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:coffee/constants.dart';



class ProductDetailPageSimple extends StatelessWidget {
  const ProductDetailPageSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Coffee Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        // --- ส่วนที่เพิ่มเข้ามา ---
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icon/settingicon.png', // Path ของไอคอนที่คุณระบุ
              width: 24,
              height: 24,
            ),
                      onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddNewCoffeePage()),
  );
},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/coffee2.png',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  width: 60,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: index == 0
                        ? Border.all(color: secondaryColor2, width: 2)
                        : null,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/coffee2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coffee Name",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Price",
                        style: TextStyle(
                          color: Color(0xFF444444),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow("Variety", "Quantity (kg)"),
                  _buildDetailRow("Processing Method", ""),
                  _buildDetailRow("Harvest Season", ""),
                  const SizedBox(height: 15),
                  const Text(
                    "CoffeeDescriptionxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                    style: TextStyle(color: Color(0xFF444444), height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Coffee Lot",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Text(
                    "Lot code",
                    style: TextStyle(color: Color(0xFF444444)),
                  ),
                  const Text(
                    "Harvest Date",
                    style: TextStyle(color: Color(0xFF444444)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sample Information",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1D2A4D),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(height: 300, child: _buildRadarChart()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Cupping",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: primaryColor2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 330,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: _buildCuppingCard(context),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          
            
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(color: Color(0xFF444444), fontSize: 14),
          ),
        ],
      ),
    );
  }

  

  Widget _buildCuppingCard(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 340,
        margin: const EdgeInsets.only(left: 5, right: 15, bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                'assets/images/coffee.png',
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Cupping Session",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18, color: Colors.blue),
                      const SizedBox(width: 8),
                      const Text(
                        "Start / End Date & Time",
                        style: TextStyle(color: Color(0xFF083584), fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on, size: 18, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            "Location",
                            style: TextStyle(color: Color(0xFF083584), fontSize: 12),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CoffeeEventDetailScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor2,
                          minimumSize: const Size(80, 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          "Read More",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 

  Widget _buildRadarChart() {
    return RadarChart(
      RadarChartData(
        radarShape: RadarShape.polygon,
        tickCount: 4,
        dataSets: [
          RadarDataSet(
            fillColor: const Color(0xFF874DB0).withOpacity(0.2),
            borderColor: const Color(0xFF874DB0),
            borderWidth: 3,
            entryRadius: 0,
            dataEntries: [
              const RadarEntry(value: 8.0),
              const RadarEntry(value: 8.0),
              const RadarEntry(value: 8.0),
              const RadarEntry(value: 8.0),
              const RadarEntry(value: 8.0),
              const RadarEntry(value: 8.0),
              const RadarEntry(value: 8.0),
            ],
          ),
          RadarDataSet(
            fillColor: Colors.transparent,
            borderColor: Colors.transparent,
            entryRadius: 0,
            dataEntries: List.generate(7, (index) => const RadarEntry(value: 9.0)),
          ),
          RadarDataSet(
            fillColor: Colors.transparent,
            borderColor: Colors.transparent,
            entryRadius: 0,
            dataEntries: List.generate(7, (index) => const RadarEntry(value: 7.5)),
          ),
        ],
        ticksTextStyle: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
        gridBorderData: const BorderSide(color: Color(0xFF333333), width: 2),
        radarBorderData: const BorderSide(color: Color(0xFF333333), width: 2),
        getTitle: (index, angle) {
          final titles = ['Fragrance Aroma', 'Aroma', 'Flavor', 'Aftertaste', 'Acidity', 'Sweetness', 'Mouthfeel'];
          return RadarChartTitle(text: titles[index]);
        },
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }
}