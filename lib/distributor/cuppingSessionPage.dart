import 'package:coffee/profile/cupping/cuppingDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';

class CuppingSessionPage extends StatelessWidget {
  const CuppingSessionPage({super.key});

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
          "Cupping Session",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 2, // จำนวนการ์ดจำลอง
        itemBuilder: (context, index) {
          return _buildSessionCard(context);
        },
      ),
    );
  }

  // --- Widget: การ์ดแสดงข้อมูล Cupping Session ---
  Widget _buildSessionCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.zero, // การ์ดขอบเหลี่ยม
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- รูปภาพหลัก ---
          Image.asset(
            'assets/images/coffee.png', // เปลี่ยนเป็นรูปของคุณ
            height: 130,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // --- เนื้อหาด้านล่างรูป ---
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cupping Session",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Session Code : CUP - 123",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 12),
                const Divider(height: 1), // เส้นคั่น
                const SizedBox(height: 12),

                // --- แถววันที่ ---
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/calendar.png',
                      width: 20,
                      height: 20,
                      color: secondaryColor2,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Start / End Date & Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(height: 1), // เส้นคั่น
                const SizedBox(height: 12),

                // --- แถวสถานที่ และ ปุ่มกด ---
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/location.png',
                      width: 20,
                      height: 20,
                      color: secondaryColor2,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(), // ดันปุ่มไปชิดขวา
                    // ปุ่ม Edit (พื้นขาว ขอบน้ำเงิน)
                    SizedBox(
                      height: 28,
                      child: OutlinedButton(
                        onPressed: () {
                          // โค้ดเมื่อกดปุ่ม Edit
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // พื้นหลังสีขาว
                          elevation: 0, // ลบเงาออกเพื่อให้ดูเป็นกรอบแบนๆ สวยงาม
                          side: BorderSide(
                            color: primaryColor2, // สีของเส้นขอบ
                            width: 1, // ความหนาของเส้น
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // ปุ่ม Read More (พื้นน้ำเงิน)
                    SizedBox(
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CuppingDetailPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                        "Read More",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
