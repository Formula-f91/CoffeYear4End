import 'package:coffee/constants.dart';
import 'package:coffee/cupping/add_cupping_session_screen.dart';
import 'package:coffee/cupping/coffee_detail_screen.dart';
import 'package:coffee/cupping/cupping_evaluation_results_screen.dart';
import 'package:coffee/cupping/edit_cupping_screen.dart';
import 'package:coffee/cupping/qr_scanner_screen.dart';
import 'package:flutter/material.dart';

class CoffeeEventScreen extends StatefulWidget {
  const CoffeeEventScreen({super.key});

  @override
  State<CoffeeEventScreen> createState() => _CoffeeEventScreenState();
}

class _CoffeeEventScreenState extends State<CoffeeEventScreen> {
  // --- 1. เหลือไว้แค่ข้อมูลสำหรับหน้า Create ---
  final List<Map<String, dynamic>> createEvents = [
    {
      "title": "My Created Session",
      "desc": "Sessions that you have created",
      "date": "Start Date & Time / End Date",
      "status": "Open for Evaluation", // ปรับเป็น Open เพื่อให้ไปหน้าฟอร์มได้
      "statusColor": const Color(0xFFE5F9EA),
      "statusTextColor": const Color(0xFF4CAF50),
    },
  ];

  void _handleCardTap(BuildContext context, Map<String, dynamic> event) {
    bool isAvailable = event['status'] == "Open for Evaluation";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoffeeDetailScreen(isAvailable: isAvailable),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- 2. แสดงปุ่มสร้าง Session เสมอ ---
      floatingActionButton: SizedBox(
        width: 59,
        height: 59,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddCuppingSessionScreen(),
              ),
            );
          },
          backgroundColor: secondaryColor2,
          shape: const CircleBorder(),
          elevation: 4,
          child: Image.asset(
            'assets/icon/plusname.png',
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              // --- 3. ตัด _buildCategories() ออกไป และแสดง List เลย ---
              Expanded(
                child: ListView.builder(
                  itemCount: createEvents.length,
                  itemBuilder: (context, index) {
                    return _buildEventCard(createEvents[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 4. ปรับสี Header ให้เป็นของหน้า Create ---
  Widget _buildHeader(BuildContext context) {
    Color buttonBgColor = primaryColor;
    Color iconColor = Colors.white;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(0),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/Search.png',
                    width: 17,
                    height: 17,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _buildImageButton(
          assetPath: 'assets/qrcode.png',
          backgroundColor: buttonBgColor,
          iconColor: iconColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QrScannerScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildImageButton({
    required String assetPath,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 28,
            height: 28,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // --- 5. ปรับ Card ให้แสดงปุ่ม Edit และ Read More โดยไม่ต้องมีเงื่อนไข Tab ---
  Widget _buildEventCard(Map<String, dynamic> event) {
    return GestureDetector(
      onTap: () {
        _handleCardTap(context, event);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(0),
              ),
              child: Image.asset(
                'assets/Image.png',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event['desc'],
                    style: TextStyle(color: Colors.grey[500]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Image.asset(
                        'assets/fi_calendar.png',
                        width: 24,
                        height: 24,
                        color: secondaryColor2,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        event['date'],
                        style: TextStyle(fontSize: 12, color: secondaryColor2),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: event['statusColor'],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          event['status'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: event['statusTextColor'],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Image.asset(
                        'assets/location.png',
                        width: 24,
                        height: 24,
                        color: secondaryColor2,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Location",
                        style: TextStyle(fontSize: 12, color: secondaryColor2),
                      ),
                      const Spacer(),

                      // ปุ่ม Edit แสดงเสมอในหน้า Create
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditCuppingScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: secondaryColor2,
                          side: BorderSide(color: secondaryColor2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          minimumSize: const Size(25, 32),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // ปุ่ม Read More แสดงเสมอในหน้า Create
                      ElevatedButton(
                        onPressed: () => _handleCardTap(context, event),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor2,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          minimumSize: const Size(80, 32),
                        ),
                        child: const Text(
                          "Read More",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
