import 'dart:math';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Descriptive/descriptive_pdf_generator.dart';
import 'package:coffee/cupping/Descriptive/session_result_pdf.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:coffee/distributor_firstPage.dart';
import 'package:coffee/farm/farm_first_page.dart';
import 'package:coffee/firstPage.dart';
import 'package:coffee/roaster_firstPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // เพิ่ม import นี้สำหรับการบังคับแนวนอน
import 'package:provider/provider.dart';

class DescriptiveChart extends StatefulWidget {
  const DescriptiveChart({super.key});

  @override
  State<DescriptiveChart> createState() => _DescriptiveChartState();
}

class _DescriptiveChartState extends State<DescriptiveChart> {
  final Color activeOrange = const Color(0xFFFF8D28);
  final Color defectRed = const Color(0xFFB3261E);
  final Color blueBar = const Color(0xFF1A3A8F);

  bool _showFragranceAroma = true;
  bool _showFlavorAftertaste = true;
  bool _showTop10FlavorWheel = false;

  // ── Compare Sessions Bottom Sheet ──
  void _showCompareSessionsSheet(BuildContext context) {
    final List<Map<String, dynamic>> sessions = [
      {
        "name": "Cupping Event",
        "code": "CUP - 123",
        "desc": "xxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxx",
        "location": "Location",
        "status": "Upcoming",
        "selected": true,
      },
      {
        "name": "Cupping Event",
        "code": "CUP - 111",
        "desc": "xxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxx",
        "location": "Location",
        "status": "Upcoming",
        "selected": false,
      },
      {
        "name": "Cupping Event",
        "code": "CUP - 124",
        "desc": "xxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxx",
        "location": "Location",
        "status": "Upcoming",
        "selected": false,
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.75,
              minChildSize: 0.5,
              maxChildSize: 0.92,
              expand: false,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    // Handle bar
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 4),
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Select Cupping Session",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.close, size: 24),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Session List
                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: sessions.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final session = sessions[index];
                          final isSelected = session["selected"] as bool;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Checkbox & Tapping logic
                                GestureDetector(
                                  onTap: () {
                                    if (isSelected) {
                                      // ถ้ารายการนี้ถูกเลือกอยู่แล้ว และกดซ้ำ นำทางไปหน้า Comparison
                                      Navigator.pop(
                                        context,
                                      ); // ปิด bottom sheet ก่อน
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ComparisonResultScreen(),
                                        ),
                                      );
                                    } else {
                                      // ถ้ายังไม่ถูกเลือก ให้เลือก
                                      setSheetState(() {
                                        sessions[index]["selected"] = true;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    margin: const EdgeInsets.only(
                                      top: 4,
                                      right: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF1E3A8A)
                                          : Colors.white,
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF1E3A8A)
                                            : Colors.grey.shade400,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          )
                                        : null,
                                  ),
                                ),
                                // Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        session["name"] as String,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "Seseion Code : ${session["code"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        session["desc"] as String,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 16,
                                            color: secondaryColor2,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            session["location"] as String,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: secondaryColor2,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Status badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    session["status"] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CuppingProvider>(
      builder: (context, provider, child) {
        final cupData = provider.currentCupData;
        final currentCupNum = provider.currentCupNumber;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text(
              "Descriptive From",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
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
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        await DescriptivePdfGenerator.generateAndPreview(
                          cupData,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: secondaryColor2,
                        side: BorderSide(color: primaryColor2, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Export PDF",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Widget destination;
                        switch (provider.currentRole) {
                          case UserRole.producer:
                            destination = const FarmFirstPage();
                            break;
                          case UserRole.distributor:
                            destination = const DistributorFirstPage();
                            break;
                          // เพิ่มเงื่อนไขสำหรับ Roaster ตรงนี้
                          case UserRole.roaster:
                            destination = const RoasterFirstpage();
                            break;
                          case UserRole.consumer:
                          default:
                            destination = const FirstPage();
                            break;
                        }

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => destination),
                          (route) => false,
                        );
                      },
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
                ],
              ),
            ),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderCard(),
                const SizedBox(height: 16),

                _buildCoffeeInfoCard(provider, cupData, currentCupNum),
                const SizedBox(height: 24),

                const SizedBox(height: 16),

                _buildDonutChartSection(),
                const SizedBox(height: 24),

