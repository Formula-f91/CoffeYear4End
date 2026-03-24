// lib/cupping/Affective/affective_chart_screen.dart
import 'dart:math';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Affective/affective_form_data.dart';
import 'package:coffee/cupping/Affective/affective_provider.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';

class AffectiveChartScreen extends StatefulWidget {
  final AffectiveProvider provider;

  const AffectiveChartScreen({super.key, required this.provider});

  @override
  State<AffectiveChartScreen> createState() => _AffectiveChartScreenState();
}

class _AffectiveChartScreenState extends State<AffectiveChartScreen> {
  late int _selectedSampleIndex;

  final Color _orange  = const Color(0xFFFF8D28);
  final Color _red     = const Color(0xFFB3261E);
  final Color _barBlue = const Color(0xFF1A3A8F);

  @override
  void initState() {
    super.initState();
    _selectedSampleIndex = 0;
  }

  AffectiveFormData? get _data =>
      widget.provider.allDataForIndex(_selectedSampleIndex);

  SampleModel? get _sample =>
      widget.provider.session?.samples[_selectedSampleIndex];

  @override
  Widget build(BuildContext context) {
    final session  = widget.provider.session;
    final data     = _data;
    final sample   = _sample;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Affective Form",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
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
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(widget.provider),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: secondaryColor2, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text("Done",
                    style: TextStyle(
                        color: secondaryColor2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ]),
        ),
      ),

      body: data == null
          ? const Center(child: Text("No data available"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header card ─────────────────────────────────────────
                  _buildHeaderCard(session),
                  const SizedBox(height: 16),

                  // ── Sample selector card ─────────────────────────────────
                  _buildSampleCard(session, data),
                  const SizedBox(height: 24),

                  // ── Bar chart section ────────────────────────────────────
                  const Text("Affective Form",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _bar("Fragrance",  data.fragrance),
                  _bar("Aroma",      data.aroma),
                  _bar("Flavor",     data.flavor),
                  _bar("Aftertaste", data.aftertaste),
                  _bar("Acidity",    data.acidity),
                  _bar("Sweetness",  data.sweetness),
                  _bar("Mouthfeel",  data.mouthfeel),
                  _bar("Overall",    data.overall),
                  const SizedBox(height: 24),

                  // ── Uniformity Cups ──────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Non Uniform Cups",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("${data.uniformCups.where((v) => v).length}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (i) =>
                        _cupIcon(data.uniformCups[i], _orange)),
                  ),
                  const SizedBox(height: 20),

                  // ── Defective Cups ───────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Defective Cups",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("${data.cleanCups.where((v) => v).length}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (i) =>
                        _cupIcon(data.cleanCups[i], _red)),
                  ),
                  const SizedBox(height: 16),

                  // ── Defect types ─────────────────────────────────────────
                  if (data.defects.values.any((v) => v)) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Defect Type",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        Text(
                          data.defects.entries
                              .where((e) => e.value)
                              .map((e) => e.key)
                              .join(", "),
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],

                  // ── Score summary ────────────────────────────────────────
                  _buildScoreSummary(data),
                  const SizedBox(height: 24),

                  // ── Radar chart ──────────────────────────────────────────
                  const Text("Session Result",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 300,
                    child: CustomPaint(
                      painter: _RadarChartPainter(
                        values: [
                          (data.fragrance ?? 0) / 9,
                          (data.aroma ?? 0) / 9,
                          (data.flavor ?? 0) / 9,
                          (data.aftertaste ?? 0) / 9,
                          (data.acidity ?? 0) / 9,
                          (data.sweetness ?? 0) / 9,
                          (data.mouthfeel ?? 0) / 9,
                          (data.overall ?? 0) / 9,
                        ],
                        labels: const [
                          "Fragrance", "Aroma", "Flavor", "Aftertaste",
                          "Acidity", "Sweetness", "Mouthfeel", "Overall",
                        ],
                      ),
                      child: Container(),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  // ── Header card ──────────────────────────────────────────────────────────────
  Widget _buildHeaderCard(SessionModel? session) {
    final now = DateTime.now();
    final date =
        "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: secondaryColor2, borderRadius: BorderRadius.circular(0)),
      child: Row(children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/photo/coffepro.png'),
          backgroundColor: Colors.white,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              session?.cuppingName ?? "Affective Assessment",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              overflow: TextOverflow.ellipsis, maxLines: 1,
            ),
            const SizedBox(height: 4),
            Text(
              "Date : $date  •  ${session?.samples.length ?? 0} samples",
              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
              overflow: TextOverflow.ellipsis, maxLines: 1,
            ),
          ]),
        ),
      ]),
    );
  }

  // ── Sample selector card ──────────────────────────────────────────────────────
  Widget _buildSampleCard(SessionModel? session, AffectiveFormData data) {
    final count = session?.samples.length ?? 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(
            flex: 3,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                session?.samples[_selectedSampleIndex].name ?? "Coffee Name",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                session?.samples[_selectedSampleIndex].roastLevel ?? "",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ]),
          ),
          _divider(),
          Expanded(flex: 2, child: Column(children: [
            const Text("Total Cup", style: TextStyle(fontSize: 13)),
            Text("$count",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15)),
          ])),
          _divider(),
          Expanded(flex: 2, child: Column(children: [
            const Text("Final Score", style: TextStyle(fontSize: 13)),
            Text(
              data.finalScore.toStringAsFixed(1),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: secondaryColor2),
            ),
          ])),
        ]),
        const SizedBox(height: 16),
        const Text("Select coffee",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        // sample selector chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(count, (i) {
            final selected = _selectedSampleIndex == i;
            return GestureDetector(
              onTap: () => setState(() => _selectedSampleIndex = i),
              child: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? secondaryColor2 : Colors.white,
                  border: Border.all(
                      color: selected ? secondaryColor2 : Colors.grey.shade300),
                ),
                child: Center(
                  child: Text("${i + 1}",
                      style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            );
          }),
        ),
      ]),
    );
  }

  // ── Score summary box ─────────────────────────────────────────────────────────
  Widget _buildScoreSummary(AffectiveFormData data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondaryColor2.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: secondaryColor2.withOpacity(0.2)),
      ),
      child: Column(children: [
        _summaryRow("Total Score",     data.totalScore.toStringAsFixed(0)),
        const Divider(height: 16),
        _summaryRow("Uniformity",      "+${data.uniformityScore}",
            color: Colors.green),
        const SizedBox(height: 4),
        _summaryRow("Clean Cup",       "+${data.cleanCupScore}",
            color: Colors.green),
        if (data.defectPenalty > 0) ...[
          const SizedBox(height: 4),
          _summaryRow("Defect Penalty", "-${data.defectPenalty}",
              color: Colors.red),
        ],
        const Divider(height: 16),
        _summaryRow("Final Score",     data.finalScore.toStringAsFixed(1),
            bold: true, color: secondaryColor2),
      ]),
    );
  }

  Widget _summaryRow(String label, String value,
      {Color? color, bool bold = false}) =>
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      Text(value, style: TextStyle(
          fontSize: 14,
          fontWeight: bold ? FontWeight.bold : FontWeight.w600,
          color: color ?? Colors.black87)),
    ]);

  // ── Bar row ───────────────────────────────────────────────────────────────────
  Widget _bar(String label, int? score) {
    final s = score ?? 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Text("$s / 9",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,
                  color: s > 0 ? _barBlue : Colors.grey.shade400)),
        ]),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: s / 9,
            minHeight: 10,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(
                s > 0 ? _barBlue : Colors.grey.shade300),
          ),
        ),
      ]),
    );
  }

  // ── Cup icon (read-only display) ──────────────────────────────────────────────
  Widget _cupIcon(bool active, Color activeColor) => Container(
    width: 46, height: 46,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: active ? activeColor : Colors.white,
      border: Border.all(
          color: active ? activeColor : Colors.grey.shade300),
    ),
    child: Icon(Icons.local_cafe_outlined,
        color: active ? Colors.white : Colors.grey.shade400, size: 22),
  );

  Widget _divider() => Container(
    height: 36, width: 1, color: primaryColor2,
    margin: const EdgeInsets.symmetric(horizontal: 10),
  );
}

