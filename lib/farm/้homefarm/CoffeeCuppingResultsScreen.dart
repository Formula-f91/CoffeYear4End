import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Combinedform/combined_assessment_screen.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/CuppingResultScreen.dart';
import 'package:flutter/material.dart';

class CoffeeCuppingResultsScreen extends StatefulWidget {
  const CoffeeCuppingResultsScreen({super.key});

  @override
  State<CoffeeCuppingResultsScreen> createState() =>
      _CoffeeCuppingResultsScreenState();
}

class _CoffeeCuppingResultsScreenState
    extends State<CoffeeCuppingResultsScreen> {
  int _selectedIndex = 0;

  // รายการรูปภาพ
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
          // --- 3. Coffee Cupping Evaluation Results Button ---
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // คุณสามารถเปลี่ยนจุดหมายปลายทางของ Navigator ได้ตามต้องการ
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CuppingResultScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 54),
              ),
              child: const Text(
                "Coffee Cupping Evaluation Results",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
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
