import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  // กำหนดภาษาเริ่มต้นเป็นภาษาไทย
  String selectedLanguage = "ไทย";

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
          "Change Language",
          style: TextStyle(
            color: Colors.black, 
            fontSize: 20, 
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: false, // จัดชิดซ้ายตามรูป
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Your Language",
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ตัวเลือกภาษาไทย
                  _buildLanguageOption("ไทย"),
                  const SizedBox(height: 12),

                  // ตัวเลือกภาษาอังกฤษ
                  _buildLanguageOption("English"),
                  const SizedBox(height: 12),

                  // ตัวเลือกภาษาอื่นๆ (xxxx)
                  _buildLanguageOption("xxxx"),
                ],
              ),
            ),
          ),

          // --- ปุ่ม Confirm ด้านล่าง ---
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            child: ElevatedButton(
              onPressed: () {
                // Logic สำหรับเปลี่ยนภาษาในแอป
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2, // สีน้ำตาลส้มตามธีม
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(
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

  // Widget สำหรับสร้างตัวเลือกภาษาที่มี Radio อยู่ด้านหน้า
  Widget _buildLanguageOption(String language) {
    bool isSelected = selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? secondaryColor2 : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: language,
              groupValue: selectedLanguage,
              activeColor: secondaryColor2, // สีจุดน้ำตาลตามรูป
              onChanged: (String? value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              language,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w500,
                color: Colors.black87
              ),
            ),
          ],
        ),
      ),
    );
  }
}