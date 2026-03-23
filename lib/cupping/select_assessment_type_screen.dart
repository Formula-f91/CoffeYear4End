import 'package:coffee/cupping/Combinedform/combined_assessment_screen.dart';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart'; 

class SelectAssessmentTypeScreen extends StatefulWidget {
  const SelectAssessmentTypeScreen({super.key});

  @override
  State<SelectAssessmentTypeScreen> createState() => _SelectAssessmentTypeScreenState();
}

class _SelectAssessmentTypeScreenState extends State<SelectAssessmentTypeScreen> {
  // กำหนดให้เลือกตัวเลือกที่ 0 ไว้เสมอ (เพราะมีตัวเลือกเดียว)
  int selectedIndex = 0; 

  // ปรับลิสต์ให้เหลือเพียงตัวเลือกเดียว
  final List<String> assessmentOptions = [
    "SCA CVA Combined",
  ];

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
          "Select From",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: assessmentOptions.length, // จะเหลือแค่ 1 รายการ
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildOptionItem(index);
              },
            ),
          ),
          
          // Bottom Buttons
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
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
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // เมื่อมีตัวเลือกเดียว Logic จะวิ่งไปที่ CombinedAssessmentScreen ทันที
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const CombinedAssessmentScreen())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: const Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem(int index) {
    bool isSelected = (selectedIndex == index);
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? primaryColor : Colors.grey.shade200, width: 1.5),
        ),
        child: Row(
          children: [
            _buildRadioButton(isSelected),
            const SizedBox(width: 16),
            Text(assessmentOptions[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(bool isSelected) {
    return Container(
      width: 24, height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: isSelected ? primaryColor : Colors.grey.shade400, width: 1.5),
      ),
      padding: const EdgeInsets.all(3),
      child: isSelected ? Container(decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle)) : null,
    );
  }
}