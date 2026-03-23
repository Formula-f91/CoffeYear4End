import 'package:coffee/constants.dart';
import 'package:coffee/cupping/select_form_screen.dart';
import 'package:flutter/material.dart';

class CoffeeDetailScreen extends StatefulWidget {
  // 1. เพิ่มตัวแปรเช็คสถานะ
  final bool isAvailable;

  // 2. รับค่าผ่าน Constructor
  const CoffeeDetailScreen({super.key, required this.isAvailable});

  @override
  State<CoffeeDetailScreen> createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends State<CoffeeDetailScreen> {
  int _selectedIndex = 0;

  final List<String> _thumbnails = [
    'assets/Image.png',
    'assets/Image.png',
    'assets/Image.png',
    'assets/Image.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Main Image ---
                  Image.asset(
                    _thumbnails[_selectedIndex],
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.cover,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Thumbnails ---
                        Row(
                          children: List.generate(_thumbnails.length, (index) {
                            return _buildThumbnail(
                              _thumbnails[index],
                              _selectedIndex == index,
                              index,
                            );
                          }),
                        ),
                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Cupping Event",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // 3. ใช้ if เช็คสถานะเพื่อแสดงปุ่ม Share (ถ้า isAvailable = true ถึงจะแสดง)
                            if (widget.isAvailable)
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Image.asset(
                                    'assets/icon/shareicon.png',
                                    width: 20,
                                    height: 22,
                                  ),
                                  onPressed: () => _showSharePopup(context),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Location",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Start Date & Time / End Date & Time",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                          style: TextStyle(
                            color: Colors.grey[500],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Cupping Protocol (use SCA Arabica 2023)",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "All Coffee Samples",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                        _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                        _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                        const SizedBox(height: 20),
                        const Text(
                          "Organizer",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                        _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                        _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 4. แสดงปุ่มด้านล่างตามสถานะ isAvailable
          widget.isAvailable
              ? _buildAvailableButton()
              : _buildNotAvailableButton(),
        ],
      ),
    );
  }

  // --- แยก Widget ปุ่มด้านล่างออกมาเพื่อความสะอาดของโค้ด ---

  // กรณี isAvailable == true (เปิดให้ประเมิน)
  Widget _buildAvailableButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SelectFormScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor2,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 54),
        ),
        child: const Text(
          "Join Evaluation",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // กรณี isAvailable == false (ยังไม่เปิดให้ประเมิน)
  Widget _buildNotAvailableButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: ElevatedButton(
        onPressed: () {
          // ไม่ทำอะไรเมื่อกดยังไม่เปิด
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFAAAAAA),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 54),
        ),
        child: const Text(
          "Not yet available",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildThumbnail(String asset, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF2EEFF),
          border: isSelected
              ? Border.all(color: primaryColor2, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(asset, width: 54, height: 54, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  void _showSharePopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 450,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Share Cupping Event",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              const SizedBox(height: 20),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    'assets/icon/qrsharev2.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.qr_code_2,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Download QR",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 8),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: Colors.grey),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        ],
      ),
    );
  }
}
