import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. ใช้ DefaultTabController เพื่อควบคุมการสลับหน้า Tab
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.only(
              top: 20,
            ), // ดันตัวหนังสือลงมาอีกนิดถ้าต้องการ
            child: Text(
              "Notifications",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          // --- 2. ส่วนของ TabBar ---
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black, // เส้นใต้สีดำตามภาพ
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            tabs: [
              Tab(text: "Explore"),
              Tab(text: "Transaction Status"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildExploreTab(), // หน้าตามภาพที่ส่งมาใหม่
            _buildTransactionTab(), // หน้าเดิมที่คุณเขียนไว้ (แบบจุดสีแดง)
          ],
        ),

        // Bottom Navigation Bar (Optional - ตามภาพ)
      ),
    );
  }

  // --- 3. หน้า Explore (ตามภาพที่แนบมา) ---
  Widget _buildExploreTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Special Promotions"),
          const SizedBox(height: 12),
          // Horizontal List สำหรับ Promotions
          SizedBox(
            height: 225,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildPromotionCard();
              },
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader("News"),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFEEEEEE), // สีเทาอ่อนตามแบบในภาพ
          ),
          // List สำหรับ News
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _buildNewsItem();
            },
          ),
        ],
      ),
    );
  }

  // --- 4. หน้าเดิม (Transaction Status) ---
  Widget _buildTransactionTab() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: 5,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFF0F0F0),
        indent: 25,
        endIndent: 25,
      ),
      itemBuilder: (context, index) {
        return _buildOldNotificationItem();
      },
    );
  }

  // --- UI Components สำหรับหน้า Explore ---

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: const Row(
            children: [
              Text("View all", style: TextStyle(color: Colors.black)),
              Icon(Icons.chevron_right, color: Colors.blue, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPromotionCard() {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image.asset(
              'assets/images/promotion.png', // เปลี่ยนเป็น path ของคุณ
              height: 150,
              width: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                color: Colors.blueGrey.shade100,
                child: const Center(child: Text("11.11 Promo Image")),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Special Promotions",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
          ),
          const SizedBox(height: 3),
          const Text(
            "text",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ), // ปรับ padding ให้สมดุล
          child: Row(
            children: [
              // ส่วนแสดงรูปภาพ
              ClipRRect(
                borderRadius: BorderRadius.circular(0), // ตามที่คุณกำหนด
                child: Image.asset(
                  'assets/images/view_image.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // รายละเอียดข่าว
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "News",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4), // เพิ่มระยะห่างเล็กน้อยระหว่างบรรทัด
                  Text(
                    "02.02.2026",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        // เส้นขีดคั่น
        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFEEEEEE), // สีเทาอ่อนตามแบบในภาพ
        ),
      ],
    );
  }

  // --- UI Components เดิม ---

  Widget _buildOldNotificationItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                  style: TextStyle(fontSize: 12, height: 1.4),
                ),
                SizedBox(height: 8),
                Text(
                  "1m ago.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_outlined),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          label: "",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
      ],
    );
  }
}
