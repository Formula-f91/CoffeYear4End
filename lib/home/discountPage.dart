import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class DiscountsPage extends StatefulWidget {
  const DiscountsPage({super.key});

  @override
  State<DiscountsPage> createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage> {
  // สร้างตัวแปรเก็บค่าส่วนลดที่เลือก (0 = ใบแรก, 1 = ใบที่สอง)
  int _selectedDiscount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Discounts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                // ใบที่ 1: ส่วนลดที่มี Badge "Default"
                _buildDiscountItem(
                  index: 0,
                  title: "Discount",
                  description: "xxxxxxxxxxxxxxx",
                  hasBadge: true,
                ),
                // ใบที่ 2: ส่วนลดปกติ
                _buildDiscountItem(
                  index: 1,
                  title: "Discount",
                  description: "xxxxxxxxxxxxxxx",
                  hasBadge: false,
                ),
              ],
            ),
          ),

          // --- ปุ่ม Confirm ด้านล่าง ---
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2, // สีน้ำตาลส้ม
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget สำหรับรายการส่วนลดแต่ละใบ ---
  Widget _buildDiscountItem({
    required int index,
    required String title,
    required String description,
    required bool hasBadge,
  }) {
    bool isSelected = _selectedDiscount == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDiscount = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? primaryColor2 : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (hasBadge) ...[
                        const SizedBox(width: 8),
                        // Badge คำว่า Default
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor2.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Default",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            // ปุ่ม Radio เลือกส่วนลด
            Radio<int>(
              value: index,
              groupValue: _selectedDiscount,
              activeColor: Colors.black, // ปรับสีตามรูป (สีดำ)
              onChanged: (int? value) {
                setState(() {
                  _selectedDiscount = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
