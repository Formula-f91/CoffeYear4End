import 'package:coffee/constants.dart';
import 'package:coffee/cupping/coffee_detail_screen.dart';
import 'package:coffee/cupping/edit_cupping_screen.dart';
import 'package:coffee/cupping/qr_scanner_screen.dart';
import 'package:flutter/material.dart';

class CoffeeEventListOnlyScreen extends StatefulWidget {
  const CoffeeEventListOnlyScreen({super.key});

  @override
  State<CoffeeEventListOnlyScreen> createState() =>
      _CoffeeEventListOnlyScreenState();
}

class _CoffeeEventListOnlyScreenState extends State<CoffeeEventListOnlyScreen> {
  // --- ใช้ชื่อตัวแปรและข้อมูลชุดเดียวกับ Code 1 ---
  String selectedCategory = "All";

  final List<Map<String, dynamic>> allEvents = [
    {
      "title": "SCA CVA Descriptive",
      "desc": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      "date": "Start Date & Time / End Date",
      "status": "Upcoming",
      "statusColor": Colors.grey[300],
      "statusTextColor": Colors.black,
    },
    {
      "title": "SCA CVA Affective",
      "desc": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      "date": "Start Date & Time / End Date",
      "status": "Open for Evaluation",
      "statusColor": const Color(0xFFE5F9EA),
      "statusTextColor": const Color(0xFF4CAF50),
    },
    {
      "title": "SCA CVA Combined",
      "desc": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      "date": "Start Date & Time / End Date",
      "status": "Open for Evaluation",
      "statusColor": const Color(0xFFE5F9EA),
      "statusTextColor": const Color(0xFF4CAF50),
    },
  ];

  final List<Map<String, dynamic>> createEvents = [
    {
      "title": "My Created Session",
      "desc": "Sessions that you have created",
      "date": "Start Date & Time / End Date",
      "status": "Upcoming",
      "statusColor": Colors.grey[300],
      "statusTextColor": Colors.black,
    },
  ];

  final List<Map<String, dynamic>> joinEvents = [
    {
      "title": "Public SCA Event",
      "desc": "Events available to join",
      "date": "Start Date & Time / End Date",
      "status": "Open for Evaluation",
      "statusColor": const Color(0xFFE5F9EA),
      "statusTextColor": const Color(0xFF4CAF50),
    },
  ];

  void _handleCardTap(BuildContext context, Map<String, dynamic> event) {
    // เช็คสถานะเพื่อส่งค่า isAvailable เป็น true หรือ false
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
    // --- เลือกข้อมูลตาม Category ที่เลือก ---
    List<Map<String, dynamic>> displayEvents;
    if (selectedCategory == "Create") {
      displayEvents = createEvents;
    } else if (selectedCategory == "Join") {
      displayEvents = joinEvents;
    } else {
      displayEvents = allEvents;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // --- ตัด FloatingActionButton ออกแล้วตามคำสั่ง ---
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildCategories(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: displayEvents.length,
                  itemBuilder: (context, index) {
                    return _buildEventCard(displayEvents[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    Color buttonBgColor = selectedCategory == "All"
        ? Colors.white
        : primaryColor;
    Color iconColor = selectedCategory == "All" ? Colors.black : Colors.white;

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
        if (selectedCategory != "All") ...[
          const SizedBox(width: 8),
          _buildImageButton(
            assetPath: 'assets/group.png',
            backgroundColor: buttonBgColor,
            iconColor: iconColor,
            onPressed: () {},
          ),
        ],
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
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: backgroundColor == Colors.white
                ? Colors.grey.shade100
                : Colors.transparent,
          ),
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 28,
            height: 28,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryChip("All"),
          // _buildCategoryChip("Create"),
          // _buildCategoryChip("Join"),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    final bool isActive = selectedCategory == label;
    final Color customActiveColor = const Color(0x1A947257);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? customActiveColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.brown[800] : Colors.black,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return GestureDetector(
      onTap: () => _handleCardTap(context, event),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
                top: Radius.circular(16),
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
                        "Start Date & Time / End Date",
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
