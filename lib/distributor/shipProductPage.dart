import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // สำหรับฟังก์ชัน Copy
import 'package:coffee/constants.dart'; // เรียกใช้ primaryColor2

class ShipProductPage extends StatelessWidget {
  const ShipProductPage({super.key});

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
          "Ship Product",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // --- กล่องที่ 1: ข้อมูลขนส่งและเลขพัสดุ ---
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero, // ปรับเป็นขอบเหลี่ยม
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildCourierHeader(context),
              ),

              const SizedBox(height: 15), // ระยะห่างระหว่างกล่อง

              // --- กล่องที่ 2: Timeline สถานะพัสดุ ---
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero, // ปรับเป็นขอบเหลี่ยม
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildTrackingTimelineItem(
                      date: "1 Aug 26",
                      time: "09:34",
                      status: "Status", // ข้อความสถานะล่าสุด
                      isActive: true, // จะเป็นสีน้ำเงิน
                      isLast: false,
                    ),
                    _buildTrackingTimelineItem(
                      date: "1 Aug 26",
                      time: "09:34",
                      status: "Status",
                      isActive: false, // วงกลมสีเทา
                      isLast: false,
                    ),
                    _buildTrackingTimelineItem(
                      date: "31 Jul 26",
                      time: "15:34",
                      status: "Status",
                      isActive: false,
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget: ส่วนหัว (โลโก้, ชื่อขนส่ง, เลขพัสดุ, ปุ่ม Copy) ---
  Widget _buildCourierHeader(BuildContext context) {
    const String trackingNumber = "TH12345678910";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  'assets/icons/FLASH.png',
                ), 
                fit: BoxFit.cover, 
              ),
            ),
          ),
          const SizedBox(width: 10),
          
          const Expanded(
            child: Text(
              "FLASH Express",
              style: TextStyle(fontSize: 12, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          const SizedBox(width: 10),

          const Flexible(
            child: Text(
              trackingNumber,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),

          GestureDetector(
            onTap: () {
              Clipboard.setData(const ClipboardData(text: trackingNumber)).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Tracking number copied!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              });
            },
            child: Text(
              "Copy",
              style: TextStyle(
                color: primaryColor2, // เปลี่ยนสีปุ่ม Copy เป็นสีน้ำเงินด้วยเพื่อให้เข้า theme
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget: รายการ Timeline แต่ละจุด ---
  Widget _buildTrackingTimelineItem({
    required String date,
    required String time,
    required String status,
    required bool isActive,
    required bool isLast,
  }) {
    final Color activeColor = primaryColor2; // ใช้สีน้ำเงินแทนสีส้มเดิม
    final Color inactiveColor = Colors.grey.shade300; 

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 10,
                    color: isActive ? Colors.black : Colors.grey.shade600, // ปรับสีวันที่ active ให้เข้มขึ้น
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 10,
                    color: isActive ? Colors.black : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),

          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isActive ? activeColor : inactiveColor,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: activeColor, // เส้นเชื่อมสีน้ำเงิน
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    status,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}