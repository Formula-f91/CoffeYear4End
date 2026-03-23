import 'dart:math';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Combinedform/combined_form_pdf.dart';
import 'package:coffee/cupping/Combinedform/combined_result_pdf.dart';
import 'package:coffee/cupping/Descriptive/Descriptivechart.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:coffee/distributor_firstPage.dart';
import 'package:coffee/farm/farm_first_page.dart';
import 'package:coffee/firstPage.dart';
import 'package:coffee/roaster_firstPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class CuppingSuccessScreen extends StatefulWidget {
  const CuppingSuccessScreen({super.key});

  @override
  State<CuppingSuccessScreen> createState() => _CuppingSuccessScreenState();
}

class _CuppingSuccessScreenState extends State<CuppingSuccessScreen> {
  final Color themeColor = const Color(0xFFC67C4E);
  final Color headerBrown = const Color(0xFFC88A5F);
  final Color activeOrange = const Color(0xFFFF8D28);
  final Color defectRed = const Color(0xFFB3261E);
  final Color blueBar = const Color(0xFF1A3A8F);

  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool _showFragranceAroma = true;
  bool _showFlavorAftertaste = true;
  bool _showTop10FlavorWheel = false;

  final List<bool> _uniformCups = [false, false, false, false, false];
  final List<bool> _cleanCups = [false, false, false, false, false];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                                GestureDetector(
                                  onTap: () {
                                    if (isSelected) {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ComparisonResultScreen(),
                                        ),
                                      );
                                    } else {
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
                                        "Session Code : ${session["code"]}",
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
              "Combined Form",
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
                        await CombinedFormPdfGenerator.generateAndPreview(
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderCard(),
                const SizedBox(height: 16),
                _buildCoffeeInfoCard(provider, cupData, currentCupNum),
                const SizedBox(height: 16),
                const SizedBox(height: 12),

                // Descriptive Form
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                      const SizedBox(height: 25),
                      _buildDonutChartSection(cupData),
                      const SizedBox(height: 24),
                      _buildDetailBarRow(
                        "Fragrance",
                        cupData.fragrance.toStringAsFixed(1),
                      ),
                      _buildDetailBarRow(
                        "Aroma",
                        cupData.aroma.toStringAsFixed(1),
                      ),
                      const Text(
                        "Floral, Fruity (Dried Fruit)",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildDetailBarRow(
                        "Flavor",
                        cupData.flavor.toStringAsFixed(1),
                      ),
                      _buildDetailBarRow(
                        "Aftertaste",
                        cupData.aftertaste.toStringAsFixed(1),
                      ),
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
                      _buildDetailBarRow(
                        "Acidity",
                        cupData.acidity.toStringAsFixed(1),
                      ),
                      _buildDetailBarRow(
                        "Sweetness",
                        cupData.sweetness.toStringAsFixed(1),
                      ),
                      _buildDetailBarRow(
                        "Mouthfeel",
                        cupData.mouthfeel.toStringAsFixed(1),
                      ),
                      const Text(
                        "Rough (Gritty, Chalky, Sandy)",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSimpleRow(
                        "Defects (if any)",
                        cupData.defectType == 0
                            ? "None"
                            : "Type ${cupData.defectType}",
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Session Result",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 300,
                        child: CustomPaint(
                          painter: _RadarChartPainter(
                            values: [
                              (cupData.fragrance / 10).clamp(0.0, 1.0),
                              (cupData.aroma / 10).clamp(0.0, 1.0),
                              (cupData.flavor / 10).clamp(0.0, 1.0),
                              (cupData.aftertaste / 10).clamp(0.0, 1.0),
                              (cupData.acidity / 10).clamp(0.0, 1.0),
                              (cupData.sweetness / 10).clamp(0.0, 1.0),
                              (cupData.mouthfeel / 10).clamp(0.0, 1.0),
                            ],
                            labels: const [
                              "Fragrance\nAroma",
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

                const SizedBox(height: 8),

                // Affective Form
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                      const SizedBox(height: 20),
                      _buildBarRow("Fragrance", cupData.fragrance.round(), 10),
                      _buildBarRow("Aroma", cupData.aroma.round(), 10),
                      _buildBarRow("Flavor", cupData.flavor.round(), 10),
                      _buildBarRow(
                        "Aftertaste",
                        cupData.aftertaste.round(),
                        10,
                      ),
                      _buildBarRow("Acidity", cupData.acidity.round(), 10),
                      _buildBarRow("Sweetness", cupData.sweetness.round(), 10),
                      _buildBarRow("Mouthfeel", cupData.mouthfeel.round(), 10),
                      _buildBarRow("Overall", cupData.overall.round(), 10),
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
                            cupData.defectType == 0
                                ? "None"
                                : "Type ${cupData.defectType}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Total Score
                      Center(
                        child: Text(
                          "Total Score : ${cupData.totalScore.toStringAsFixed(1)}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Session Result Radar (Affective)
                      const Text(
                        "Session Result",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 300,
                        child: CustomPaint(
                          painter: _RadarChartPainter(
                            values: [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5],
                            labels: const [
                              "Fragrance\nAroma",
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
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 35,
                              child: OutlinedButton(
                                onPressed: () async {
                                  await CombinedResultPdfGenerator.generateAndPreview(
                                    cupData,
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: primaryColor2,
                                    width: 1,
                                  ),
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
                          ),
                          if (provider.currentRole != UserRole.consumer) ...[
                            const SizedBox(width: 12),
                            Expanded(
                              child: SizedBox(
                                height: 35,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      _showCompareSessionsSheet(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: secondaryColor2,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
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
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Donut Chart Section ──
  Widget _buildDonutChartSection(CupData cupData) {
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
              value: (double.tryParse(score) ?? 0) / 10,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Coffee Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    "Roast level",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              _buildVerticalDivider(),
              const Column(
                children: [
                  Text("Total Cup", style: TextStyle(fontSize: 13)),
                  Text(
                    "5",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
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
              int cupNum = index + 1;
              bool isSelected = currentCupNum == cupNum;
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
          const SizedBox(height: 20),
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

  Widget _buildVerticalDivider() =>
      Container(height: 30, width: 1, color: primaryColor2);

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Combined Assessment",
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
