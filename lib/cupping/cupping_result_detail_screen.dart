import 'package:coffee/constants.dart';
import 'package:coffee/cupping/additional_comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'flavour_mock.dart';

class CuppingResultDetailScreen extends StatefulWidget {
  const CuppingResultDetailScreen({super.key});

  @override
  State<CuppingResultDetailScreen> createState() =>
      _CuppingResultDetailScreenState();
}

class _CuppingResultDetailScreenState extends State<CuppingResultDetailScreen> {
  // 0 = Sample Overview, 1 = Individual Tasting Report
  int _selectedTabIndex = 0;

  // ตัวแปรเช็คว่ากำลังดู Profile รายบุคคลอยู่หรือไม่ (เฉพาะใน Tab 1)
  bool _showProfileDetail = false;

  final List<FlavorMock> parentData = [
    FlavorMock('Fruity', 3, Colors.red),
    FlavorMock('Sour/Fermented', 5, Colors.yellow.shade800),
    FlavorMock('Floral', 4, Colors.pink),
    FlavorMock(
      'Empty Space',
      3,
      Colors.transparent,
    ), // To create the "cut-out" effect
  ];

  final List<FlavorMock> childData = [
    FlavorMock('Citrus Fruit', 3, Colors.orange), // Matches 'Fruity'
    FlavorMock('Sour', 5, Colors.yellow.shade600), // Matches 'Sour/Fermented'
    FlavorMock(
      '',
      4,
      Colors.transparent,
    ), // Floral has no outer child in the pic
    FlavorMock('', 3, Colors.transparent), // Matches the empty space
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Results",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header (แสดงตลอด) ---
                  _buildHeaderCard(),
                  const SizedBox(height: 16),

                  // --- Tabs Switcher (แสดงตลอด) ---
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        _buildTabItem("Sample Overview", 0),
                        _buildTabItem("Individual Tasting Report", 1),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Conditional Content (เปลี่ยนเนื้อหาตาม State) ---
                  _buildContent(),
                ],
              ),
            ),
          ),

          // --- Bottom Button ---
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // ถ้าอยู่ในหน้า Profile ให้กด Back แล้วกลับไปหน้ารายชื่อก่อน
                  if (_selectedTabIndex == 1 && _showProfileDetail) {
                    setState(() {
                      _showProfileDetail = false;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: secondaryColor2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  "Back",
                  style: TextStyle(color: secondaryColor2, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Logic การเลือก Content ที่จะแสดง ---
  Widget _buildContent() {
    if (_selectedTabIndex == 0) {
      return _buildSampleOverview();
    } else {
      // Tab 1: Individual Tasting Report
      if (_showProfileDetail) {
        return _buildCupperProfileDetail(); // แสดงหน้า Profile (Layout ตามภาพ)
      } else {
        return _buildIndividualTastingList(); // แสดงหน้ารายชื่อ (List)
      }
    }
  }

  // --- Widget สำหรับสร้าง Tab ---
  Widget _buildTabItem(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
            _showProfileDetail = false; // Reset กลับมารายชื่อทุกครั้งที่กด Tab
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isSelected ? Colors.black : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // VIEW 1: Sample Overview
  // ==========================================
  Widget _buildSampleOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Chart Container ---
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFlavorTag("Floral (2)", Colors.pinkAccent),
                  const SizedBox(width: 8),
                  _buildFlavorTag("Sour (0)", Colors.amber),
                  const SizedBox(width: 8),
                  _buildFlavorTag("Citrus Fruit (0)", Colors.lightGreen),
                ],
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 200,
                width: 200,
                child: SfCircularChart(
                  series: <CircularSeries>[
                    // INNER RING
                    DoughnutSeries<FlavorMock, String>(
                      dataSource: parentData,
                      xValueMapper: (data, _) => data.name,
                      yValueMapper: (data, _) => data.value,
                      pointColorMapper: (data, _) => data.color,
                      innerRadius: '40%',
                      radius: '70%',
                      startAngle:
                          270, // Adjust this to rotate the chart like the pic
                      endAngle: 270,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside,
                        textStyle: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                    // OUTER RING
                    DoughnutSeries<FlavorMock, String>(
                      dataSource: childData,
                      xValueMapper: (data, _) => data.name,
                      yValueMapper: (data, _) => data.value,
                      pointColorMapper: (data, _) => data.color,
                      innerRadius: '70%',
                      radius: '100%',
                      startAngle: 270,
                      endAngle: 270,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside,
                      ),
                      //strokeColor: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSmallCheckbox("Fragrance / Aroma", true),
                  const SizedBox(width: 12),
                  _buildSmallCheckbox("Flavor / Aftertaste", true),
                ],
              ),
              _buildSmallCheckbox("Top 10 Flavor Wheel", false),

              const SizedBox(height: 16),
              const Text(
                "Total Score : N/A",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildScoreRow("Fragrance", "8"),
        _buildScoreRow("Aroma", "8"),
        _buildScoreRow("Flavor", "8"),
        _buildScoreRow("Aftertaste", "8"),
        _buildScoreRow("Acidity", "8"),
        _buildScoreRow("Sweetness", "8"),
        _buildScoreRow("Mouthfeel", "8"),

        const SizedBox(height: 24),

        const Text(
          "Additional Comments",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCommentCard(
                "NAME 1",
                "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxx",
              ),
              const SizedBox(width: 12),
              _buildCommentCard(
                "NAME 2",
                "Great coffee with fruity notes.\nVery balanced.",
              ),
              const SizedBox(width: 12),
              _buildCommentCard(
                "NAME 3",
                "Slightly acidic but good body.\nClean finish.",
              ),
            ],
          ),
        ),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Navigate ไปยังหน้า AdditionalCommentsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdditionalCommentsScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // VIEW 2.1: Individual Tasting List (รายการรายชื่อ)
  // ==========================================
  Widget _buildIndividualTastingList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Descriptive Assessment",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),

        _buildCupperCard(
          "Name xxxxxxxxxxxx",
          "Cupping session owner",
          true,
        ), // Owner
        const SizedBox(height: 12),
        _buildCupperCard("Name xxxxxxxxxxxx", "Guest cupper", false),
        const SizedBox(height: 12),
        _buildCupperCard("Name xxxxxxxxxxxx", "Guest cupper", false),
        const SizedBox(height: 12),
        _buildCupperCard("Name xxxxxxxxxxxx", "Guest cupper", false),
        const SizedBox(height: 12),
        _buildCupperCard("Name xxxxxxxxxxxx", "Guest cupper", false),
      ],
    );
  }

  // ==========================================
  // VIEW 2.2: Cupper Profile Detail (หน้ารายละเอียดเมื่อกดการ์ด)
  // ==========================================
  Widget _buildCupperProfileDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Profile Header ---
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:  primaryColor2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.face, color: Colors.blue, size: 30),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Name xxxxxxxxxxxx",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Cupping session owner",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // --- Score Bars Section ---
        _buildScoreBarItem("Fragrance", 8, null),
        _buildScoreBarItem("Aroma", 8, null),
        const Text(
          "Floral, Fruity (Dried Fruit)",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),

        _buildScoreBarItem("Flavor", 8, null),
        _buildScoreBarItem("Aftertaste", 8, null),
        const Text(
          "Floral(Dried Fruit), Sour/Fermented(Sour)",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        const Text(
          "Main Tastes : Salty",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 16),

        _buildScoreBarItem("Acidity", 8, null),
        _buildScoreBarItem("Sweetness", 8, null),
        _buildScoreBarItem("Mouthfeel", 8, null),
        const Text(
          "Rough (Gritty, Chalky, Sandy)",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 16),
        _buildInfoRow("Defects (if any)", "None"),

        const SizedBox(height: 16),
        const Text(
          "Additional Comments",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxx",
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),

        const SizedBox(height: 24),

        // --- Chart Section (Same as previous screen) ---
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              // Flavor Tags
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFlavorTag("Floral (2)", Colors.pinkAccent),
                  const SizedBox(width: 8),
                  _buildFlavorTag("Sour (0)", Colors.amber),
                  const SizedBox(width: 8),
                  _buildFlavorTag("Citrus Fruit (0)", Colors.lightGreen),
                ],
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/photo/groupchart.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSmallCheckbox("Fragrance / Aroma", true),
                  const SizedBox(width: 12),
                  _buildSmallCheckbox("Flavor / Aftertaste", true),
                ],
              ),
              _buildSmallCheckbox("Top 10 Flavor Wheel", false),

              const SizedBox(height: 16),
              const Text(
                "Total Score : N/A",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // --- Bottom Scores ---
        _buildScoreRow("Fragrance", "8"),
        _buildScoreRow("Aroma", "8"),
        _buildScoreRow("Flavor", "8"),
        _buildScoreRow("Aftertaste", "8"),
        _buildScoreRow("Acidity", "8"),
        _buildScoreRow("Sweetness", "8"),
        _buildScoreRow("Mouthfeel", "8"),
      ],
    );
  }

  // --- Helper Widgets ---

  // Widget การ์ดผู้ชิม (Clickable)
  Widget _buildCupperCard(String name, String role, bool isOwner) {
    return GestureDetector(
      onTap: () {
        // เมื่อกดการ์ด ให้เปลี่ยน state เพื่อแสดงหน้า Profile Detail
        setState(() {
          _showProfileDetail = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primaryColor2, // สีพื้นหลังน้ำตาล
          borderRadius: BorderRadius.circular(16),
          border: isOwner
              ? Border.all(color: Colors.blue.withOpacity(0.3), width: 1)
              : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: isOwner
                  ? const Icon(Icons.face, color: Colors.blue, size: 30)
                  : const Icon(Icons.face, color: Colors.black87, size: 30),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            // if (isOwner) const Spacer(),
            // if (isOwner)
            //    Container(
            //      padding: const EdgeInsets.all(4),
            //      decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            //      child: const Text("G", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            //    )
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/photo/coffepro.png'),
            backgroundColor: Colors.white,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Descriptive Assessment",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "Name : xxxxxx",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    height: 12,
                    width: 1,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  Text(
                    "Date : 26.01.23",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Bar คะแนนสีน้ำตาลในหน้า Profile
  Widget _buildScoreBarItem(String title, int score, String? description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                score.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Progress Bar
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5EFE6), // สีพื้นหลังจางๆ
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: score / 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor2, // สีน้ำตาล
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildFlavorTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCommentCard(String name, String comment) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Color(0xFFC88A5F),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              comment,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCheckbox(String text, bool isChecked) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: isChecked,
            activeColor: const Color(0xFFC88A5F),
            onChanged: (val) {},
            side: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildScoreRow(String title, String score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            score,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