// ── Radar Chart ───────────────────────────────────────────────────────────────
class _RadarChartPainter extends CustomPainter {
  final List<double> values; // 0.0 – 1.0
  final List<String> labels;

  const _RadarChartPainter({required this.values, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 48;
    final count = values.length;
    final step = (2 * pi) / count;

    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // Grid rings
    for (int lvl = 1; lvl <= 5; lvl++) {
      final r = radius * lvl / 5;
      final path = Path();
      for (int i = 0; i < count; i++) {
        final a = -pi / 2 + i * step;
        final p = Offset(center.dx + r * cos(a), center.dy + r * sin(a));
        i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // Axis lines
    for (int i = 0; i < count; i++) {
      final a = -pi / 2 + i * step;
      canvas.drawLine(center,
          Offset(center.dx + radius * cos(a), center.dy + radius * sin(a)),
          gridPaint);
    }

    // Data polygon
    final fillPaint = Paint()
      ..color = const Color(0xFF9B59B6).withOpacity(0.2)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = const Color(0xFF9B59B6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final dotPaint = Paint()
      ..color = const Color(0xFF9B59B6)
      ..style = PaintingStyle.fill;

    final dataPath = Path();
    for (int i = 0; i < count; i++) {
      final a = -pi / 2 + i * step;
      final r = radius * values[i].clamp(0.0, 1.0);
      final p = Offset(center.dx + r * cos(a), center.dy + r * sin(a));
      i == 0 ? dataPath.moveTo(p.dx, p.dy) : dataPath.lineTo(p.dx, p.dy);
    }
    dataPath.close();
    canvas.drawPath(dataPath, fillPaint);
    canvas.drawPath(dataPath, strokePaint);

    for (int i = 0; i < count; i++) {
      final a = -pi / 2 + i * step;
      final r = radius * values[i].clamp(0.0, 1.0);
      canvas.drawCircle(
          Offset(center.dx + r * cos(a), center.dy + r * sin(a)), 4, dotPaint);
    }

    // Labels
    for (int i = 0; i < count; i++) {
      final a = -pi / 2 + i * step;
      final lR = radius + 32;
      final x = center.dx + lR * cos(a);
      final y = center.dy + lR * sin(a);
      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
              color: Colors.black87, fontSize: 10, fontWeight: FontWeight.w500),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 72);
      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => true;
}