import 'package:flutter/material.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- 1. Background Image (เต็มจอ) ---
          Positioned.fill(
            child: Image.asset(
              'assets/photo/bgqr.png',
              fit: BoxFit.cover,
            ),
          ),

          // --- 2. Buttons (จัดวางแบบ Responsive) ---
          // ใช้ Align เพื่อดันปุ่มลงไปด้านล่างสุดของจอเสมอ
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea( // ใช้ SafeArea เพื่อไม่ให้ปุ่มติดขอบล่างเกินไป (สำหรับมือถือมีติ่ง)
              child: Padding(
                // ปรับระยะห่างจากขอบล่าง (เช่น 80-100 เพื่อให้พ้นจากจุดศูนย์กลาง)
                padding: const EdgeInsets.only(bottom: 220.0), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // กระจายระยะห่างปุ่มซ้าย-ขวาเท่าๆ กัน
                  children: [
                    // --- ปุ่ม Flash ---
                    _buildCircleButton(
                      iconPath: 'assets/icon/thunder.png',
                      onPressed: () {
                        // Action เปิด/ปิดไฟฉาย
                      },
                    ),

                    // --- ปุ่ม Close ---
                    _buildCircleButton(
                      iconPath: 'assets/icon/cross91.png',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget สร้างปุ่มวงกลมสีขาว
  Widget _buildCircleButton({required String iconPath, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // ปรับขนาดปุ่มตามสัดส่วนจอเล็กน้อย (ใช้ MediaQuery หรือระบุค่าที่เล็กลงหน่อยเพื่อให้ดูเหมาะสมกับหน้าจอทั่วไป)
        width: 80, 
        height: 80,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          // เพิ่มเงาเพื่อให้ปุ่มลอยขึ้นมาจากพื้นหลัง (เลือกใส่หรือไม่ก็ได้)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Image.asset(
          iconPath,
          fit: BoxFit.contain,
          color: Colors.black,
        ),
      ),
    );
  }
}