import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- 1. ส่วนหัวหน้าจอ (AppBar) ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Reviews",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      
      // --- 2. รายการรีวิวแบบแนวตั้ง ---
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: 5, // จำนวนรีวิวทั้งหมด
        itemBuilder: (context, index) {
          return _buildReviewCard();
        },
      ),
    );
  }

  // --- 3. Widget บัตรคำรีวิว (Reuse จากหน้า Detail) ---
  Widget _buildReviewCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Alex Morgan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              // ดาวเรตติ้ง 5 ดวง
              Row(
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star_rounded,
                    color: Colors.orange,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // ข้อความรีวิว
          const Text(
            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
            style: TextStyle(
              color: Color(0xFF5C6B89),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}