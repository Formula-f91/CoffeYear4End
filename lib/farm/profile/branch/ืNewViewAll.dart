import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';

class AllNewsPage extends StatelessWidget {
  const AllNewsPage({super.key});

  static const List<Map<String, String>> _newsList = [
    {'title': 'News101', 'desc': 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', 'image': 'assets/images/coffee.png'},
    {'title': 'News102', 'desc': 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', 'image': 'assets/images/coffee.png'},
    {'title': 'News103', 'desc': 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', 'image': 'assets/images/coffee.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'News',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _newsList.length,
        separatorBuilder: (_, __) => Divider(height: 32, color: Colors.grey.shade200),
        itemBuilder: (context, index) {
          final news = _newsList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                news['image']!,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                news['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(
                news['desc']!,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                // TODO: navigate to add news page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              ),
              child: const Text(
                'Add New',
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}