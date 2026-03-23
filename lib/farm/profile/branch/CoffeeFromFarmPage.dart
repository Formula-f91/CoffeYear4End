
import 'package:coffee/farm/profile/branch/EditCoffeeInformationPage.dart';
import 'package:coffee/farm/profile/branch/ProductDetailPageSimple.dart';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart'; // ตรวจสอบว่ามี primaryColor2 ในไฟล์นี้

class CoffeeFromFarmPage extends StatelessWidget {
  const CoffeeFromFarmPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
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
          // --- 1. Search Bar ---
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
                    borderRadius: BorderRadius.zero,
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio:
                    0.7, // ปรับเล็กน้อยเพื่อให้สมดุลกับความสูงรูปภาพ
              ),
              itemCount: 8,
              // ในส่วน build ของหน้า CoffeeFromFarmPage
              itemBuilder: (context, index) =>
                  _buildProductCard(context), // ส่ง context เข้าไปตรงนี้
            ),
          ),
        ],
      ),
      // --- เพิ่มปุ่ม Add New ที่ด้านล่างจอ ---
      bottomNavigationBar: Container(
        // กำหนดเส้นขอบด้านบน
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          color: Colors.white, // กำหนดสีพื้นหลังของแถบด้านล่าง
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditCoffeeInformationPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor2,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Add New",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget สร้าง Product Card ---
  // 1. เพิ่ม BuildContext เข้าไปใน parameter เพื่อให้ใช้ Navigator ได้
  Widget _buildProductCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 2. เมื่อคลิกที่การ์ด ให้เปิดหน้า ProductDetailPageSimple
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductDetailPageSimple(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ใช้ Expanded แทน SizedBox แบบกำหนดความสูงตายตัว
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ClipRect(
                  child: Image.asset(
                    "assets/images/coffee2.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[100],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                10,
                10,
                10,
              ), // ปรับ padding ด้านล่างเล็กน้อยให้สวยงาม
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Coffee Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "xxxxxxxxxxxx",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "xxxxxxxxxxxx",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
