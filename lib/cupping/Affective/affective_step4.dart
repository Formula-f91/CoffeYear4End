import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Affective/affective_step5.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AffectiveStep4 extends StatefulWidget {
  const AffectiveStep4({super.key});

  @override
  State<AffectiveStep4> createState() => _AffectiveStep4State();
}

class _AffectiveStep4State extends State<AffectiveStep4> {
  // --- State Variables ---
  int? selectedFlavor;

  final TextEditingController _noteController = TextEditingController();

  final Color themeColor = const Color(0xFFC67C4E);
  final Color activeOrange = const Color(0xFFFF8D28);
  final Color boxBorderColor = const Color(0xFF947257);

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CuppingProvider>(
      builder: (context, provider, child) {
        final cupData = provider.currentCupData;

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
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
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
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: secondaryColor2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        "Back",
                        style: TextStyle(color: secondaryColor2, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AffectiveStep5(),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor2,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          body: Column(
            children: [
              _buildProgressBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderCard(),
                      const SizedBox(height: 22),
                      _buildSelectCoffeeCardAffective(provider),
                      const SizedBox(height: 20),
                      _buildMainAssessmentBox(provider, cupData),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Select Coffee Card ---
  Widget _buildSelectCoffeeCardAffective(CuppingProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: const Color(0xFFA2A2A2)),
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
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Roast level",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              _buildDividerLine(),
              const Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text("Total Cup", style: TextStyle(fontSize: 12)),
                    Text(
                      "5",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDividerLine(),
              const Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text("Total Score", style: TextStyle(fontSize: 12)),
                    Text(
                      "xx",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Select coffee",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          _buildCupSelectionRow(provider),
        ],
      ),
    );
  }

  Widget _buildCupSelectionRow(CuppingProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        int cupNum = index + 1;
        bool isSelected = provider.currentCupNumber == cupNum;
        return GestureDetector(
          onTap: () => provider.selectCup(cupNum),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? secondaryColor2 : Colors.white,
              border: Border.all(
                color: isSelected ? secondaryColor2 : Colors.grey.shade300,
              ),
            ),
            child: Center(
              child: Text(
                "$cupNum",
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDividerLine() {
    return Container(
      height: 40,
      width: 1,
      color: primaryColor2,
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  // --- MAIN ASSESSMENT BOX (1-9 circle selector) ---
  Widget _buildMainAssessmentBox(CuppingProvider provider, CupData cupData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Text(
            "INITIAL ASSESSMENT (1-9)",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 20),

          // Flavor
          _buildNumberSelector(
            label: "Sweetness",
            selectedValue: selectedFlavor,
            onSelect: (val) => setState(() => selectedFlavor = val),
          ),
          const SizedBox(height: 32),

          // Note
          const Text(
            'Note',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _noteController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberSelector({
    required String label,
    required int? selectedValue,
    required ValueChanged<int> onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(9, (index) {
            final int num = index + 1;
            final bool isSelected = selectedValue == num;
            return GestureDetector(
              onTap: () => onSelect(num),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? primaryColor2 : Colors.white,
                  border: Border.all(
                    color: isSelected ? primaryColor2 : Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    "$num",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // --- Shared Helper Widgets ---
  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: List.generate(
          7,
          (index) => Expanded(
            child: Container(
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: index <= 3 ? secondaryColor2 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: secondaryColor2,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: Image.asset(
                'assets/photo/coffepro.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Affective Assessment",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 4),
                Text(
                  "Name : xxxxxxx   |   Date : 26.01.23",
                  style: TextStyle(color: Colors.white, fontSize: 12),
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

// --- BalloonSliderShape Class (kept for compatibility) ---
class BalloonSliderShape extends SliderComponentShape {
  final double thumbRadius;
  final int thumbValue;
  final Color color;
  const BalloonSliderShape({
    required this.thumbRadius,
    required this.thumbValue,
    required this.color,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(thumbRadius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()..color = color;
    canvas.drawCircle(center, thumbRadius, paint);
    canvas.drawCircle(
      center,
      thumbRadius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
    const double bW = 76;
    const double bH = 63;
    const double tH = 8;
    final Offset bC = center + const Offset(0, -(bH + tH + (-19)));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: bC, width: bW, height: bH),
        const Radius.circular(30),
      ),
      paint,
    );
    final Path tP = Path()
      ..moveTo(center.dx - 6, bC.dy + (bH / 2))
      ..lineTo(center.dx, bC.dy + (bH / 2) + tH)
      ..lineTo(center.dx + 6, bC.dy + (bH / 2))
      ..close();
    canvas.drawPath(tP, paint);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: thumbValue.toString(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(bC.dx - (tp.width / 2), bC.dy - (tp.height / 2)));
  }
}
