import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Affective/affective_step1.dart';
import 'package:coffee/cupping/Descriptive/DescriptiveStep1.dart';
import 'package:coffee/cupping/Quickmode/combined_result_step1.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:coffee/cupping/Combinedform/combined_assessment_screen.dart';

class SelectFormScreen extends StatefulWidget {
  // รับ session มาด้วยเพื่อส่งต่อให้แต่ละ form
  final SessionModel? session;

  const SelectFormScreen({super.key, this.session});

  @override
  State<SelectFormScreen> createState() => _SelectFormScreenState();
}

class _SelectFormScreenState extends State<SelectFormScreen> {
  int _selectedFormIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  side: BorderSide(color: secondaryColor2, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Text(
                  "Back",
                  style: TextStyle(
                    color: secondaryColor2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedFormIndex == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DescriptiveStep1(),
                        ),
                      );
                    } else if (_selectedFormIndex == 1) {
                      // Affective — ต้องมี session
                      if (widget.session == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Session data not found')),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AffectiveStep1(
                            session: widget.session!,
                          ),
                        ),
                      );
                    } else if (_selectedFormIndex == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CombinedAssessmentScreen(),
                        ),
                      );
                    } else if (_selectedFormIndex == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CombinedResult(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a form type'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor2,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
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

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Select form",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            _buildOptionCard(index: 0, title: "CVA Descriptive"),
            const SizedBox(height: 12),
            _buildOptionCard(index: 1, title: "CVA Affective"),
            const SizedBox(height: 12),
            _buildOptionCard(index: 2, title: "CVA Combined"),
            const SizedBox(height: 12),
            _buildOptionCard(index: 3, title: "Quick mode"),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({required int index, required String title}) {
    bool isSelected = _selectedFormIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFormIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? secondaryColor2 : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? secondaryColor : Colors.grey.shade400,
                  width: isSelected ? 6 : 1.5,
                ),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight:
                    isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}