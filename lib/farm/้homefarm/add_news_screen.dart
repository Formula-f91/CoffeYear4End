import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final TextEditingController _newsNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Add News",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // --- News Name ---
                  _buildLabel("News Name"),
                  _buildTextField(
                    controller: _newsNameController,
                    hintText: "",
                  ),

                  const SizedBox(height: 24),

                  // --- Upload Image ---
                  _buildLabel("Upload Image"),
                  _buildImageUploader(),

                  const SizedBox(height: 24),

                  // --- Description ---
                  _buildLabel("Description"),
                  _buildDescriptionField(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // --- Bottom Confirm Button ---
          _buildBottomButton(),
        ],
      ),
    );
  }

  // Widget สำหรับหัวข้อ Label
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  // Widget สำหรับ TextField ทั่วไป
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC67C4E), width: 1.5),
        ),
      ),
    );
  }

  // Widget สำหรับช่อง Upload Image (เส้นประ)
  Widget _buildImageUploader() {
    return GestureDetector(
      onTap: () {
        // TODO: Implement Image Picker logic
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // สร้างเอฟเฟกต์เส้นประ (ใช้ Border ธรรมดา หรือ Custom Painter)
          border: Border.all(
            color: Colors.grey.shade300,
            style: BorderStyle.solid, // เปลี่ยนเป็นพู่กันประถ้ามี Package
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(
              Icons.image_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }

  // Widget สำหรับ Description ที่มีตัวเลขบอกจำนวนคำ
  Widget _buildDescriptionField() {
    return Column(
      children: [
        TextField(
          controller: _descriptionController,
          maxLines: 5,
          maxLength: 1000,
          decoration: InputDecoration(
            counterText: "", // ปิด Counter ปกติเพื่อเลียนแบบ Layout
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFC67C4E),
                width: 1.5,
              ),
            ),
          ),
        ),
        // ตัวเลข 51/1,000 ชิดขวาด้านในหรือด้านล่าง
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Text(
              "${_descriptionController.text.length}/1,000",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  // Widget สำหรับปุ่มยืนยันด้านล่าง
  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            // TODO: Confirm Logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor2,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 0,
          ),
          child: const Text(
            "Confirm",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
