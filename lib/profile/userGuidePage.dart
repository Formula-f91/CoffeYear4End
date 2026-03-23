import 'package:flutter/material.dart';

class UserGuidePage extends StatelessWidget {
  const UserGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- 1. แถบหัวเรื่อง (AppBar) ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "User Guide",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      
      // --- 2. เนื้อหา (Content) ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // หัวข้อย่อยในหน้าเนื้อหา
            const Text(
              "User Guide",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            
            // เนื้อความยาว (จำลองด้วย xxxxx ตามรูป)
            const Text(
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxx",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6, // ระยะห่างระหว่างบรรทัดเพื่อให้อ่านง่าย
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}