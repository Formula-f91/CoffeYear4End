import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Quickmode/combined_result_step2.dart';
import 'package:coffee/cupping/formdescriptor/defect_descriptor_sheet.dart';
import 'package:coffee/cupping/formdescriptor/flavor_descriptor_sheet.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CombinedResult extends StatefulWidget {
  const CombinedResult({super.key});

  @override
  State<CombinedResult> createState() => _CombinedResultState();
}

class _CombinedResultState extends State<CombinedResult> {
  int score = 0;
  bool reRoastYes = false;
  bool reRoastNo = true;
  final TextEditingController _noteController = TextEditingController();

  List<String> selectedFlavorDescriptors = [];
  List<String> selectedDefectsDescriptors = [];

  final Color activeOrange = const Color(0xFFFF8D28);

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  // ── Flavor Sheet: merge ข้อมูลเก่า + ใหม่ ──
  void _showFlavorSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FlavorDescriptorSheet(
        initialSelected: List.from(selectedFlavorDescriptors),
        onApply: (newSelected) {
          setState(() {
            // รวมของเก่า + ของใหม่ กัน duplicate ด้วย Set
            final merged = {...selectedFlavorDescriptors, ...newSelected}.toList();
            selectedFlavorDescriptors = merged;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  // ── Defect Sheet: merge ข้อมูลเก่า + ใหม่ ──
  void _showDefectSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DefectDescriptorSheet(
        initialSelected: List.from(selectedDefectsDescriptors),
        onApply: (newSelected) {
          setState(() {
            // รวมของเก่า + ของใหม่ กัน duplicate ด้วย Set
            final merged = {...selectedDefectsDescriptors, ...newSelected}.toList();
            selectedDefectsDescriptors = merged;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

 
  @override
Widget build(BuildContext context) {
  return Consumer<CuppingProvider>(
    builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false, // ✅ ซ่อนปุ่ม arrow back
          title: const Text(
            "Quick Mode",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        // ✅ ย้ายปุ่มมาไว้ที่นี่
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: secondaryColor2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    ),
                    child: Text("Back", style: TextStyle(color: secondaryColor2, fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CombinedResultStep2()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor2,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
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
                    _buildBlueHeaderCard(),
                    const SizedBox(height: 22),
                    _buildCoffeeInfoCard(provider),
                    const SizedBox(height: 20),
                    _buildDescriptorCard(
                      label: 'Flavor',
                      selectedDescriptors: selectedFlavorDescriptors,
                      onAddTap: _showFlavorSheet,
                    ),
                    const SizedBox(height: 20),
                    _buildDescriptorCard(
                      label: 'Defects',
                      selectedDescriptors: selectedDefectsDescriptors,
                      onAddTap: _showDefectSheet,
                      isDefect: true,
                    ),
                    const SizedBox(height: 16),
                    _buildScoreRow(),
                    const SizedBox(height: 24),
                    _buildReRoastSection(),
                    const SizedBox(height: 16),
                    _buildNoteSection(),
                    const SizedBox(height: 16),
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

  Widget _buildBlueHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: secondaryColor2,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/photo/coffepro.png'),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Mode',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Name : xxxxxxx  |  Date : 26.01.23',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoffeeInfoCard(CuppingProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFA2A2A2),
          width: 1,
        ),
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
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Roast level",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              _buildVerticalDivider(),
              const Column(
                children: [
                  Text("Total Cup", style: TextStyle(fontSize: 14)),
                  Text(
                    "5",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              _buildVerticalDivider(),
              Column(
                children: [
                  const Text("Total Score", style: TextStyle(fontSize: 14)),
                  SizedBox(
                    width: 50,
                    height: 30,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Select coffee",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
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
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: primaryColor2,
      margin: const EdgeInsets.symmetric(horizontal: 12),
    );
  }

  Widget _buildDescriptorCard({
    required String label,
    required List<String> selectedDescriptors,
    required VoidCallback onAddTap,
    bool isDefect = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            ElevatedButton(
              onPressed: onAddTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Add descriptors',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 172),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: selectedDescriptors.isEmpty
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
                  children: selectedDescriptors.map((d) {
                    final Color color;
                    final String emojiStr;
                    final String? imageStr;

                    if (isDefect) {
                      final style = DefectDescriptorSheet.resolveStyle(d);
                      color = style['color'] as Color;
                      emojiStr = '•';
                      imageStr = null;
                    } else {
                      final style = FlavorDescriptorSheet.resolveStyle(d);
                      color = style['color'] as Color;
                      emojiStr = style['emoji'] as String? ?? '•';
                      imageStr = style['image'] as String?;
                    }

                    // defect chip: สีพื้นจาง + ข้อความดำ (เหมือนใน defect sheet)
                    // flavor chip: สีพื้นเข้ม + ข้อความขาว
                    return GestureDetector(
                      onTap: () =>
                          setState(() => selectedDescriptors.remove(d)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isDefect
                              ? color.withOpacity(0.12)
                              : color.withOpacity(0.7),
                          border: Border.all(
                            color: color.withOpacity(isDefect ? 0.5 : 0.6),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (imageStr != null) ...[
                              Image.asset(
                                imageStr,
                                width: 16,
                                height: 16,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Text(
                                  emojiStr,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              const SizedBox(width: 5),
                            ] else if (!isDefect) ...[
                              Text(
                                emojiStr,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 5),
                            ],
                            Text(
                              d,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                // defect = ข้อความดำ, flavor = ข้อความขาว
                                color: isDefect ? Colors.black : Colors.white,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.cancel,
                              size: 14,
                              // defect = icon สีตาม color, flavor = สีดำ
                              color: isDefect ? color : Colors.black,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildScoreRow() {
    return Row(
      children: [
        const Text(
          'Score',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            if (score > 0) setState(() => score--);
          },
          icon: const Icon(Icons.remove),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 12),
        Text(
          '$score',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () => setState(() => score++),
          icon: const Icon(Icons.add),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildReRoastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RE-ROAST REQUEST',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 4),
        const Text(
          'Do you want to re-roast this sample?',
          style: TextStyle(color: Colors.black87, fontSize: 13),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => setState(() {
            reRoastYes = true;
            reRoastNo = false;
          }),
          child: Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: reRoastYes,
                activeColor: primaryColor2,
                onChanged: (_) => setState(() {
                  reRoastYes = true;
                  reRoastNo = false;
                }),
              ),
              const Text('Yes', style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            reRoastYes = false;
            reRoastNo = true;
          }),
          child: Container(
            decoration: BoxDecoration(
              color: reRoastNo ? primaryColor2.withOpacity(0.08) : null,
              borderRadius: BorderRadius.circular(8),
              border: reRoastNo
                  ? Border.all(color: primaryColor2.withOpacity(0.3))
                  : null,
            ),
            child: Row(
              children: [
                Radio<bool>(
                  value: false,
                  groupValue: reRoastYes,
                  activeColor: primaryColor2,
                  onChanged: (_) => setState(() {
                    reRoastYes = false;
                    reRoastNo = true;
                  }),
                ),
                const Text('No', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Note',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _noteController,
          maxLines: 4,
          decoration: InputDecoration(
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
    );
  }

 
}