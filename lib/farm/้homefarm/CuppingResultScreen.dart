import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CuppingResultScreen extends StatefulWidget {
  const CuppingResultScreen({super.key});

  @override
  State<CuppingResultScreen> createState() => _CuppingResultScreenState();
}

class _CuppingResultScreenState extends State<CuppingResultScreen> {
  final Color themeColor = const Color(0xFFC67C4E);
  final Color headerBrown = const Color(0xFFC88A5F);

  // สำหรับควบคุม PageView
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Result",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 1. Header Card
                  _buildHeaderCard(),
                  const SizedBox(height: 16),

                  // Additional Comments Section แบบเลื่อนซ้าย-ขวาได้
                  _buildAdditionalCommentsSection(),

                  const SizedBox(height: 16),

                  // 2. Combined Assessment Card (Chart & Scores)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildChartSummaryBox(),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Divider(height: 1),
                        ),
                        _buildFinalScoreRow("Fragrance", "8"),
                        _buildFinalScoreRow("Aroma", "8"),
                        _buildFinalScoreRow("Flavor", "8"),
                        _buildFinalScoreRow("Aftertaste", "8"),
                        _buildFinalScoreRow("Acidity", "8"),
                        _buildFinalScoreRow("Sweetness", "8"),
                        _buildFinalScoreRow("Mouthfeel", "8"),
                        _buildFinalScoreRow("Overall", "5"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- 3. กล่อง Descriptive Form (เพิ่มใหม่) ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Descriptive Form",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailBarRow("Fragrance", "8"),
                        _buildDetailBarRow("Aroma", "8"),
                        const Text(
                          "Floral, Fruity (Dried Fruit)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildDetailBarRow("Flavor", "8"),
                        _buildDetailBarRow("Aftertaste", "8"),
                        const Text(
                          "Floral (Dried Fruit), Sour/Fermented (Sour)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Main Tastes : Salty",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailBarRow("Acidity", "8"),
                        _buildDetailBarRow("Sweetness", "8"),
                        _buildDetailBarRow("Mouthfeel", "8"),
                        const Text(
                          "Rough (Gritty, Chalky, Sandy)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildSimpleRow("Defects (if any)", "None"),
                        const SizedBox(height: 16),
                        const Text(
                          "Additional Comments",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const Text(
                          "Note: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- 4. กล่อง Affective Form (เพิ่มใหม่) ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Affective Form",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildAffectiveInfo(
                          "Fragrance",
                          "Neither high nor low",
                          "5",
                        ),
                        _buildAffectiveInfo(
                          "Aroma",
                          "Neither high nor low",
                          "5",
                        ),
                        const Text(
                          "Note : None",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),

                        _buildAffectiveInfo(
                          "Flavor",
                          "Neither high nor low",
                          "5",
                        ),
                        _buildAffectiveInfo(
                          "Aftertaste",
                          "Neither high nor low",
                          "5",
                        ),
                        const Text(
                          "Note : None",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),

                        _buildAffectiveInfo(
                          "Acidity",
                          "Neither high nor low",
                          "5",
                        ),
                        _buildAffectiveInfo(
                          "Sweetness",
                          "Neither high nor low",
                          "5",
                        ),
                        _buildAffectiveInfo(
                          "Mouthfeel",
                          "Neither high nor low",
                          "5",
                        ),
                        _buildAffectiveInfo(
                          "Overall",
                          "Neither high nor low",
                          "5",
                        ),

                        const SizedBox(height: 12),
                        _buildSimpleRow("Non Uniform Cups", "-10"),
                        _buildSimpleRow("Defective Cups", "-4"),
                        const Text(
                          "Defect : Moldy",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Helpers ที่เพิ่มใหม่ (คัดลอกจาก code1) ---

  Widget _buildDetailBarRow(String title, String score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                score,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5EFE6),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildAffectiveInfo(String title, String status, String score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(status, style: TextStyle(fontSize: 13, color: themeColor)),
              ],
            ),
          ),
          Text(
            score,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // --- Widgets เดิม ---

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
                "Combined Assessment",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Name : xxxxxx  |  Date : 26.01.23",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Additional Comments Section พร้อม PageView เลื่อนซ้าย-ขวา ---
  Widget _buildAdditionalCommentsSection() {
    // สร้างข้อมูล Comments แบบ Mock (สามารถแทนที่ด้วยข้อมูลจริง)
    final List<Map<String, String>> comments = [
      {
        "name": "John Doe",
        "comment":
            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      },
      {
        "name": "Jane Smith",
        "comment":
            "This coffee has excellent aroma with hints of chocolate "
            "and caramel. The aftertaste is smooth and pleasant.",
      },
      {
        "name": "Mike Wilson",
        "comment":
            "Good balance of acidity and sweetness. "
            "Fruity notes are very pronounced. Would recommend!",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            "Additional Comments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // PageView สำหรับเลื่อนซ้าย-ขวา
        SizedBox(
          height: 180, // กำหนดความสูงของ Card
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comments[index]["name"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F3542),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            comments[index]["comment"]!,
                            style: const TextStyle(
                              color: Color(0xFF57606F),
                              height: 1.5,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Page Indicator และปุ่ม View All
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Dot Indicators

            // ปุ่ม View All
            TextButton(
              onPressed: () {
                // TODO: Navigate to full comments page
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFE1F5FE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                minimumSize: const Size(0, 32),
              ),
              child: const Text(
                "View All",
                style: TextStyle(
                  color: Color(0xFF03A9F4),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChartSummaryBox() {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFlavorTag("Floral (2)", Colors.pinkAccent),
            _buildFlavorTag("Sour (0)", const Color(0xFFC6D53F)),
            _buildFlavorTag("Citrus Fruit (1)", const Color(0xFFFBB03B)),
          ],
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 75,
                  sections: [
                    PieChartSectionData(
                      color: const Color(0xFFFBB03B),
                      value: 35,
                      title: 'Citrus',
                      radius: 30,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.pinkAccent,
                      value: 20,
                      title: 'Floral',
                      radius: 30,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: const Color(0xFFC6D53F),
                      value: 30,
                      title: 'Sour',
                      radius: 30,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Total Score : 61",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildFinalScoreRow(String title, String score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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

  Widget _buildFlavorTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