                _buildBarRow("Fragrance", 5, 9),
                _buildBarRow("Aroma", 5, 9),
                _buildBarRow("Flavor", 5, 9),
                _buildBarRow("Aftertaste", 5, 9),
                _buildBarRow("Acidity", 5, 9),
                _buildBarRow("Sweetness", 5, 9),
                _buildBarRow("Mouthfeel", 5, 9),
                _buildBarRow("Overall", 5, 9),

                const SizedBox(height: 24),

                const Text(
                  "Session Result",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 300,
                  child: CustomPaint(
                    painter: _RadarChartPainter(
                      values: [
                        cupData.fragrance / 10,
                        cupData.aroma / 10,
                        cupData.flavor / 10,
                        cupData.aftertaste / 10,
                        cupData.acidity / 10,
                        cupData.sweetness / 10,
                        cupData.mouthfeel / 10,
                      ],
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

                const SizedBox(height: 20),

                // ── Export + Compare Sessions buttons ──
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 166,
                        height: 35,
                        child: OutlinedButton(
                          onPressed: () async {
                            await SessionResultPdfGenerator.generateAndPreview(
                              cupData,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primaryColor2, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            "Export",
                            style: TextStyle(
                              color: primaryColor2,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                      if (provider.currentRole != UserRole.consumer) ...[
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () => _showCompareSessionsSheet(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor2,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            child: const Text(
                              "Compare Sessions",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

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
        if (!segments.any((e) => e['label'] == s['label'])) {
          segments.add(s);
        }
      }
    }

    final chips = <Widget>[];
    for (final seg in segments) {
      final color = seg['color'] as Color;
      final label = seg['label'] as String;
      final count = seg['count'] as int;
      chips.add(
        Container(
          margin: const EdgeInsets.only(right: 8, bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$label ($count)',
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
        const SizedBox(height: 8),
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

  Widget _buildCoffeeInfoCard(
    CuppingProvider provider,
    CupData cupData,
    int currentCupNum,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Coffee Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Roast level",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),

              _buildDivider(),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const Text("Total Score", style: TextStyle(fontSize: 13)),
                    Text(
                      cupData.totalScore.toStringAsFixed(0),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Select coffee",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              final cupNum = index + 1;
              final isSelected = currentCupNum == cupNum;
              return GestureDetector(
                onTap: () => provider.selectCup(cupNum),
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? secondaryColor2 : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? secondaryColor2
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "$cupNum",
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon/shopping.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Place an order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => Container(
    height: 36,
    width: 1,
    color: primaryColor2,
    margin: const EdgeInsets.symmetric(horizontal: 10),
  );

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(12),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Descriptive Assessment",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  "Name : xxxxxxx  |  Date : 26.01.23",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
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
    final gap = 0.03;

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
      final lx = center.dx + arcR * cos(labelAngle);
      final ly = center.dy + arcR * sin(labelAngle);

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

      tp.paint(canvas, Offset(lx - tp.width / 2, ly - tp.height / 2));

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
      final x = center.dx + labelR * cos(angle);
      final y = center.dy + labelR * sin(angle);

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

      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ── Comparison Result Screen (Landscape) ──
class ComparisonResultScreen extends StatefulWidget {
  const ComparisonResultScreen({super.key});

  @override
  State<ComparisonResultScreen> createState() => _ComparisonResultScreenState();
}

class _ComparisonResultScreenState extends State<ComparisonResultScreen> {
  @override
  void initState() {
    super.initState();
    // บังคับให้เป็นแนวนอนเมื่อเข้ามาหน้านี้
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // คืนค่ากลับเป็นอิสระ/แนวตั้งเมื่อออกจากหน้านี้
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Comparison Result",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Session A Card
                    _buildSessionInfoCard(
                      title: "Cupping Session A",
                      titleColor: const Color(0xFFE53935), // แดง
                      code: "CUP-1234",
                      startDate: "31/3/2026, 00:00",
                      endDate: "31/3/2026, 03:00",
                    ),
                    const SizedBox(height: 12),

                    // Session B Card
                    _buildSessionInfoCard(
                      title: "Cupping Session B",
                      titleColor: const Color(0xFF1E52C6), // น้ำเงิน
                      code: "CUP-5678",
                      startDate: "31/3/2026, 00:00",
                      endDate: "31/3/2026, 03:00",
                    ),

                    const SizedBox(height: 32),

                    // Radar Chart Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 350,
                            child: CustomPaint(
                              painter: _ComparisonRadarChartPainter(
                                valuesA: [
                                  0.75,
                                  0.75,
                                  0.75,
                                  0.75,
                                  0.75,
                                  0.75,
                                  0.75,
                                ], // ข้อมูลสมมติ Session A (สีแดง)
                                valuesB: [
                                  0.90,
                                  0.90,
                                  0.90,
                                  0.90,
                                  0.90,
                                  0.90,
                                  0.90,
                                ], // ข้อมูลสมมติ Session B (สีน้ำเงิน)
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
                            ),
                          ),
                        ),
                        // Legend
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLegendItem(
                              const Color(0xFFE53935),
                              "Cupping Session A",
                            ),
                            const SizedBox(height: 8),
                            _buildLegendItem(
                              const Color(0xFF1E52C6),
                              "Cupping Session B",
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Session Details (Data Table)
                    const Text(
                      "Session Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Cupping Score",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(height: 1),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              columns: const [
                                DataColumn(label: Text('Cupping Session')),
                                DataColumn(label: Text('FA')),
                                DataColumn(label: Text('AR')),
                                DataColumn(label: Text('FL')),
                                DataColumn(label: Text('AF')),
                                DataColumn(label: Text('AC')),
                                DataColumn(label: Text('SW')),
                                DataColumn(label: Text('MO')),
                                DataColumn(label: Text('TS')),
                              ],
                              rows: const [
                                DataRow(
                                  cells: [
                                    DataCell(Text('Cupping Session A')),
                                    DataCell(Text('8.0')),
                                    DataCell(Text('8.0')),
                                    DataCell(Text('8.0')),
                                    DataCell(Text('8.0')),
                                    DataCell(Text('8.0')),
                                    DataCell(Text('8.0')),
                                    DataCell(Text('8.0')),
                                    DataCell(Text('56.0')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Cupping Session B')),
                                    DataCell(Text('9.0')),
                                    DataCell(Text('9.0')),
                                    DataCell(Text('9.0')),
                                    DataCell(Text('9.0')),
                                    DataCell(Text('9.0')),
                                    DataCell(Text('9.0')),
                                    DataCell(Text('9.0')),
                                    DataCell(Text('63.0')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              "FA: Fragrance - AR: Aroma - FL: Flavor - AF: Aftertaste - AC: Acidity - SW: Sweetness - MO: Mouthfeel - TS: Total Score",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFF1E52C6)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          color: Color(0xFF1E52C6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        /* Print Action */
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFF1A3A8F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        "Print",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionInfoCard({
    required String title,
    required Color titleColor,
    required String code,
    required String startDate,
    required String endDate,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Session Code: $code",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Start Date & Time: $startDate",
                  style: const TextStyle(fontSize: 13),
                ),
                Text(
                  "End Date & Time: $endDate",
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// ── Comparison Radar Chart Painter (วาดเส้น 2 เส้น แดง/น้ำเงิน) ──
class _ComparisonRadarChartPainter extends CustomPainter {
  final List<double> valuesA;
  final List<double> valuesB;
  final List<String> labels;

  const _ComparisonRadarChartPainter({
    required this.valuesA,
    required this.valuesB,
    required this.labels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 40;
    final count = labels.length;
    final angleStep = (2 * pi) / count;

    final gridPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // วาดใยแมงมุม (Grid)
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

    // วาดเส้นรัศมี
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

    // ฟังก์ชันช่วยวาดข้อมูลกราฟแต่ละชุด
    void drawDataSet(List<double> values, Color color) {
      final fillPaint = Paint()
        ..color = color.withOpacity(0.2)
        ..style = PaintingStyle.fill;
      final strokePaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      final dotPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

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

      for (int i = 0; i < count; i++) {
        final angle = -pi / 2 + i * angleStep;
        final r = radius * values[i].clamp(0.0, 1.0);
        canvas.drawCircle(
          Offset(center.dx + r * cos(angle), center.dy + r * sin(angle)),
          4,
          dotPaint,
        );
      }
    }

    // วาดข้อมูล Session B (น้ำเงิน) ก่อน เพื่อให้อยู่ด้านหลัง
    drawDataSet(valuesB, const Color(0xFF1E52C6));
    // วาดข้อมูล Session A (แดง) ทับด้านหน้า
    drawDataSet(valuesA, const Color(0xFFE53935));

    // วาด Label รอบๆ กราฟ
    for (int i = 0; i < count; i++) {
      final angle = -pi / 2 + i * angleStep;
      final labelR = radius + 20;
      final x = center.dx + labelR * cos(angle);
      final y = center.dy + labelR * sin(angle);

      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 80);

      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
