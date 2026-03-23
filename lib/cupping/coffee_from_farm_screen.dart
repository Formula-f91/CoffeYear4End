import 'package:coffee/constants.dart';
import 'package:coffee/cupping/CoffeInfoAdd%20.dart';
import 'package:flutter/material.dart';

class CoffeeFromFarmScreen extends StatefulWidget {
  const CoffeeFromFarmScreen({super.key});

  @override
  State<CoffeeFromFarmScreen> createState() => _CoffeeFromFarmScreenState();
}

class _CoffeeFromFarmScreenState extends State<CoffeeFromFarmScreen> {
  // Mock Data สำหรับรายการกาแฟ
  final List<String> coffeeItems = [
    "Coffee Name",
    "Coffee Name",
    "Coffee Name",
    "Coffee Name",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Coffee from Your Farm",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search coffee",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/Search.png',
                      width: 16,
                      height: 16,
                      fit: BoxFit.contain,
                    ),
                  ),
                  border: InputBorder.none,
                  // --- ปรับส่วนนี้เพื่อขยับข้อความลงมา ---
                  contentPadding: const EdgeInsets.only(
                    top:
                        15, // เพิ่มค่า top เพื่อดันข้อความลงมา (ลองปรับตัวเลข 14-16)
                    bottom: 11, // ลดค่า bottom เพื่อรักษาสมดุลความสูง 48
                  ),
                  // ------------------------------------
                ),
              ),
            ),
          ),
          // 2. Grid List (รายการกาแฟ)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 คอลัมน์
                childAspectRatio:
                    0.75, // อัตราส่วน กว้าง:สูง ของการ์ด (ปรับได้ตามความเหมาะสม)
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: coffeeItems.length,
              itemBuilder: (context, index) {
                return _buildCoffeeCard(coffeeItems[index]);
              },
            ),
          ),

          // 3. Add New Button
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            decoration: const BoxDecoration(color: Colors.white),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
               onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CoffeInfoAdd(),
                  ),
                );
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor2,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Add New",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget สร้างการ์ดกาแฟแต่ละใบ
  Widget _buildCoffeeCard(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // รูปภาพ
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(0),
              ),
              child: Image.asset(
                'assets/images/coffee2.png', // เปลี่ยนเป็นรูปเมล็ดกาแฟตามต้องการ
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // เนื้อหาด้านล่าง
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // // ปุ่ม ... (Option)
                    // Container(
                    //   width: 32,
                    //   height: 32,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey.shade300),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: const Icon(
                    //     Icons.more_horiz,
                    //     size: 20,
                    //     color: Colors.black54,
                    //   ),
                    // ),
                    // const SizedBox(width: 8),
                    // ปุ่ม Select Coffee
                    Expanded(
                      child: SizedBox(
                        height: 32,
                        child: ElevatedButton(
                          onPressed: () {
                            // Action Select
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor2,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            padding:
                                EdgeInsets.zero, // ลด padding ให้ข้อความไม่ตก
                            elevation: 0,
                          ),
                          child: const Text(
                            "Select Coffee",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
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
