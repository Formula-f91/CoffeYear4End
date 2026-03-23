import 'dart:math';
import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CoffeeEvaluationScreen extends StatefulWidget {
  const CoffeeEvaluationScreen({super.key});

  @override
  State<CoffeeEvaluationScreen> createState() => _CoffeeEvaluationScreenState();
}

class _CoffeeEvaluationScreenState extends State<CoffeeEvaluationScreen> {
  final Color themeColor = const Color(0xFFC67C4E);
  final Color headerBrown = const Color(0xFFC88A5F);
  final Color activeOrange = const Color(0xFFFF8D28);
  final Color defectRed = const Color(0xFFB3261E);
  final Color blueBar = const Color(0xFF1A3A8F);

  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Descriptive toggles
  bool _showFragranceAroma = true;
  bool _showFlavorAftertaste = true;
  bool _showTop10FlavorWheel = false;

  // Affective cup states
  final List<bool> _uniformCups = [false, false, false, false, false];
  final List<bool> _cleanCups = [false, false, false, false, false];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: secondaryColor2, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              "Back",
              style: TextStyle(
                color: secondaryColor2,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Header Card
            _buildHeaderCard(),
            const SizedBox(height: 16),

            // Additional Comments
            _buildAdditionalCommentsSection(),
            const SizedBox(height: 12),

            //  Descriptive Form
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Descriptive Form",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),

                  // Donut Chart
                  _buildDonutChartSection(),
                  const SizedBox(height: 24),

                  // Bar rows + flavor notes
                  _buildDetailBarRow("Fragrance", "8"),
                  _buildDetailBarRow("Aroma", "8"),
                  const Text(
                    "Floral, Fruity (Dried Fruit)",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailBarRow("Flavor", "8"),
                  _buildDetailBarRow("Aftertaste", "8"),
                  const Text(
                    "Floral (Dried Fruit), Sour/Fermented (Sour)",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Main Tastes : Salty",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailBarRow("Acidity", "8"),
                  _buildDetailBarRow("Sweetness", "8"),
                  _buildDetailBarRow("Mouthfeel", "8"),
                  const Text(
                    "Rough (Gritty, Chalky, Sandy)",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  _buildSimpleRow("Defects (if any)", "None"),
                  const SizedBox(height: 24),

                  // Session Result radar
                  const Text(
                    "Session Result",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 300,
                    child: CustomPaint(
                      painter: _RadarChartPainter(
                        values: [0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75],
                        labels: const [
                          "Fragrance Aroma",
                          "Aroma",
                          "Flavor",
                          "Aftertaste",
                          "Acidity",
                          "Sweetness",
                          "Mouthfeel",
                        ],
                      ),
                      child: Container(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 5. Affective Form
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Affective Form",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Bar rows (blue)
                  _buildBarRow("Fragrance", 5, 9),
                  _buildBarRow("Aroma", 5, 9),
                  _buildBarRow("Flavor", 5, 9),
                  _buildBarRow("Aftertaste", 5, 9),
                  _buildBarRow("Acidity", 5, 9),
                  _buildBarRow("Sweetness", 5, 9),
                  _buildBarRow("Mouthfeel", 5, 9),
                  _buildBarRow("Overall", 5, 9),

                  const SizedBox(height: 24),

                  // Non Uniform Cups
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Non Uniform Cups",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${_uniformCups.where((e) => e).length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      5,
                      (index) => _buildCupIconBtn(
                        index,
                        _uniformCups,
                        activeOrange,
                        () => setState(
                          () => _uniformCups[index] = !_uniformCups[index],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Defective Cups
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Defective Cups",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${_cleanCups.where((e) => e).length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      5,
                      (index) => _buildCupIconBtn(
                        index,
                        _cleanCups,
                        defectRed,
                        () => setState(
                          () => _cleanCups[index] = !_cleanCups[index],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Defect Type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Defect Type",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Moldy / Musty",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Total Score
                  const Center(
                    child: Text(
                      "Total Score : 61",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Session Result radar
                  const Text(
                    "Session Result",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 300,
                    child: CustomPaint(
                      painter: _RadarChartPainter(
                        values: [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5],
                        labels: const [
                          "Fragrance Aroma",
                          "Aroma",
                          "Flavor",
                          "Aftertaste",
                          "Acidity",
                          "Sweetness",
                          "Mouthfeel",
                        ],
                      ),
                      child: Container(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ── Donut Chart Section ──
  Widget _buildDonutChartSection() {
    final List<Map<String, dynamic>> segments = [];
    if (_showFragranceAroma) {
      segments.addAll([
        {'label': 'Fruity', 'count': 1, 'color': const Color(0xFFE53935)},
        {'label': 'Floral', 'count': 1, 'color': const Color(0xFFE91E8C)},
      ]);
    }
    if (_showFlavorAftertaste) {
      for (final s in [
        {'label': 'Fruity', 'count': 1, 'color': const Color(0xFFE53935)},
        {'label': 'Floral', 'count': 1, 'color': const Color(0xFFE91E8C)},
      ]) {
        if (!segments.any((e) => e['label'] == s['label'])) segments.add(s);
      }
    }

    final chips = <Widget>[];
    for (final seg in segments) {
      chips.add(
        Container(
          margin: const EdgeInsets.only(right: 8, bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: seg['color'] as Color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${seg['label']} (${seg['count']})',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (chips.isNotEmpty)
          Center(
            child: Wrap(alignment: WrapAlignment.center, children: chips),
          ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: segments.isEmpty
              ? const Center(
                  child: Text(
                    'No data to display',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : CustomPaint(
                  painter: _DonutChartPainter(segments: segments),
                  child: Container(),
                ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendCheckbox(
              label: 'Fragrance / Aroma',
              value: _showFragranceAroma,
              onChanged: (v) =>
                  setState(() => _showFragranceAroma = v ?? false),
            ),
            const SizedBox(width: 16),
            _buildLegendCheckbox(
              label: 'Flavor / Aftertaste',
              value: _showFlavorAftertaste,
              onChanged: (v) =>
                  setState(() => _showFlavorAftertaste = v ?? false),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Center(
          child: _buildLegendCheckbox(
            label: 'Top 10 Flavor Wheel',
            value: _showTop10FlavorWheel,
            onChanged: (v) =>
                setState(() => _showTop10FlavorWheel = v ?? false),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendCheckbox({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF1E52C6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(color: Colors.grey.shade400),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  Widget _buildCupIconBtn(
    int index,
    List<bool> list,
    Color activeColor,
    VoidCallback onTap,
  ) {
    final isActive = list[index];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? activeColor : Colors.white,
          border: Border.all(
            color: isActive ? activeColor : Colors.grey.shade300,
          ),
        ),
        child: Icon(
          Icons.local_cafe_outlined,
          color: isActive ? Colors.white : Colors.grey.shade400,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildBarRow(String label, int score, int maxScore) {
    final fraction = score / maxScore;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "$score",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(blueBar),
            ),
          ),
        ],
      ),
    );
  }

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
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.8,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(blueBar),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSimpleRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
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

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondaryColor2,
        borderRadius: BorderRadius.circular(0),
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

  Widget _buildAdditionalCommentsSection() {
    final List<Map<String, String>> comments = [
      {
        "name": "John Doe",
        "comment":
            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      },
      {
        "name": "Jane Smith",
        "comment":
            "This coffee has excellent aroma with hints of chocolate and caramel. The aftertaste is smooth and pleasant.",
      },
      {
        "name": "Mike Wilson",
        "comment":
            "Good balance of acidity and sweetness. Fruity notes are very pronounced. Would recommend!",
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
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
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
          child: PieChart(
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
        ),
        const SizedBox(height: 16),
        const Text(
          "Total Score : 61",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

// ── Donut Chart Painter ──
class _DonutChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> segments;
  const _DonutChartPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    if (segments.isEmpty) return;
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = min(size.width, size.height) / 2 - 10;
    final innerRadius = outerRadius * 0.6;
    final total = segments.fold<int>(0, (sum, s) => sum + (s['count'] as int));
    double startAngle = -pi / 2;
    const gap = 0.03;

    for (final seg in segments) {
      final count = seg['count'] as int;
      final color = seg['color'] as Color;
      final label = seg['label'] as String;
      final sweep = (count / total) * 2 * pi - gap;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = outerRadius - innerRadius
        ..strokeCap = StrokeCap.butt;
      final arcR = (innerRadius + outerRadius) / 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: arcR),
        startAngle,
        sweep,
        false,
        paint,
      );
      final labelAngle = startAngle + sweep / 2;
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 80);
      tp.paint(
        canvas,
        Offset(
          center.dx + arcR * cos(labelAngle) - tp.width / 2,
          center.dy + arcR * sin(labelAngle) - tp.height / 2,
        ),
      );
      startAngle += sweep + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ── Radar Chart Painter ──
class _RadarChartPainter extends CustomPainter {
  final List<double> values;
  final List<String> labels;
  const _RadarChartPainter({required this.values, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 44;
    final count = values.length;
    final angleStep = (2 * pi) / count;

    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int level = 1; level <= 5; level++) {
      final r = radius * level / 5;
      final path = Path();
      for (int i = 0; i < count; i++) {
        final angle = -pi / 2 + i * angleStep;
        final x = center.dx + r * cos(angle);
        final y = center.dy + r * sin(angle);
        if (i == 0)
          path.moveTo(x, y);
        else
          path.lineTo(x, y);
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    for (int i = 0; i < count; i++) {
      final angle = -pi / 2 + i * angleStep;
      canvas.drawLine(
        center,
        Offset(
          center.dx + radius * cos(angle),
          center.dy + radius * sin(angle),
        ),
        gridPaint,
      );
    }

    final fillPaint = Paint()
      ..color = const Color(0xFF9B59B6).withOpacity(0.2)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = const Color(0xFF9B59B6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final dataPath = Path();
    for (int i = 0; i < count; i++) {
      final angle = -pi / 2 + i * angleStep;
      final r = radius * values[i].clamp(0.0, 1.0);
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);
      if (i == 0)
        dataPath.moveTo(x, y);
      else
        dataPath.lineTo(x, y);
    }
    dataPath.close();
    canvas.drawPath(dataPath, fillPaint);
    canvas.drawPath(dataPath, strokePaint);

    final dotPaint = Paint()
      ..color = const Color(0xFF9B59B6)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < count; i++) {
      final angle = -pi / 2 + i * angleStep;
      final r = radius * values[i].clamp(0.0, 1.0);
      canvas.drawCircle(
        Offset(center.dx + r * cos(angle), center.dy + r * sin(angle)),
        4,
        dotPaint,
      );
    }

    for (int i = 0; i < count; i++) {
      final angle = -pi / 2 + i * angleStep;
      final labelR = radius + 30;
      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 72);
      tp.paint(
        canvas,
        Offset(
          center.dx + labelR * cos(angle) - tp.width / 2,
          center.dy + labelR * sin(angle) - tp.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
