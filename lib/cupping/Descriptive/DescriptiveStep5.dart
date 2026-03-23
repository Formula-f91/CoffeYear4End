import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Descriptive/Descriptivesuccess.dart';
import 'package:coffee/cupping/formdescriptor/mouthfeel_descriptor_sheet.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DescriptiveStep5 extends StatefulWidget {
  const DescriptiveStep5({super.key});

  @override
  State<DescriptiveStep5> createState() => DescriptiveStep5state();
}

class DescriptiveStep5state extends State<DescriptiveStep5> {
  bool isDescriptiveMode = true;

  List<String> selectedMouthfeelDescriptors = [];
  final TextEditingController _noteController = TextEditingController();

  final Color themeColor = const Color(0xFFC67C4E);
  final Color activeOrange = const Color(0xFFFF8D28);
  final Color boxBorderColor = const Color(0xFF947257);
  static const Color _blue = Color(0xFF1E52C6);

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _showMouthfeelSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => MouthfeelDescriptorSheet(
        initialSelected: List.from(selectedMouthfeelDescriptors),
        onApply: (selected) {
          setState(() => selectedMouthfeelDescriptors = selected);
          Navigator.pop(context);
        },
      ),
    );
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
              "Descriptive Form",
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
                          builder: (context) => const DescriptiveSuccess(),
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
                      _buildSelectCoffeeCardDescription(provider),
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

  Widget _buildSelectCoffeeCardDescription(CuppingProvider provider) {
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
              const Column(
                children: [
                  Text(
                    "Total Cup",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "5",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
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

  Widget _buildMainAssessmentBox(CuppingProvider provider, CupData cupData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 38, 16, 16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomSlider(
            "Mouthfeel",
            cupData.fragrance,
            (val) => provider.updateFragrance(val),
          ),
          const SizedBox(height: 30),

          // ── Mouthfeel Descriptors ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  "Mouthfeel Descriptors",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _showMouthfeelSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor2,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                ),
                child: const Text('Add', style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 172),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: selectedMouthfeelDescriptors.isEmpty
                ? const Center(
                    child: Text(
                      'Descriptor is not added yet, click add descriptor\nto add',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedMouthfeelDescriptors.map((d) {
                      return GestureDetector(
                        onTap: () => setState(
                          () => selectedMouthfeelDescriptors.remove(d),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _blue.withOpacity(0.12),
                            border: Border.all(color: _blue, width: 0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                d,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: _blue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
          const SizedBox(height: 24),

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

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: List.generate(
          5,
          (index) => Expanded(
            child: Container(
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: index <= 5 ? secondaryColor2 : Colors.grey.shade200,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDescriptiveMode
                      ? "Descriptive Assessment"
                      : "Affective Assessment",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                const Text(
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

  Widget _buildCustomSlider(
    String label,
    double value,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: secondaryColor2,
                inactiveTrackColor: const Color(0xFFF0E5DE),
                trackHeight: 14.0,
                trackShape: const RoundedRectSliderTrackShape(),
                thumbShape: BalloonSliderShape(
                  thumbRadius: 10,
                  thumbValue: value.toInt(),
                  color: secondaryColor2,
                ),
                overlayColor: secondaryColor2.withOpacity(0.1),
                tickMarkShape: const RoundSliderTickMarkShape(
                  tickMarkRadius: 0,
                ),
              ),
              child: Slider(
                value: value,
                min: 0,
                max: 15,
                divisions: 10,
                onChanged: onChanged,
              ),
            ),
            IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: secondaryColor2,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ),
          ],
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            const double sliderPadding = 24.0;
            final double trackWidth = width - (sliderPadding * 2);
            double getPos(double val) =>
                sliderPadding + (val / 10 * trackWidth);
            return SizedBox(
              height: 40,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: getPos(3.0),
                    top: -12,
                    child: _buildTickMark(),
                  ),
                  Positioned(
                    left: getPos(7.0),
                    top: -12,
                    child: _buildTickMark(),
                  ),
                  Positioned(
                    left: getPos(1.5) - 25,
                    top: 12,
                    width: 50,
                    child: const Text(
                      "Low",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: getPos(5.0) - 25,
                    top: 12,
                    width: 50,
                    child: const Text(
                      "Medium",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: getPos(8.5) - 25,
                    top: 12,
                    width: 50,
                    child: const Text(
                      "High",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTickMark() =>
      Container(width: 1.5, height: 25, color: primaryColor2);
}

// --- BalloonSliderShape Class ---
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
