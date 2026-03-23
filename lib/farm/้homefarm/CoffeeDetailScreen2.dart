import 'package:coffee/constants.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/cupping_session_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CoffeeDetailScreen2 extends StatelessWidget {
  const CoffeeDetailScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Coffee Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icon/settingicon.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
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
                        ? Border.all(color: const Color(0xFFC07651), width: 2)
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
            _buildSectionDivider("cupping"),
            SizedBox(
              height: 310,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: 2,
                itemBuilder: (context, index) => _buildCuppingCard(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CuppingSessionListScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFE1F5FE),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "View All",
                    style: TextStyle(color: Color(0xFF03A9F4), fontSize: 12),
                  ),
                ),
              ),
            ),
            _buildSectionDivider("More Recommendations"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.72,
                ),
                itemCount: 4,
                itemBuilder: (context, index) => _buildRecommendationCard(),
              ),
            ),
            const SizedBox(height: 40),
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

  Widget _buildSectionDivider(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  Widget _buildRadarChart() {
    return RadarChart(
      RadarChartData(
        radarShape: RadarShape.polygon,
        tickCount: 4,
        ticksTextStyle: const TextStyle(color: Colors.black54, fontSize: 10),
        radarBorderData: const BorderSide(color: Colors.grey, width: 2),
        gridBorderData: const BorderSide(color: Colors.grey, width: 4),
        dataSets: [
          RadarDataSet(
            fillColor: const Color(0xFF874DB0).withOpacity(0.2),
            borderColor: const Color(0xFF874DB0),
            borderWidth: 5,
            entryRadius: 0,
            dataEntries: const [
              RadarEntry(value: 8.0), // Fragrance Aroma (บน)
              RadarEntry(value: 8.0), // Aroma (ขวาบน)
              RadarEntry(value: 8.0), // Flavor (ขวา)
              RadarEntry(value: 8.0), // Aftertaste (ขวาล่าง)
              RadarEntry(value: 8.0), // Acidity (ล่าง)
              RadarEntry(value: 8.0), // Sweetness (ซ้ายล่าง)
              RadarEntry(value: 8.0), // Mouthfeel (ซ้าย)
            ],
          ),
        ],
        getTitle: (index, angle) {
          // เรียงลำดับตามตำแหน่งในภาพ (เริ่มจากบน ตามเข็มนาฬิกา)
          final titles = [
            'Fragrance Aroma', // บน (index 0)
            'Aroma', // ขวาบน (index 1)
            'Flavor', // ขวา (index 2)
            'Aftertaste', // ขวาล่าง (index 3)
            'Acidity', // ล่าง (index 4)
            'Sweetness', // ซ้ายล่าง (index 5)
            'Mouthfeel', // ซ้าย (index 6)
          ];

          return RadarChartTitle(
            text: titles[index],
            angle: 0, // ตั้งค่า angle เป็น 0 เพื่อให้ text เรียงแนวนอนทั้งหมด
            positionPercentageOffset: 0.20,
          );
        },
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCuppingCard(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(left: 5, right: 15, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              'assets/images/coffee.png',
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cupping Session",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 8),
                const Divider(height: 1),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: secondaryColor2,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Start / End Date & Time",
                      style: TextStyle(fontSize: 11, color: secondaryColor2),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: secondaryColor2,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 11,
                            color: secondaryColor2,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor2,
                        minimumSize: const Size(80, 30),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: const Text(
                        "Read More",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: Image.asset(
                  "assets/images/coffee2.png",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 10),
                      SizedBox(width: 2),
                      Text(
                        "4.8",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Coffee Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF2ED),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Recommended",
                        style: TextStyle(
                          color: primaryColor2,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Color(0xFFC67C4E),
                        size: 10,
                      ),
                    ],
                  ),
                ),
                const Text(
                  "text",
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "XX",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: primaryColor2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
