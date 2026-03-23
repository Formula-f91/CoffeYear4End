import 'package:flutter/material.dart';
import 'package:coffee/constants.dart'; // อย่าลืมเรียกใช้ primaryColor2

class AllCoffeeSamplesPage extends StatelessWidget {
  const AllCoffeeSamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // ใช้ปุ่ม Back ด้านล่างแทน
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "All Coffee Samples",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // --- รายการผลการประเมิน ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: 3, // จำนวนรายการตัวอย่าง
              itemBuilder: (context, index) {
                return _buildAssessmentCard();
              },
            ),
          ),

          // --- ปุ่ม Back ด้านล่างสุด ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: primaryColor2, width: 1.5), // ขอบสีน้ำเงิน
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // ปุ่มขอบเหลี่ยม
                  ),
                ),
                child: Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor2, // ตัวหนังสือสีน้ำเงิน
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget สำหรับสร้าง Card รายการประเมิน
  Widget _buildAssessmentCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryColor2, // พื้นหลังสีน้ำเงิน
        borderRadius: BorderRadius.zero, // การ์ดขอบเหลี่ยม
      ),
      child: Row(
        children: [
          // --- รูปภาพกาแฟ (กลับมาเป็นวงกลม) ---
          Container(
            width: 63,
            height: 63,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle, // กำหนดให้กรอบเป็นวงกลม
            ),
            child: ClipOval( // ตัดรูปภาพให้เป็นวงกลม
              child: Image.asset(
                'assets/images/coffee.png', // รูปจาก assets ของคุณ
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          
          // ข้อมูลการประเมิน
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Descriptive Assessment",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Text(
                      "Name : xxxxxxxx",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "|",
                      style: TextStyle(color: Colors.white70,fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Date : 26.01.23",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 