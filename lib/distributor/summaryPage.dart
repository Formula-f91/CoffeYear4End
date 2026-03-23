import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/distributor/productPage.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  // ตัวแปรสำหรับเก็บสถานะตัวกรองเวลาที่เลือก (0 = All, 1 = Yesterday, ...)
  int _selectedFilterIndex = 0;
  final List<String> _filters = [
    "All",
    "Yesterday",
    "7 days ago",
    "30 days ago",
  ];

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
          "Summary",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      // ใส่ SafeArea ป้องกันรอยบากและแถบด้านล่างของจอ
      body: SafeArea(
        child: Center(
          // จำกัดความกว้างสูงสุดไม่ให้เกิน 600 เพื่อให้ดูสวยงามบน Tablet
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // 1. ส่วนหัวโปรไฟล์
                  _buildProfileHeader(),
                  const SizedBox(height: 20),

                  // 2. แถบตัวกรองเวลา (เลื่อนแนวนอนได้)
                  _buildTimeFilters(),
                  const SizedBox(height: 20),

                  // 3. ตารางสถิติ (2x2 Grid) ส่ง context ไปคำนวณขนาด
                  _buildStatsGrid(context),
                  const SizedBox(height: 30),

                  // 4. หัวข้อ Top Selling Products
                  _buildSectionHeader("Top Selling Products"),
                  const SizedBox(height: 15),

                  // 5. รายการสินค้าขายดี
                  _buildTopSellingList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget: ส่วนหัวโปรไฟล์ ---
  Widget _buildProfileHeader() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(
            'assets/images/profile.png',
          ), // อย่าลืมใส่รูปใน assets
          backgroundColor: Colors.grey,
        ),
        SizedBox(width: 15),
        // ใช้ Expanded ป้องกันกรณีชื่อโปรไฟล์ยาวเกินจอ
        Expanded(
          child: Text(
            "XXXXXXXXXX",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // --- Widget: แถบตัวกรองเวลา ---
  Widget _buildTimeFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_filters.length, (index) {
          final isSelected = _selectedFilterIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedFilterIndex = index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor2.withAlpha(70) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    // แก้ไขตรงนี้: ถ้าเลือกอยู่ให้ใช้สีส้ม ถ้าไม่เลือกให้ใช้สีเทาอ่อน
                    color: isSelected
                        ? primaryColor2
                        : Colors.grey.shade300,
                    width: isSelected
                        ? 1.5
                        : 1.0, // เพิ่มความหนาเมื่อเลือกเพื่อให้ดูเด่นขึ้น
                  ),
                ),
                child: Text(
                  _filters[index],
                  style: TextStyle(
                    color: isSelected ? primaryColor2 : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // --- Widget: ตารางสถิติ ---
  Widget _buildStatsGrid(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double effectiveWidth = screenWidth > 600 ? 600 : screenWidth;

    final double itemWidth = (effectiveWidth - 40 - 15) / 2;
    // จุดแก้ไขที่ 1: เพิ่มความสูงจาก 100.0 เป็น 115.0 เพื่อให้พอดีกับข้อความ 2 บรรทัด
    const double itemHeight = 115.0;
    final double dynamicAspectRatio = itemWidth / itemHeight;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: dynamicAspectRatio,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [
        _buildStatCard("0", "Total Sales"),
        _buildStatCard("0", "Orders"),
        _buildStatCard("0", "Customer"),
        _buildStatCard("0", "Average Order Value (AOV)"),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      // จุดแก้ไขที่ 2: ปรับ padding ลงนิดหน่อยเพื่อให้มีพื้นที่ด้านในมากขึ้น
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // ให้ Column ใช้พื้นที่เท่าที่จำเป็น
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          // จุดแก้ไขที่ 3: ใช้ Flexible ครอบข้อความไว้ ป้องกันข้อความดันจนทะลุกล่อง
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget: หัวข้อ Section (มีเส้นขีดข้างๆ) ---
  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }

  // --- Widget: รายการสินค้าขายดี ---
  Widget _buildTopSellingList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2, // จำนวนสินค้าตัวอย่าง
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) => _buildProductCard(context),
    );
  }

  Widget _buildProductCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // รูปสินค้า
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/coffee2.png', // เปลี่ยนรูปตามจริง
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),

          // ชื่อและราคา (ใช้ Expanded ทำให้ยืดหยุ่นเต็มพื้นที่ที่เหลือ)
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Coffee Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1, // ป้องกันชื่อยาวเกิน
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  "฿100",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1D2A4D),
                  ),
                ),
              ],
            ),
          ),

          // ปุ่ม Details
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductDetailPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              minimumSize: const Size(0, 30),
              elevation: 0,
            ),
            child: const Text(
              "Details",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
