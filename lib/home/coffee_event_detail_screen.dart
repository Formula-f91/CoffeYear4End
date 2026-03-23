import 'package:coffee/home/coffee_assessment_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';


class CoffeeEventDetailScreen extends StatefulWidget {
  const CoffeeEventDetailScreen({super.key});

  @override
  State<CoffeeEventDetailScreen> createState() =>
      _CoffeeEventDetailScreenState();
}

class _CoffeeEventDetailScreenState extends State<CoffeeEventDetailScreen> {
  // ตัวแปรเก็บสถานะการเลือกรูปภาพ
  int _selectedIndex = 0;

  // รายการรูปภาพ (เปลี่ยน path ให้ตรงกับ assets ของคุณ)
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
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ส่วนแสดงรูปภาพหลักขนาดใหญ่
                  _buildMainImage(),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ส่วนเลือกรูปภาพเล็ก (Thumbnails)
                        _buildThumbnailRow(),

                        const SizedBox(height: 24),

                        // หัวข้อกิจกรรมและปุ่มแชร์
                        _buildHeaderSection(context),

                        const SizedBox(height: 8),
                        _buildInfoText("Location", isGrey: true),
                        const SizedBox(height: 4),
                        _buildInfoText(
                          "Start Date & Time / End Date & Time",
                          isGrey: true,
                        ),

                        const SizedBox(height: 12),
                        Text(
                          "This cupping event features a variety of specialty coffees. Join us to explore unique flavor profiles and evaluate coffee quality based on the latest standards.",
                          style: TextStyle(
                            color: Colors.grey[500],
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 16),
                        _buildInfoText(
                          "Cupping Protocol (use SCA Arabica 2023)",
                          isBold: false,
                          color: Colors.grey[800],
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
                        _buildBulletPoint("Ethiopia Sidamo G1"),
                        _buildBulletPoint("Brazil Santos NY2"),
                        _buildBulletPoint("Colombia Supremo"),

                        const SizedBox(height: 20),
                        const Text(
                          "Organizer",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildBulletPoint("Coffee Roaster Academy"),
                        _buildBulletPoint("Local Barista Community"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ปุ่ม Join ด้านล่างสุด
          _buildBottomButton(context),
        ],
      ),
    );
  }

  // --- Widgets แยกส่วนเพื่อความสะอาดของโค้ด ---

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Widget _buildMainImage() {
    return Image.asset(
      _thumbnails[_selectedIndex],
      width: double.infinity,
      height: 280,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        height: 280,
        color: Colors.grey[200],
        child: const Icon(Icons.image, size: 50, color: Colors.grey),
      ),
    );
  }

  Widget _buildThumbnailRow() {
    return Row(
      children: List.generate(_thumbnails.length, (index) {
        bool isSelected = _selectedIndex == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedIndex = index),
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2EEFF),
              border: isSelected
                  ? Border.all(color: secondaryColor2, width: 2)
                  : Border.all(color: Colors.transparent, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  _thumbnails[index],
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Cupping Event",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _buildShareIcon(context),
      ],
    );
  }

  Widget _buildShareIcon(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.share_outlined, size: 20, color: Colors.black),
        onPressed: () => _showSharePopup(context),
      ),
    );
  }

  Widget _buildInfoText(
    String text, {
    bool isGrey = false,
    bool isBold = false,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? (isGrey ? Colors.grey[600] : Colors.black),
        fontSize: 14,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
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

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CoffeeEvaluationScreen(),
            ),
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
          "Coffee Cupping Evaluation Results",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 40),
              // QR Code Placeholder
              const Icon(Icons.qr_code_2, size: 180, color: Colors.black87),
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
}
