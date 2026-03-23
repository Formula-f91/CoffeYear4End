import 'package:flutter/material.dart';
import 'package:coffee/profile/order/refundReturn.dart';

class ProblemIdentificationPage extends StatelessWidget {
  const ProblemIdentificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Problem Identification',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          _buildProblemItem(
            iconPath:
                'assets/icons/CardboardBox.png', // เปลี่ยนเป็นชื่อไฟล์ของคุณ
            title: 'Received damaged goods or goods in poor condition',
            subtitle:
                'The received product has scratches, is broken, leaking/spilled, not functioning properly, or is expired',
            onTap: () {}, 
          ),
          _buildProblemItem(
            iconPath: 'assets/icons/Cancel.png',
            title:
                'Received the wrong item or did not receive the ordered item',
            subtitle:
                'The received item is not what was ordered / differs from the description',
            onTap: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RefundReturnFlow(),
                            ),
                          );},
          ),
          _buildProblemItem(
            iconPath: 'assets/icons/OpenBox.png',
            title:
                'Received incomplete items or have not received the parcel for this order',
            subtitle:
                'Received fewer items than ordered / received an empty box / have not received the parcel for this order',
            onTap: () {},
          ),
          _buildProblemItem(
            iconPath: 'assets/icons/BoxImportant.png',
            title: 'Others',
            subtitle: '',
            isLast: true, // รายการสุดท้ายไม่มีเส้นคั่น
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProblemItem({
    required String iconPath, // เปลี่ยนจาก IconData เป็น String
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ส่วนของ Icon ที่เปลี่ยนมาใช้ Image.asset
                Image.asset(
                  iconPath,
                  width: 28, // กำหนดขนาดให้เท่ากับ Icon มาตรฐาน
                  height: 28,
                  color: Colors
                      .grey[600], // ใส่สีทับได้ถ้าเป็นไฟล์ PNG แบบโปร่งแสง
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[400],
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isLast)
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: Color(0xFFEEEEEE),
            ),
        ],
      ),
    );
  }
}
