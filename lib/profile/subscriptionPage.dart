import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        // ในรูปเขียนว่า Your Plan อยู่กึ่งกลาง แต่มี Our subscriptions เป็นหัวข้อรอง
        title: const Text(
          "Your Plan",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- ส่วนที่ 1: แผนปัจจุบัน (Free) ---
            _buildSubscriptionCard(
              title: "Free",
              price: "0",
              features: [
                "10 Tastings per month",
                "1 Session per month",
                "Quick CVA only",
                "Basic PDF export",
                "No cross-session comparison",
              ],
              buttonText: "Cancel",
              isCurrentPlan: true,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Our subscriptions",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // --- ส่วนที่ 2: แผนอัปเกรด (Enthusiast) ---
            _buildSubscriptionCard(
              title: "Enthusiast",
              price: "4.99",
              features: [
                "50 Tastings per month",
                "5 Sessions per month",
                "Quick + Affective mode",
                "Full PDF export",
                "No cross-session comparison",
              ],
              buttonText: "Subscriptions",
              isCurrentPlan: false,
            ),

            const SizedBox(height: 30),
            
            // ส่วนท้าย (Knowledge Base / FAQs)
            _buildKnowledgeBaseSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String title,
    required String price,
    required List<String> features,
    required String buttonText,
    required bool isCurrentPlan,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "\$$price",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: primaryColor2,
                  ),
                ),
                const Text(
                  " /month",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // List Features
            ...features.map((item) => _buildFeatureItem(item)).toList(),
            
            const SizedBox(height: 24),
            
            // Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isCurrentPlan ? null : () {}, // ถ้าเป็นแผนปัจจุบันให้กดไม่ได้ (สีเทา)
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCurrentPlan ? Colors.grey.shade300 : primaryColor2,
                  disabledBackgroundColor: Colors.grey.shade300,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16,
                    color: isCurrentPlan ? Colors.white70 : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 16, color: Colors.black87),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF555555),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKnowledgeBaseSection() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF7F5F0), // สีครีมตามต้นฉบับ
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Looking for guidance?",
            style: TextStyle(fontSize: 24, color: Color(0xFF4A4A4A)),
          ),
          const Text(
            "Browse our Knowledge Base",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                "FAQs",
                style: TextStyle(fontSize: 18, color: Color(0xFF4A4A4A)),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}