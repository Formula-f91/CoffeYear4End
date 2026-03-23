import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── Wrapper Screen (จัดการการหมุนจอ) ──
class ComparisonResultScreen extends StatefulWidget {
  const ComparisonResultScreen({super.key});

  @override
  State<ComparisonResultScreen> createState() => _ComparisonResultScreenState();
}

class _ComparisonResultScreenState extends State<ComparisonResultScreen> {
  @override
  void initState() {
    super.initState();
    // อนุญาตให้หมุนจอได้ทั้งแนวตั้งและแนวนอน เพื่อให้เซ็นเซอร์ทำงาน
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // เมื่อกด Back ออกจากหน้านี้ ให้ล็อคกลับเป็นแนวตั้งเหมือนเดิม
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // 1. ถ้าโทรศัพท์ยังอยู่แนวตั้ง (Portrait) ให้แสดงหน้าจอสีดำแจ้งเตือน
        if (orientation == Orientation.portrait) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white), // ปุ่ม Back สีขาว
              elevation: 0,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ไอคอนหมุนจอ
                  const Icon(
                    Icons.screen_rotation_outlined,
                    color: Colors.white,
                    size: 80,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Rotate your phone to landscape mode.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 48),
                  // ปุ่มสำรองกรณีผู้ใช้ปิด "Auto-Rotate" ไว้ และต้องการบังคับหมุน
                  TextButton(
                    onPressed: () {
                      // บังคับเปลี่ยนเป็นแนวนอนทันที
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                    },
                    child: Text(
                      "Tap here to force landscape",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }

        // 2. ถ้าโทรศัพท์ถูกหมุนเป็นแนวนอน (Landscape) แล้ว ให้แสดงหน้ากราฟ
        return const ComparisonChartView();
      },
    );
  }
}


// ── Comparison Chart View (หน้าจอแสดงผลข้อมูลแนวนอนของจริง) ──
class ComparisonChartView extends StatelessWidget {
  const ComparisonChartView({super.key});

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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                valuesA: [0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75], 
                                valuesB: [0.90, 0.90, 0.90, 0.90, 0.90, 0.90, 0.90], 
                                labels: const [
                                  "Fragrance Aroma", "Aroma", "Flavor", 
                                  "Aftertaste", "Acidity", "Sweetness", "Mouthfeel"
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Legend
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLegendItem(const Color(0xFFE53935), "Cupping Session A"),
                            const SizedBox(height: 8),
                            _buildLegendItem(const Color(0xFF1E52C6), "Cupping Session B"),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Session Details (Data Table)
                    const Text(
                      "Session Details",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                            child: Text("Cupping Score", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          const Divider(height: 1),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
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
                                DataRow(cells: [
                                  DataCell(Text('Cupping Session A')),
                                  DataCell(Text('8.0')), DataCell(Text('8.0')), DataCell(Text('8.0')),
                                  DataCell(Text('8.0')), DataCell(Text('8.0')), DataCell(Text('8.0')),
                                  DataCell(Text('8.0')), DataCell(Text('56.0')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Cupping Session B')),
                                  DataCell(Text('9.0')), DataCell(Text('9.0')), DataCell(Text('9.0')),
                                  DataCell(Text('9.0')), DataCell(Text('9.0')), DataCell(Text('9.0')),
                                  DataCell(Text('9.0')), DataCell(Text('63.0')),
                                ]),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              "FA: Fragrance - AR: Aroma - FL: Flavor - AF: Aftertaste - AC: Acidity - SW: Sweetness - MO: Mouthfeel - TS: Total Score",
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Text("Back", style: TextStyle(color: Color(0xFF1E52C6), fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () { /* Print Action */ },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFF1A3A8F),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Text("Print", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                Text(title, style: TextStyle(color: titleColor, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text("Session Code: $code", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Start Date & Time: $startDate", style: const TextStyle(fontSize: 13)),
                Text("End Date & Time: $endDate", style: const TextStyle(fontSize: 13)),
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

// ── Comparison Radar Chart Painter ──
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
        if (i == 0) path.moveTo(x, y);
        else path.lineTo(x, y);
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // วาดเส้นรัศมี
    for (int i = 0; i < count; i++) {
      final angle = -pi / 2 + i * angleStep;
      canvas.drawLine(
        center,
        Offset(center.dx + radius * cos(angle), center.dy + radius * sin(angle)),
        gridPaint,
      );
    }

    // ฟังก์ชันช่วยวาดข้อมูลกราฟแต่ละชุด
    void drawDataSet(List<double> values, Color color) {
      final fillPaint = Paint()..color = color.withOpacity(0.2)..style = PaintingStyle.fill;
      final strokePaint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2.5;
      final dotPaint = Paint()..color = color..style = PaintingStyle.fill;

      final dataPath = Path();
      for (int i = 0; i < count; i++) {
        final angle = -pi / 2 + i * angleStep;
        final r = radius * values[i].clamp(0.0, 1.0);
        final x = center.dx + r * cos(angle);
        final y = center.dy + r * sin(angle);
        
        if (i == 0) dataPath.moveTo(x, y);
        else dataPath.lineTo(x, y);
      }
      dataPath.close();
      canvas.drawPath(dataPath, fillPaint);
      canvas.drawPath(dataPath, strokePaint);

      for (int i = 0; i < count; i++) {
        final angle = -pi / 2 + i * angleStep;
        final r = radius * values[i].clamp(0.0, 1.0);
        canvas.drawCircle(Offset(center.dx + r * cos(angle), center.dy + r * sin(angle)), 4, dotPaint);
      }
    }

    drawDataSet(valuesB, const Color(0xFF1E52C6));
    drawDataSet(valuesA, const Color(0xFFE53935));

    for (int i = 0; i < count; i++) {
      final angle = -pi / 2 + i * angleStep;
      final labelR = radius + 20;
      final x = center.dx + labelR * cos(angle);
      final y = center.dy + labelR * sin(angle);

      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.w500),
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