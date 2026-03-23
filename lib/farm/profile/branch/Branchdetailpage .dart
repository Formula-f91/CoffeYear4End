import 'package:coffee/constants.dart';
import 'package:coffee/farm/profile/branch/%E0%B8%B7NewViewAll.dart';
import 'package:coffee/farm/profile/branch/CoffeeFromFarmPage.dart';
import 'package:flutter/material.dart';

class BranchDetailV2 extends StatefulWidget {
  final String branchName;

  const BranchDetailV2({super.key, required this.branchName});

  @override
  State<BranchDetailV2> createState() => _BranchDetailV2State();
}

class _BranchDetailV2State extends State<BranchDetailV2> {
  int _selectedThumb = 0;

  static const List<Map<String, String>> _products = [
    {'name': 'Coffee Name', 'desc': 'xxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxx'},
    {'name': 'Coffee Name', 'desc': 'xxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxx'},
    {'name': 'Coffee Name', 'desc': 'xxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxx'},
    {'name': 'Coffee Name', 'desc': 'xxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxx'},
  ];

  static const List<String> _thumbImages = [
    'assets/images/farmitem.png',
    'assets/images/farmitem.png',
    'assets/images/farmitem.png',
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
        title: Text(
          widget.branchName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditFarmScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Main Image ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/farm22.png',
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 220,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image, size: 60, color: Colors.grey),
                  ),
                ),
              ),
            ),

            // --- 2. Thumbnail Row ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Row(
                children: List.generate(_thumbImages.length, (index) {
                  final isSelected = index == _selectedThumb;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedThumb = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 55,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF3952A1) : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(_thumbImages[index], fit: BoxFit.cover),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 15),

            // --- 3. Location & Altitude ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 8),
                        Text(
                          'Doichang| Doichang| Doichang|\nDoichang| Doichang| Doichang|',
                          style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Altitude', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 8),
                        Text('10,000 ft', style: TextStyle(fontSize: 13, color: Colors.black87)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- 4. Details ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Text(
                    'Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1 Branch 1',
                    style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
                  ),
                ],
              ),
            ),

            // --- 5. Contact ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Contact', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Owner: Mr. A B', style: TextStyle(fontSize: 13, color: Colors.black87)),
                  Text('Phone: 0987654321', style: TextStyle(fontSize: 13, color: Colors.black87)),
                  Text('Email: email@email.com', style: TextStyle(fontSize: 13, color: Colors.black87)),
                ],
              ),
            ),

            // --- 6. Product Header ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Product', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CoffeeFromFarmPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      elevation: 0,
                    ),
                    child: const Text('View All', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            // --- 7. Product Grid ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
                            child: Image.asset(
                              'assets/images/coffee2.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _products[index]['name']!,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                _products[index]['desc']!,
                                style: TextStyle(fontSize: 11, color: Colors.grey.shade600, height: 1.2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // --- 8. News Header ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('News', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ElevatedButton(
                     onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AllNewsPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      elevation: 0,
                    ),
                    child: const Text('View All', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            // --- 9. News Card ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      'assets/images/coffee.png',
                      width: double.infinity,
                      height: 126,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'News101',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// EditFarmScreen — StatefulWidget พร้อม _showDeleteDialog
// -------------------------------------------------------------------------
class EditFarmScreen extends StatefulWidget {
  const EditFarmScreen({super.key});

  @override
  State<EditFarmScreen> createState() => _EditFarmScreenState();
}

class _EditFarmScreenState extends State<EditFarmScreen> {
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Text(
                      "Delete",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(thickness: 1),
                const SizedBox(height: 24),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF4D4D),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Image.asset(
                      "assets/icon/deletevec.png",
                      width: 50,
                      height: 50,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  "Are you sure you want to delete",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: Color(0xFFFF4D4D)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Color(0xFFFF4D4D), fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // ปิด dialog
                          Navigator.pop(context); // ปิดหน้า edit
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF4D4D),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Farm Information",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Farm Name"),
            _buildTextField("Location"),
            _buildTextField("Altitude"),
            _buildTextField("Detail", maxLines: 5, hint: "51/200"),
            _buildTextField("Contact"),
            const Text(
              "Upload Farm Image",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_outlined, size: 60, color: Colors.grey.shade300),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 1)),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _showDeleteDialog, // เชื่อมกับ dialog
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFF3952A1)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  ),
                  child: const Text("Delete", style: TextStyle(color: Color(0xFF3952A1))),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor2,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    elevation: 0,
                  ),
                  child: const Text("Confirm", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}