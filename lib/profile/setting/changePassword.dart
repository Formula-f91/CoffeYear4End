import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // ตัวแปรสำหรับคุมสถานะหน้า (0 = Current, 1 = New, 2 = Confirm)
  int currentStep = 0;

  // หัวข้อของแต่ละหน้า
  final List<String> titles = [
    "Enter Current Password",
    "Enter New Password",
    "Confirm New Password"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            if (currentStep > 0) {
              setState(() => currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          "Change Password",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titles[currentStep],
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  // ช่องกรอกรหัสผ่านแบบปิดตา (Obscure)
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFC07651)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- ปุ่ม Next / Confirm ด้านล่าง ---
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            child: ElevatedButton(
              onPressed: () {
                if (currentStep < 2) {
                  setState(() => currentStep++);
                } else {
                  // Logic บันทึกรหัสผ่านใหม่สำเร็จ
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                elevation: 0,
              ),
              child: Text(
                currentStep == 2 ? "Confirm" : "Next",
                style: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}