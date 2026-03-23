import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Descriptive Form",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
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
                  // --- Header Card ---
                  _buildHeaderCard(),
                  const SizedBox(height: 24),

                  // --- Scores List ---
                  _buildScoreItem("Fragrance", 8),
                  _buildScoreItem("Aroma", 8, description: "Floral, Fruity (Dried Fruit)"),
                  _buildScoreItem("Flavor", 8),
                  _buildScoreItem("Aftertaste", 8, description: "Floral(Dried Fruit), Sour/Fermented(Sour)\nMain Tastes : Salty"),
                  _buildScoreItem("Acidity", 8),
                  _buildScoreItem("Sweetness", 8),
                  _buildScoreItem("Mouthfeel", 8, description: "Rough (Gritty, Chalky, Sandy)"),

                  const SizedBox(height: 16),

                  // --- Defects ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Defects (if any)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const Text("None", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  const Divider(height: 24),

                  // --- Additional Comments ---
                  const Text("Additional Comments", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  const SizedBox(height: 30),

                  // --- Chart Section ---
                  Center(
                    child: Column(
                      children: [
                        // Tabs (Mock UI)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildColorTab("Floral / 2", Colors.pinkAccent),
                            const SizedBox(width: 8),
                            _buildColorTab("Sour / 2", Colors.yellow),
                            const SizedBox(width: 8),
                            _buildColorTab("Citrus Fruit / 2", Colors.lime),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Chart Image
                        SizedBox(
                          height: 200,
                          child: Image.asset(
                            'assets/photo/groupchart.png', // path รูป Chart                             fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Checkboxes below chart
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_buildChartLegend("Fragrance / Aroma", true), const SizedBox(width: 16), _buildChartLegend("Flavor / Aftertaste", true)],
                        ),
                        const SizedBox(height: 8),
                        _buildChartLegend("Tap to Flavor Wheel", false),

                        const SizedBox(height: 16),
                        const Text("Total Score : N/A", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- Score Summary Bottom List ---
                  _buildBottomScoreRow("Fragrance", 8),
                  _buildBottomScoreRow("Aroma", 8),
                  _buildBottomScoreRow("Flavor", 8),
                  _buildBottomScoreRow("Aftertaste", 8),
                  _buildBottomScoreRow("Acidity", 8),
                  _buildBottomScoreRow("Sweetness", 8),
                  _buildBottomScoreRow("Mouthfeel", 8),
                ],
              ),
            ),
          ),

          // --- Bottom Back Button ---
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            decoration: const BoxDecoration(color: Colors.white),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text("Back", style: TextStyle(color: Colors.grey.shade700, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            // decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            padding: const EdgeInsets.all(2),
            child: ClipOval(child: Image.asset('assets/photo/coffepro.png', fit: BoxFit.cover)),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Descriptive Assessment",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text("Name : xxxxxxx   |   Date : 26.01.23", style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem(String label, int score, {String? description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(score.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 6),
          // Progress Bar (Custom style)
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5E6DE), // สีพื้นหลังหลอด (ครีมจางๆ)
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: score / 10, // คำนวณความยาวตามคะแนน (เต็ม 10)
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor, // สีหลอด (น้ำตาล)
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          if (description != null) ...[const SizedBox(height: 6), Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[800]))],
        ],
      ),
    );
  }

  Widget _buildColorTab(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildChartLegend(String text, bool isChecked) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: isChecked ? secondaryColor : Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: secondaryColor),
          ),
          child: isChecked ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBottomScoreRow(String label, int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(score.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
