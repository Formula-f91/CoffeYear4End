import 'package:coffee/constants.dart';
import 'package:coffee/cupping/select_assessment_type_screen.dart';
import 'package:coffee/cupping/success_screen.dart'; // Import ไฟล์หน้าใหม่
import 'package:flutter/material.dart';

class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen({super.key});

  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  int selectedIndex = -1;

  final List<String> itemsStatus = ['active', 'pending', 'pending', 'pending', 'success'];

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: itemsStatus.length,
              itemBuilder: (context, index) {
                return Column(children: [_buildEvaluationItem(index), const SizedBox(height: 12)]);
              },
            ),
          ),

          // Bottom Buttons
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            decoration: const BoxDecoration(color: Colors.white),
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
                        if (selectedIndex != -1) {
                          // --- แก้ไขตรงนี้ ---
                          // เดิม: ไปหน้า DescriptiveAssessmentScreen เลย
                          // ใหม่: ไปหน้า SelectAssessmentTypeScreen ก่อน
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const SelectAssessmentTypeScreen())
                          );
                          // ----------------
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please select a coffee to assess"))
                          );
                        }
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

  Widget _buildEvaluationItem(int index) {
    String status = itemsStatus[index];
    bool isSuccess = status == 'success';
    bool isSelected = (index == selectedIndex);

    return GestureDetector(
      onTap: () {
        // --- ส่วนที่แก้ไข: ถ้า Success ให้ไปหน้า SuccessScreen ---
        if (isSuccess) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SuccessScreen()));
        } else {
          // ถ้าไม่ใช่ Success ให้เลือกปกติ
          setState(() {
            selectedIndex = index;
          });
        }
        // -----------------------------------------------------
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF8F5) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? primaryColor : (isSuccess ? const Color(0xFF4CAF50) : Colors.grey.shade200), width: isSelected ? 2 : 1),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            _buildLeadingIcon(status, isSelected),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Coffee Name ${index + 1}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isSelected ? primaryColor : Colors.black),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text("Roast level", style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                    if (isSuccess)
                      const Text(
                        " Success",
                        style: TextStyle(color: Color(0xFF4CAF50), fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingIcon(String status, bool isSelected) {
    if (status == 'success') {
      return Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(color: Color(0xFF4CAF50), shape: BoxShape.circle),
        child: const Icon(Icons.check, color: Colors.white, size: 18),
      );
    } else if (isSelected) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryColor, width: 2),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
        ),
      );
    } else {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400),
        ),
      );
    }
  }
}
