import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/cupping/cupping_evaluation_results_screen.dart';

class CuppingDetailsScreen extends StatefulWidget { // 1. เปลี่ยนเป็น StatefulWidget
  const CuppingDetailsScreen({super.key});

  @override
  State<CuppingDetailsScreen> createState() => _CuppingDetailsScreenState();
}

class _CuppingDetailsScreenState extends State<CuppingDetailsScreen> {
  // 2. เพิ่มตัวแปรเก็บสถานะการเลือก (เริ่มต้นที่ 0)
  int _selectedIndex = 0;

  // รายการรูปภาพ
  final List<String> _thumbnails = [
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            // ระบุ path ที่ลงทะเบียนไว้ใน pubspec.yaml
            icon: Image.asset(
              'assets/icon/settingicon.png', 
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            onPressed: () {
              // ใส่ Logic การทำงานเมื่อกดปุ่มตรงนี้
            },
          )
        ],
      ),

        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFEF5350)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Delete",
                        style: TextStyle(color: Color(0xFFEF5350), fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const CuppingEvaluationResultsScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor2,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Cupping Evaluation Results",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Hero Image Section ---
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    // 3. แสดงรูปภาพตาม Index ที่เลือก
                    child: Image.asset(
                      _thumbnails[_selectedIndex], 
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  // --- Thumbnails ---
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      // 4. ใช้ List.generate เพื่อสร้าง Thumbnail
                      children: List.generate(_thumbnails.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: _buildThumbnail(
                            _thumbnails[index],
                            _selectedIndex == index,
                            index,
                          ),
                        );
                      }),
                    ),
                  ),

                  // --- Content Info --- (ส่วนนี้คงเดิมตามโค้ดของคุณ)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Cupping Session", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () => _showShareBottomSheet(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300),
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  'assets/icon/shareicon.png',
                                  width: 20,
                                  height: 25,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text("Location", style: TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        const Text("Start / End Date & Time", style: TextStyle(fontSize: 14)),
                        const SizedBox(height: 16),
                        Text(
                          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                        const Text("Cupping Protocol Used (e.g., SCA Arabica 2023)", style: TextStyle(fontSize: 14)),
                        const SizedBox(height: 24),
                        const Text("All Coffee Samples", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        _buildBulletList([
                          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                        ]),
                        const SizedBox(height: 24),
                        const Text("Organizer", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        _buildBulletList([
                          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                        ]),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Bottom Buttons --- (ส่วนนี้คงเดิมตามโค้ดของคุณ)
         
        ],
      ),
    );
  }

  // 5. ปรับปรุง _buildThumbnail ให้เลือกกดได้และมี Padding
  Widget _buildThumbnail(String imagePath, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: 60, height: 60,
        decoration: BoxDecoration(
          // เปลี่ยนสีพื้นหลังเป็น #F2EEFF ตามมาตรฐานที่คุณใช้หน้าอื่น
          color: const Color(0xFFF2EEFF),
          // ขอบสีน้ำตาล #C67C4E เมื่อถูกเลือก
          border: isSelected 
              ? Border.all(color: primaryColor2, width: 2) 
              : Border.all(color: Colors.transparent, width: 2), 
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0), // ระยะห่างจากขอบถึงรูป
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  // --- ฟังก์ชันอื่นๆ คงเดิม ---
  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Share Cupping Event", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const Divider(),
              const SizedBox(height: 20),
              Container(
                width: 208, height: 208,
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                child: Image.asset('assets/icon/qrshare.png', fit: BoxFit.contain), 
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text("Download", style: TextStyle(color: Colors.grey.shade700, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("• ", style: TextStyle(fontSize: 14)),
              Expanded(child: Text(item, style: const TextStyle(fontSize: 14))),
            ],
          ),
        );
      }).toList(),
    );
  }
}