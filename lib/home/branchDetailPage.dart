import 'package:coffee/home/coffeeFromFarmPage.dart';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart'; // เรียกใช้ primaryColor2

class BranchDetailPage extends StatefulWidget {
  const BranchDetailPage({super.key, required String branchName});

  @override
  State<BranchDetailPage> createState() => _BranchDetailPageState();
}

class _BranchDetailPageState extends State<BranchDetailPage> {
  // จำลอง Index รูปภาพที่ถูกเลือก
  int _selectedImageIndex = 0;
  final List<String> _images = [
    'assets/images/farm1.png',
    'assets/images/farm2.png',
    'assets/images/farm2.png',
  ];

  @override
  Widget build(BuildContext context) {
    // 1. ดึงขนาดหน้าจอเพื่อทำ Responsive
    final size = MediaQuery.of(context).size;
    final isTablet =
        size.width > 600; // เช็คว่าเป็นหน้าจอใหญ่ (แท็บเล็ต) หรือไม่

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
          "Growing Area1",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20, // ปรับขนาดให้พอดี
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/setting-2.png',
              color: Colors.black,
              width: 28,
              height: 28,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          // 2. จำกัดความกว้างเนื้อหาไม่ให้เกิน 800 (เพื่อไม่ให้ยืดเกินไปบนแท็บเล็ต/เว็บ)
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // --- 1. รูปภาพหลัก (Main Image) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      _images[0],
                      width: double.infinity,
                      // 3. ปรับความสูงเป็น Responsive (25% ของจอ แต่ไม่ต่ำกว่า 200)
                      height: (size.height * 0.25).clamp(200.0, 350.0),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- 2. รูปภาพย่อย (Thumbnails) ---
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImageIndex = index;
                          });
                        },
                        child: Container(
                          width: 50,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _selectedImageIndex == index
                                  ? primaryColor2
                                  : Colors.transparent,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: AssetImage(_images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // --- 3. รายละเอียด Location & Altitude ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Location",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Doichang Doichang Doichang\nDoichang Doichang Doichang",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Altitude",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "10,000 ft",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // --- 4. Details ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // --- 5. Contact ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contact",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Owner: Mr. A B\nPhone: 0987654321\nEmail: email@email.com",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // --- 6. Product Section ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Product",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CoffeeFromFarmPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor2,
                          minimumSize: const Size(70, 32),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "View All",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // --- 7. Product Grid (Responsive) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // 4. เปลี่ยนเป็น SliverGridDelegateWithMaxCrossAxisExtent ให้ปรับจำนวนคอลัมน์อัตโนมัติ
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          220, // กว้างสุดไม่เกิน 220 ต่อการ์ด (มือถือจะได้ 2, แท็บเล็ต 3-4 คอลัมน์)
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: isTablet
                          ? 0.85
                          : 0.75, // ปรับสัดส่วนกล่องให้ไม่ยืดเกินไป
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) => _buildProductCard(),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget สร้าง Product Card ---
  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset("assets/images/coffee2.png", fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Coffee Name",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ), // ปรับขนาดตัวอักษรลงนิดนึงเพื่อป้องกันล้น
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                const Text(
                  "xxxxxxxxxxxxxxxxxxxx",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12, // ปรับขนาดข้อความรองให้พอดีกับการ์ด
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
