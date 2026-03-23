import 'package:flutter/material.dart';
import 'package:coffee/constants.dart'; // เรียกใช้ primaryColor2

class CoffeeFromFarmPage extends StatelessWidget {
  const CoffeeFromFarmPage({super.key});

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
          "Coffee from Your Farm",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- 1. Search Bar (กรอบเหลี่ยม) ---
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 48,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search coffee",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero, // กรอบสี่เหลี่ยม
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: primaryColor2),
                  ),
                ),
              ),
            ),
          ),

          // --- 2. Product Grid ---
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.68, // สัดส่วนการ์ดให้เหมือนหน้า Branch 1
              ),
              itemCount: 8, // จำนวนสินค้าจำลอง (ปรับได้)
              itemBuilder: (context, index) => _buildProductCard(),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget สร้าง Product Card (ใช้แบบเดียวกับ Branch 1) ---
  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // บังคับให้เนื้อหาขยายเต็มความกว้าง
        children: [
          // --- ส่วนรูปภาพ ---
          Expanded(
            child: Image.asset(
              "assets/images/coffee2.png",
              fit: BoxFit.cover, // ให้รูปขยายเต็มพื้นที่พอดีโดยไม่เสียสัดส่วน
            ),
          ),
          
          // --- ส่วนข้อความ ---
          Padding(
            padding: const EdgeInsets.all(12.0), // ปรับระยะขอบให้สวยงาม
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // ให้ Column สูงเท่าที่ข้อความต้องการจริงๆ
              children: [
                const Text(
                  "Coffee Name",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  maxLines: 1, // ป้องกันข้อความยาวจนดันรูป
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "xxxxxxxxxxxxxxxxxxxxxxx",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}