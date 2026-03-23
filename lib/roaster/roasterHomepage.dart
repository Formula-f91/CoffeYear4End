import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/distributor/myProductPage.dart';
import 'package:coffee/distributor/summaryPage.dart';

import 'package:coffee/distributor/orderPage.dart'; 

class RoasterHomepage extends StatelessWidget {
  const RoasterHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. ส่วนหัว (Header) รูปภาพพร้อมข้อมูลโปรไฟล์ และ การ์ด Status ---
            _buildHeader(context),
    
            // --- 2. ส่วนเมนูหลัก ---
            _buildQuickMenu(context),

            // --- 3. ส่วน Banner โฆษณา/โปรโมชั่น พร้อม Indicator ---
            _buildPromoBanner(context),

            // --- 4. ส่วน Special Offer และปุ่ม View All ---
            _buildSpecialOfferSection(context),

            const SizedBox(height: 30), // เว้นระยะด้านล่างสุดของหน้าจอ
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    
    final double bgHeight = 140.0 + topPadding;
    final double stackHeight = bgHeight + 65.0;

    return SizedBox(
      height: stackHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: bgHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              // ใช้รูปภาพแทนสีดำ และเอา BorderRadius ออก (ไม่ใส่ขอบ)
              image: DecorationImage(
                image: AssetImage('assets/images/head.png'), // ระบุ Path รูปภาพ
                fit: BoxFit.cover, // ให้รูปขยายเต็มพื้นที่พอดี
              ),
            ),
            // ปรับ padding ให้ดันลงมาจากรอยบากอัตโนมัติ
            padding: EdgeInsets.fromLTRB(20, topPadding + 15, 20, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: const Text(
                    "XXXXXXXXXXXX",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: bgHeight - 45, // ให้กล่องสีขาวเกยขึ้นไปบนรูปภาพ 45 pixel ตลอดเวลา
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatusItem("0", "Pending"),
                  _buildStatusItem("0", "To Be Shipped"),
                  _buildStatusItem("0", "Cancelled"),
                  _buildStatusItem("0", "Review"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String count, String label) {
    return Expanded( 
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Text(
            count,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center, 
            style: const TextStyle(fontSize: 11, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMenuCard(
            "My Products",
            "assets/icons/product.png",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyProductsPage()),
              );
            },
          ),
          const SizedBox(width: 12), 
          _buildMenuCard(
            "Order", 
            "assets/icons/order.png", 
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const StatusPage()));
            },
          ),
          const SizedBox(width: 12),
          _buildMenuCard(
            "Summary",
            "assets/icons/summary.png",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SummaryPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, String assetPath, {VoidCallback? onTap}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Image.asset(
                    assetPath,
                    width: 28,
                    height: 28,
                    color: primaryColor2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double bannerHeight = (screenWidth - 40) * 0.35; 

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: bannerHeight, 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/Banner - 1.png'), 
              fit: BoxFit.cover, 
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIndicator(isActive: true),
            const SizedBox(width: 5),
            _buildIndicator(isActive: false),
            const SizedBox(width: 5),
            _buildIndicator(isActive: false),
          ],
        )
      ],
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return Container(
      width: 25,
      height: 4,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFF08040) : const Color(0xFFB0C4DE).withOpacity(0.6),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildSpecialOfferSection(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = (screenWidth - 40 - 15) / 2; 
    const double itemHeight = 210.0; 
    final double dynamicAspectRatio = itemWidth / itemHeight;

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Divider(indent: 40, endIndent: 15, thickness: 1)),
              Text(
                "Special Offer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Divider(indent: 15, endIndent: 40, thickness: 1)),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: dynamicAspectRatio, 
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: 2,
          itemBuilder: (context, index) => _buildProductCard(),
        ),
        
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 15.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                // TODO: ใส่ลิงก์เมื่อกด View All
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD), 
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                'assets/images/coffee.png', 
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Flat White",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  "text",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}