import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/cupping/cupping_result_detail_screen.dart'; // Import ไฟล์หน้ารายละเอียดใหม่

class CuppingEvaluationResultsScreen extends StatelessWidget {
  const CuppingEvaluationResultsScreen({super.key});

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
          "Results",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // ส่ง context เข้าไปเพื่อใช้ Navigator
                _buildResultCard(context),
                const SizedBox(height: 12),
                _buildResultCard(context),
                const SizedBox(height: 12),
                _buildResultCard(context),
              ],
            ),
          ),

          // Bottom Back Button
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: secondaryColor2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text("Back", style: TextStyle(color: secondaryColor2, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // --- ไปหน้า Result Detail ---
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CuppingResultDetailScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // สีน้ำตาล
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage('assets/photo/coffepro.png'), // ใช้รูปกาแฟ
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Descriptive Assessment",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      "Name : xxxxxx",
                      style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 12),
                    ),
                    Container(
                      height: 12,
                      width: 1,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Text(
                      "Date : 26.01.23",
                      style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 12),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}