import 'package:flutter/material.dart';

class AdditionalCommentsScreen extends StatelessWidget {
  const AdditionalCommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data สำหรับแสดงผลตามภาพ
    final List<String> comments = List.generate(
      5,
      (index) =>
          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    );

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
          "Additional Comments",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: comments.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200), // เส้นขอบสีเทาจางๆ
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Customer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  comments[index],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 1.5, // ระยะห่างระหว่างบรรทัด
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}