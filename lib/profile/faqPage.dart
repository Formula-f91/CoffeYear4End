import 'package:flutter/material.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({super.key});

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
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
          "Frequently Asked Questions",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false, // จัดชิดซ้ายตามรูป
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- 1. ช่องค้นหา (Search Bar) ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search for help...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 25),

            // --- 2. รายการคำถามแบบย่อ (See More) ---
            _buildFaqCollapsedCard(),
            const SizedBox(height: 20),

            // --- 3. รายการคำถามแบบขยาย (See Less) ---
            _buildFaqExpandedCard(),
          ],
        ),
      ),
    );
  }

  // Widget สำหรับคำถามที่ยังไม่กดขยาย
  Widget _buildFaqCollapsedCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Frequently Asked Questions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Divider(height: 30),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("See More ", style: TextStyle(color: Colors.grey)),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget สำหรับคำถามที่กดขยายแล้ว (มีรูปภาพและรายละเอียด)
  Widget _buildFaqExpandedCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Frequently Asked Questions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 15),
          // รูปภาพประกอบใน FAQ
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/coffee3.png', // เปลี่ยนเป็นรูปของคุณ
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Details Details Details Details Details Details\n"
            "Details Details Details Details Details Details\n"
            "Details Details Details Details Details Details\n"
            "Details Details Details Details",
            style: TextStyle(color: Colors.black, height: 1.5),
          ),
          const Divider(height: 30),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("See Less ", style: TextStyle(color: Colors.grey)),
                Icon(Icons.keyboard_arrow_up, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}