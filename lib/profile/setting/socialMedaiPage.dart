import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

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
          "Social Media",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false, // จัดชิดซ้ายตามรูป
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const Divider(),
            const SizedBox(height: 10),
            
            // 1. Facebook
            _buildSocialItem(
              logoPath: 'assets/icons/facebook.png',
              title: "Connect with Facebook",
              isConnected: false,
              onTap: () {},
            ),
            
            const SizedBox(height: 30),
            
            // 2. Google (สถานะเชื่อมต่อแล้ว จึงเป็นปุ่ม Cancel)
            _buildSocialItem(
              logoPath: 'assets/icons/google.png',
              title: "Connect with Google",
              isConnected: true,
              onTap: () {},
            ),
            
            const SizedBox(height: 30),
            
            // 3. Line
            _buildSocialItem(
              logoPath: 'assets/icons/LINE.png',
              title: "Connect with Line",
              isConnected: false,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Widget สำหรับแต่ละรายการโซเชียล
  Widget _buildSocialItem({
    required String logoPath,
    required String title,
    required bool isConnected,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        // โลโก้จาก Assets
        Image.asset(logoPath, width: 40, height: 40),
        const SizedBox(width: 15),
        
        // ข้อความ
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        
        // ปุ่ม Connect / Cancel
        SizedBox(
          width: 90,
          height: 35,
          child: isConnected 
            ? OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  padding: EdgeInsets.zero,
                ),
                child: const Text("Cancel", style: TextStyle(color: Colors.black, fontSize: 16)),
              )
            : ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                child: const Text("Connect", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
        ),
      ],
    );
  }
}