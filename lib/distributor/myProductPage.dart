import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/distributor/productPage.dart';
import 'package:coffee/distributor/addProductPage.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  bool isOnSale = true;

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
          "My Products",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildStatusToggle(),
          Expanded(child: _buildProductGrid(context)),
        ],
      ),
      bottomNavigationBar: _buildBottomAddButton(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: "Search coffee",
            hintStyle: TextStyle(color: Colors.grey),
            icon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _buildToggleItem("On Sale", isOnSale, () {
            setState(() => isOnSale = true);
          }),
          const SizedBox(width: 15),
          _buildToggleItem("Out of Stock", !isOnSale, () {
            setState(() => isOnSale = false);
          }),
        ],
      ),
    );
  }

  Widget _buildToggleItem(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        decoration: BoxDecoration(
          color: active ? primaryColor2.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? primaryColor2 : Colors.grey.shade200,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active ? primaryColor2 : Colors.black,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = (screenWidth - 40 - 15) / 2;
    const double itemHeight = 245.0; // เพิ่มความสูงเล็กน้อยเพื่อให้รับกับดาว
    final double dynamicAspectRatio = itemWidth / itemHeight;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: dynamicAspectRatio,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => _buildProductCard(context),
    );
  }

  Widget _buildProductCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductDetailPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(0),
                    ),
                    child: Image.asset(
                      'assets/images/coffee2.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  // --- ส่วนดาวคะแนนที่นำกลับมา ---
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 12),
                          SizedBox(width: 4),
                          Text(
                            "4.8",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Coffee Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "text",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end, // เปลี่ยนจาก spaceBetween เป็น end เพื่อดันข้อมูลไปขวาสุด
                    children: [
                      const Text(
                        "Price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF2F2D2C),
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

  Widget _buildBottomAddButton() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCoffeeInfoPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Add Product",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
