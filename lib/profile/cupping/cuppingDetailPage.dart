import 'package:flutter/material.dart';
import 'package:coffee/profile/cupping/allCoffeeSamplesPage.dart';
import 'package:coffee/constants.dart'; // อย่าลืมเรียกใช้ primaryColor2

class CuppingDetailPage extends StatelessWidget {
  const CuppingDetailPage({super.key});

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
          "Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24, // ปรับขนาดให้เข้ากับหน้าอื่นๆ
          ),
        ),
        centerTitle: true,
      ),
      // --- เปลี่ยน body ให้เหลือแค่ส่วนที่ Scroll ได้ ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- รูปภาพหลัก ---
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // ปรับความมนให้เข้ากับธีมใหม่
              child: Image.asset(
                'assets/images/coffee.png',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),

            // --- รูป Thumbnails ---
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildThumbnail(),
                _buildThumbnail(),
                _buildThumbnail(),
              ],
            ),

            const SizedBox(height: 25),
            const Text(
              "Cupping Event",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Location",
              style: TextStyle(color: primaryColor2, fontSize: 12, fontWeight: FontWeight.bold), // เปลี่ยนเป็นสีน้ำเงิน
            ),
            const SizedBox(height: 6),
            const Text(
              "Start Date & Time / End Date & Time",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            const SizedBox(height: 20),
            const Text(
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
              style: TextStyle(
                color: Colors.grey,
                height: 1.5,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Cupping Protocol ที่ใช้ (เช่น SCA Arabica 2023)",
              style: TextStyle(
                color: Colors.grey,
                height: 1.5,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 25),
            const Text(
              "All Samples",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black, // ปรับให้เป็นสีดำตามธีมใหม่
              ),
            ),
            _buildBulletList([
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxx",
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxx",
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxx",
            ]),

            const SizedBox(height: 25),
            const Text(
              "Organizer",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black, // ปรับให้เป็นสีดำ
              ),
            ),
            _buildBulletList([
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxx",
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxx",
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxx",
            ]),
          ],
        ),
      ),

      // --- ย้ายปุ่มมาไว้ใน bottomNavigationBar ---
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade200)), // เส้นคั่นด้านบน
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllCoffeeSamplesPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor2, // ใช้สีน้ำเงินหลัก
              minimumSize: const Size(double.infinity, 50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // ปุ่มกรอบเหลี่ยม
              ),
              elevation: 0,
            ),
            child: const Text(
              "Coffee Cupping Evaluation Results",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), // ปรับขอบให้มนน้อยลง
          image: const DecorationImage(
            image: AssetImage('assets/images/coffee.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "• ",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.grey,
                        height: 1.5,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}