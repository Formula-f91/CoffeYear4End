import 'package:coffee/distributor/cuppingSessionPage.dart';
import 'package:coffee/profile/cupping/cuppingDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:coffee/home/reviewPage.dart';
import 'package:coffee/cupping/Combinedform/cupping_success_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:coffee/distributor/addProductPage.dart';
import 'package:coffee/constants.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // --- คำนวณ Aspect Ratio สำหรับ GridView ด้านล่างสุด ---
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth =
        (screenWidth - 40 - 15) / 2; // หัก Padding 20 ซ้ายขวา และ Spacing 15
    const double itemHeight = 220.0; // ล็อคความสูงรวมของการ์ดไว้ประมาณ 220
    final double dynamicAspectRatio = itemWidth / itemHeight;

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
          "Product",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                final Map<String, dynamic> currentProductData = {
                  'code': 'CF-888',
                  'name': 'Doi Chang Premium',
                  'type': 'Sales Sample',
                  'variety': 'Arabica',
                  'method': 'Washed',
                  'harvest_season': '2025/2026',
                  'description': 'High quality beans with chocolate notes.',
                  'lot_code': 'LOT-2025-A',
                  'harvest_date': '20/02/2026',
                  'quantity': '50',
                  'price': '450',
                };

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddCoffeeInfoPage(existingData: currentProductData),
                  ),
                );
              },
              child: Image.asset(
                'assets/icons/setting-2.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
      // SafeArea ช่วยป้องกันแถบ Navigation ด้านล่างสุดของเครื่องบังเนื้อหา
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
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
                      borderRadius: BorderRadius.circular(0),
                      border: index == 0
                          ? Border.all(color: const Color(0xFF083584), width: 2)
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
                        Flexible(
                          // กันชื่อยาวล้นจอ
                          child: Text(
                            "Coffee Name",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
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
                height: 380, // ปรับความสูงให้สัมพันธ์กับการ์ดด้านใน
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: screenWidth * 0.85, // กำหนดความกว้าง 85% ของจอ
                      child: _buildCuppingCard(context),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CuppingSessionPage(),
                        ),
                      );},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: Color(0xFF64B5F6),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              _buildSectionDivider("Review"),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width:
                          screenWidth *
                          0.9, // ลดลงนิดหน่อยเพื่อให้เห็นว่ามีใบถัดไปให้เลื่อน
                      child: _buildReviewItem(),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewsPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: Color(0xFF64B5F6),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              _buildSectionDivider("More Recommendations"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio:
                        dynamicAspectRatio, // ใช้สัดส่วนที่คำนวณอัตโนมัติ
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) => _buildProductCard(),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
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
          Flexible(
            child: Text(
              title,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
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
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  Widget _buildCuppingCard(BuildContext context) {
    return Container(
      // เอา Hardcode height: 287 และ width: 340 ออก ให้มันปรับตาม Parent
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // ให้หดความสูงตาม Content ภายใน
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
            child: Image.asset(
              'assets/images/coffee.png',
              height: 140, // ลดความสูงรูปลงเล็กน้อยให้รับกับมือถือจอเล็ก
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cupping Session",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/calendar.png',
                      width: 20,
                      height: 20,
                      color: secondaryColor2,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Start / End Date & Time",
                        style: TextStyle(color: primaryColor2, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      // ใส่ Expanded กันข้อความดันปุ่ม
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/location.png',
                            width: 20,
                            height: 20,
                            color: secondaryColor2,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Location",
                              style: TextStyle(
                                color: primaryColor2,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () { },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // พื้นหลังสีขาว
                        elevation: 0, // ลบเงาออกเพื่อให้ดูเป็นกรอบแบนๆ สวยงาม
                        side: BorderSide(
                          color: primaryColor2, // สีของเส้นขอบ
                          width: 1, // ความหนาของเส้น
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: primaryColor2 ,// เปลี่ยนสีตัวหนังสือเป็นสีเดียวกับขอบ
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () { Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CuppingDetailPage(),
                            ),
                          );},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:secondaryColor2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
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
    );
  }

  Widget _buildReviewItem() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Customer",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star_rounded,
                    color: Colors.orange,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
            style: TextStyle(
              color: Color(0xFF5C6B89),
              fontSize: 12,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                image: DecorationImage(
                  image: AssetImage("assets/images/coffee2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 14),
                        SizedBox(width: 4),
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
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Coffee Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      // รองรับหน้าจอแคบ
                      child: Text(
                        "Recommended",
                        style: TextStyle(
                          color: primaryColor2,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                 const Text(
                  "text",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end, // เปลี่ยนจาก spaceBetween เป็น end เพื่อดันข้อมูลไปขวาสุด
                    children: [
                      const Text(
                        "Price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF2F2D2C),
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

  Widget _buildRadarChart() {
    return RadarChart(
      RadarChartData(
        radarShape: RadarShape.polygon,
        tickCount: 4,
        dataSets: [
          RadarDataSet(
            fillColor: primaryColor2.withOpacity(0.2),
            borderColor: primaryColor2,
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
            dataEntries: List.generate(
              7,
              (index) => const RadarEntry(value: 9.0),
            ),
          ),
          RadarDataSet(
            fillColor: Colors.transparent,
            borderColor: Colors.transparent,
            entryRadius: 0,
            dataEntries: List.generate(
              7,
              (index) => const RadarEntry(value: 7.5),
            ),
          ),
        ],
        ticksTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        gridBorderData: const BorderSide(color: Color(0xFF333333), width: 2),
        radarBorderData: const BorderSide(color: Color(0xFF333333), width: 2),
        getTitle: (index, angle) {
          final titles = [
            'Fragrance Aroma',
            'Aroma',
            'Flavor',
            'Aftertaste',
            'Acidity',
            'Sweetness',
            'Mouthfeel',
          ];
          return RadarChartTitle(text: titles[index]);
        },
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
