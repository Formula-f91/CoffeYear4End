import 'package:flutter/material.dart';
import 'package:coffee/profile/cupping/cuppingDetailPage.dart';
import 'package:coffee/constants.dart'; // ตรวจสอบให้แน่ใจว่าเรียกใช้ primaryColor2 

class RecentCuppingsPage extends StatefulWidget {
  const RecentCuppingsPage({super.key});

  @override
  State<RecentCuppingsPage> createState() => _RecentCuppingsPageState();
}

class _RecentCuppingsPageState extends State<RecentCuppingsPage> {
  // 0 = Host, 1 = Join
  bool isHostTab = true;
  // ตัวแปรสำหรับเก็บค่าแท็กที่เลือก
  String selectedCategory = "All";

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
          "Recent Cuppings",
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
          // 1. ส่วนค้นหาและฟิลเตอร์ไอคอน
          _buildSearchAndFilter(),

          // 2. แท็บสลับ Host / Join
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _buildTabItem("Cuppings You Host", isHostTab, () {
                    setState(() => isHostTab = true);
                  }),
                  _buildTabItem("Cuppings You Join", !isHostTab, () {
                    setState(() => isHostTab = false);
                  }),
                ],
              ),
            ),
          ),

          // 3. ส่วน Filter Tags (ปรับเป็นสีน้ำเงิน)
          _buildFilterTags(),

          // 4. ส่วนแสดงเนื้อหาตามแท็บที่เลือก
          Expanded(
            child: isHostTab ? _buildHostList() : _buildJoinList(),
          ),
        ],
      ),
    );
  }

  // --- Widget: ส่วน Filter Tags ---
  Widget _buildFilterTags() {
    final categories = ["All", "xxxx", "xxxxx"];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = categories[index];
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10, top: 5, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.shade50 : Colors.white, // พื้นหลังสีฟ้าอ่อนเมื่อถูกเลือก
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey.shade300,
                ),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? primaryColor2 : Colors.black, // ตัวหนังสือสีน้ำเงินเมื่อถูกเลือก
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Widget: ปุ่มแท็บหลัก ---
  Widget _buildTabItem(String text, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: isActive
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                : [],
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? Colors.black : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  // --- ส่วนรายการเนื้อหา ---
  Widget _buildHostList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      itemCount: 2,
      itemBuilder: (context, index) => _buildCuppingCard(context, "Cupping Event"),
    );
  }

  Widget _buildJoinList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      itemCount: 3,
      itemBuilder: (context, index) => _buildCuppingCard(context, "Cupping Event"),
    );
  }

  // --- Widget: การ์ดแสดงรายการ (ปรับให้เหมือนในรูป) ---
  Widget _buildCuppingCard(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              'assets/images/coffee.png',
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                const Divider(height: 1), // เส้นคั่น
                const SizedBox(height: 12),
                
                // แถววันที่
                _buildInfoRow('assets/icons/calendar.png', "Start Date & Time / End Date & Time"),
                
                const SizedBox(height: 12),
                const Divider(height: 1), // เส้นคั่น
                const SizedBox(height: 12),
                
                // แถวสถานที่ และ ปุ่ม
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoRow('assets/icons/location.png', "Location"),
                    Row(
                      children: [
                        // ปุ่ม Edit
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primaryColor2),
                            minimumSize: const Size(0, 30),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
                            ),
                          ),
                          child: Text("Edit", style: TextStyle(fontSize: 14, color: primaryColor2, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        // ปุ่ม Read More
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CuppingDetailPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor2,
                            minimumSize: const Size(0, 30),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
                            ),
                            elevation: 0,
                          ),
                          child: const Text("Read More", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
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

  // --- Widget: Search Bar และปุ่ม Filter ---
  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.zero, // กรอบเหลี่ยมตามรูป
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search coffee",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/icons/filter.png',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget: แถวไอคอนข้อความ (ปรับเป็นสีน้ำเงิน) ---
  Widget _buildInfoRow(String imagePath, String text) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 24, // ลดขนาดไอคอนให้สมส่วนกับรูป
          height: 24,
          color: primaryColor2, // ใช้สีน้ำเงินหลัก
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor2, // ตัวหนังสือสีน้ำเงิน
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}