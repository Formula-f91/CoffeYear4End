import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class EditNewsPage extends StatefulWidget {
  const EditNewsPage({super.key});

  @override
  State<EditNewsPage> createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // รายการรูปภาพตัวอย่าง
  final List<String> _images = [
    'assets/images/coffee.png',
    'assets/images/coffee.png',
    'assets/images/coffee.png',
    'assets/images/coffee.png',
  ];

  // --- 1. ฟังก์ชันแสดง Popup ยืนยันการลบ ---
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, // มั่นใจว่าเป็นพื้นหลังขาว
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // หัวข้อ Delete
                const Row(
                  children: [
                    Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // สีหัวข้อชัดเจน
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(thickness: 1),
                const SizedBox(height: 24),

                // --- ส่วนไอคอนที่มีวงกลมสีแดงด้านหลัง ---
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // วงกลมสีแดงพื้นหลัง
                    Container(
                      width: 100, // ปรับขนาดวงกลมตามความเหมาะสม
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF4D4D), // สีแดงสด
                        shape: BoxShape.circle,
                      ),
                    ),
                    // ไอคอนกากบาท (deletevec.png)
                    Image.asset(
                      "assets/icon/deletevec.png",
                      width: 50, // ปรับขนาดไอคอนให้พอดีกับวงกลม
                      height: 50,
                      color: Colors
                          .white, // หากไอคอนเป็นไฟล์ภาพ ให้เปลี่ยนสีเป็นขาว (ถ้าต้องการ)
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ข้อความยืนยัน
                const Text(
                  "Are you sure you want to delete",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),

                // ปุ่ม Cancel และ Confirm
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(
                            color: Color(0xFFFF4D4D),
                          ), // ขอบสีเดียวกับวงกลม
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Color(0xFFFF4D4D),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFFF4D4D,
                          ), // สีปุ่มเดียวกับวงกลม
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Edit News",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("News Name"),
                  _buildTextField(controller: _nameController, hint: ""),
                  const SizedBox(height: 24),

                  _buildLabel("Image"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildAddButton(),
                        const SizedBox(width: 12),
                        ...List.generate(_images.length, (index) {
                          return _buildImagePreview(_images[index]);
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildLabel("Description"),
                  _buildDescriptionField(),
                ],
              ),
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: const Color(0xFFA2A2A2), // 20% Opacity
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: Color(0xFFC67C4E), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: const Icon(Icons.add_circle_outline, color: Colors.grey, size: 28),
    );
  }

  Widget _buildImagePreview(String assetPath) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Stack(
      children: [
        TextField(
          controller: _descController,
          maxLines: 5,
          maxLength: 1000,
          onChanged: (text) => setState(() {}),
          decoration: InputDecoration(
            counterText: "",
            contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: const Color(0xFFA2A2A2),
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(
                color: Color(0xFFC67C4E),
                width: 1.5,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 16,
          child: Text(
            "${_descController.text.length}/1,000",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(24),
       decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 1)),
            ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: _showDeleteDialog, // เรียกใช้ Popup
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.redAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                "Delete",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
