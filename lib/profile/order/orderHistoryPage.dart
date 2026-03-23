import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- 1. AppBar พร้อมปุ่มย้อนกลับ ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Order History",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // --- 2. หมวดหมู่ Today ---
          const Text(
            "Today",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildHistoryCard(
            items: [
              {"name": "Coffee Name", "price": "฿100"},
              {"name": "Coffee Name", "price": "฿100"},
              {"name": "Coffee Name", "price": "฿100"},
            ],
            total: "฿300",
          ),

          const SizedBox(height: 30),
          
          // --- 3. เส้นคั่น Previous History ---
          Row(
            children: const [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Previous history",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: Divider()),
            ],
          ),

          const SizedBox(height: 20),
          
          // --- 4. หมวดหมู่ตามวันที่ (20 Jan 2026) ---
          const Text(
            "20 Jan 2026",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(height: 10),
          _buildHistoryCard(
            items: [
              {"name": "Coffee Name", "price": "฿100"},
              {"name": "Coffee Name", "price": "฿100"},
              {"name": "Coffee Name", "price": "฿100"},
              {"name": "Coffee Name", "price": "฿100"},
              {"name": "Coffee Name", "price": "฿100"},
            ],
            total: "฿500",
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Widget สำหรับสร้าง Card สรุปยอดในแต่ละวัน
  Widget _buildHistoryCard({required List<Map<String, String>> items, required String total}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          // หัวตาราง
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Order", style: TextStyle(color: Colors.grey, fontSize: 13)),
              Text("Price", style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
          const Divider(),
          
          // รายการสินค้า
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/coffee.png', // เปลี่ยนเป็นรูปเมล็ดกาแฟของคุณ
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Text(item['name']!, style: const TextStyle(fontSize: 14)),
                const Spacer(),
                Text(item['price']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )).toList(),
          
          const Divider(),
          
          // ยอดรวมสรุปท้าย Card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                total,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}