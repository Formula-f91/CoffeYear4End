import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Combinedform/select_coffee_summary_screen.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 2. Import Package Provider

class CombinedAssessmentScreenStep6 extends StatefulWidget {
  const CombinedAssessmentScreenStep6({super.key});

  @override
  State<CombinedAssessmentScreenStep6> createState() =>
      _CombinedAssessmentScreenStep6State();
}

class _CombinedAssessmentScreenStep6State
    extends State<CombinedAssessmentScreenStep6> {
  // --- State Variables ---
  bool isDescriptiveMode = true;

  int? selectedFragrance;
  final TextEditingController _noteController = TextEditingController();

  final Color themeColor = const Color(0xFFC67C4E);
  final Color activeOrange = const Color(0xFFFF8D28);
  final Color boxBorderColor = const Color(0xFF947257);
  final Color defectRed = const Color(0xFFB3261E);

  final List<Map<String, dynamic>> affectiveOptions = [
    {"value": "1  Extremely low", "color": const Color(0xFFB3261E)},
    {"value": "2  Very low", "color": const Color(0xFFB3261E)},
    {"value": "3  Modelately low", "color": const Color(0xFFB3261E)},
    {"value": "4  Slightly low", "color": const Color(0xFFFF8D28)},
    {"value": "5  Neither high nor low", "color": const Color(0xFFFF8D28)},
    {"value": "6  Slightly low", "color": const Color(0xFFFF8D28)},
    {"value": "7  Modelately high", "color": const Color(0xFFFF8D28)},
    {"value": "8  Very high", "color": const Color(0xFF609966)},
    {"value": "9  Extremely high", "color": const Color(0xFF609966)},
  ];

  final List<String> defects = ["None", "Musty", "Sour", "Astringent", "Burnt"];

  @override
  Widget build(BuildContext context) {
    // 3. ห่อหุ้มด้วย Consumer
    return Consumer<CuppingProvider>(
      builder: (context, provider, child) {
        // ดึงข้อมูลแก้วปัจจุบัน
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
              "Combined Form",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          // ✅ เพิ่ม bottomNavigationBar
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
                          builder: (context) =>
                              const SelectCoffeeSummaryScreen(),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                      const SizedBox(height: 20),
                      isDescriptiveMode
                          ? _buildSelectCoffeeCardDescription(provider)
                          : _buildSelectCoffeeCardAffective(provider),
                      const SizedBox(height: 20),
                      _buildTabSwitcher(),
                      const SizedBox(height: 16),
                      isDescriptiveMode
                          ? _buildDescriptiveAssessmentBox(provider, cupData)
                          : _buildAffectiveAssessmentBox(provider, cupData),
                    ],
                  ),
                ),
              ),
              // ✅ ลบ _buildFooterButtons() ออกแล้ว
            ],
          ),
        );
      },
    );
  }

  // --- CONTENT: Descriptive Mode ---
  Widget _buildDescriptiveAssessmentBox(
    CuppingProvider provider,
    dynamic cupData,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(16),
      //   border: Border.all(color: Colors.grey.shade300),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.05),
      //       blurRadius: 10,
      //       offset: const Offset(0, 4),
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Text(
            'Extrinsic Assessment',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          TextField(
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

  // --- CONTENT: Affective Mode ---
  Widget _buildAffectiveAssessmentBox(
    CuppingProvider provider,
    CupData cupData,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(color: Colors.grey.shade300),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.05),
        //     blurRadius: 10,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
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

          // Fragrance
          _buildNumberSelector(
            label: "Mouthfeel",
            selectedValue: selectedFragrance,
            onSelect: (val) => setState(() => selectedFragrance = val),
          ),
          const SizedBox(height: 24),

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

          const Text(
            "Uniformity Cups",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => _buildCupIconBtn(
                index,
                cupData.uniformCups,
                activeOrange,
                () => provider.updateUniformCup(index), // สั่งงานผ่าน provider
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Defective Cups (Clean Cup)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => _buildCupIconBtn(
                index,
                cupData.cleanCups,
                defectRed,
                () => provider.updateCleanCup(index), // สั่งงานผ่าน provider
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          const Text(
            "Defect Type (If any)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          // ดึง Key จาก defectsList ใน provider มาสร้าง Checkbox
          ...cupData.defectsList.keys.map(
            (key) => _buildDefectCheckboxItem(
              key,
              cupData.defectsList[key]!,
              () => provider.updateDefectListItem(key), // สั่งงานผ่าน provider
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

  Widget _buildDefectCheckboxItem(
    String title,
    bool isChecked,
    VoidCallback onTap, // เพิ่ม parameter
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isChecked ? primaryColor2 : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: isChecked ? primaryColor2 : Colors.grey.shade400,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isChecked
                  ? Container(
                      decoration: BoxDecoration(
                        color: primaryColor2,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCupIconBtn(
    int index,
    List<bool> list,
    Color activeColor,
    VoidCallback onTap, // เพิ่ม parameter เพื่อรับ action จากภายนอก
  ) {
    bool isActive = list[index];
    return GestureDetector(
      onTap: onTap, // ใช้ action ที่ส่งมาจาก build
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

  // --- UI Helpers (Tab Switcher, Header, Cards) ---

  Widget _buildTabSwitcher() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isDescriptiveMode = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: isDescriptiveMode
                        ? primaryColor2
                        : Colors.transparent,
                    width: 2.0, // ความหนาของเส้นใต้
                  ),
                ),
              ),
              child: Text(
                "Descriptive",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDescriptiveMode
                      ? primaryColor2
                      : Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isDescriptiveMode = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: !isDescriptiveMode
                        ? primaryColor2
                        : Colors.transparent,
                    width: 2.0, // ความหนาของเส้นใต้
                  ),
                ),
              ),
              child: Text(
                "Affective",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: !isDescriptiveMode
                      ? primaryColor2
                      : Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
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
                    style: TextStyle(fontSize: 14, color: Colors.black),
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
        // เช็คจาก Provider
        bool isSelected = provider.currentCupNumber == cupNum;
        return GestureDetector(
          onTap: () => provider.selectCup(cupNum), // เปลี่ยนแก้ว
          child: Container(
            width: 48,
            height: 48,
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

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: List.generate(
          6,
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
            // ✅ ครอบด้วย Expanded
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
                  overflow: TextOverflow.ellipsis, // ✅ ตัดข้อความถ้ายาวเกิน
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                const Text(
                  "Name : xxxxxxx   |   Date : 26.01.23",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  overflow: TextOverflow.ellipsis, // ✅
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDividerLine() => Container(
    height: 40,
    width: 1,
    color: primaryColor2,
    margin: const EdgeInsets.symmetric(horizontal: 16),
  );
}
