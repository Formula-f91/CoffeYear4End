import 'package:coffee/constants.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/CoffeeCuppingResultsScreen.dart';
import 'package:flutter/material.dart';

class CuppingSessionListScreen extends StatelessWidget {
  const CuppingSessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Cupping Session",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 4, // จำนวนรายการตัวอย่าง
        itemBuilder: (context, index) {
          return _buildCuppingListItem(context);
        },
      ),
    );
  }

  Widget _buildCuppingListItem(BuildContext context) {
    return GestureDetector(
      // --- ทำให้กดที่ตัว Card ทั้งใบแล้วนำทางไปหน้า Results ---
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CoffeeCuppingResultsScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ส่วนรูปภาพ
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.asset(
                'assets/images/coffee.png',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cupping Session",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),

                  // วันที่
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: secondaryColor2,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Start / End Date & Time",
                        style: TextStyle(color: secondaryColor2, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),

                  // สถานที่ และ ปุ่ม Read More
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: secondaryColor2,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Location",
                            style: TextStyle(
                              color: secondaryColor2,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // --- ใส่การนำทางที่ปุ่มด้วยเช่นกัน ---
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CoffeeCuppingResultsScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor2,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Read More",
                          style: TextStyle(color: Colors.white, fontSize: 13),
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
