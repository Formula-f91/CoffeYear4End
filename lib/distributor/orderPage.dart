import 'package:coffee/constants.dart';
import 'package:coffee/distributor/orderStatusPage.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  int _selectedTabIndex = 0; // 0=In Progress, 1=Completed, 2=Cancelled

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
          "Status",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      // SafeArea ช่วยป้องกันเนื้อหาโดนรอยบาก หรือ แถบ Home Indicator ด้านล่างบัง
      body: SafeArea(
        child: Column(
          children: [
            _buildSegmentedControl(),
            const SizedBox(height: 25),
            Expanded(
              child: _buildOrderList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem("In Progress", 0),
          _buildTabItem("Completed", 1),
          _buildTabItem("Cancelled", 2),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final bool isSelected = _selectedTabIndex == index;
    // Expanded ช่วยให้ Tab ทั้ง 3 อันแบ่งความกว้างหน้าจอเท่าๆ กันอัตโนมัติ
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        spreadRadius: 1)
                  ]
                : [],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  // --- Logic การแสดงรายการสินค้า ---
  Widget _buildOrderList() {
    if (_selectedTabIndex == 1) {
      // 1. กรณี Completed
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildOrderCard(
            "Coffee Name",
            "100",
            "Completed",
            statusBg: const Color(0xFFE5F9ED),
            statusText: const Color(0xFF27AE60),
            isOutlinedBtn: true,
            onDetailsPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderStatusPage(initialStep: 3),
                ),
              );
            },
          ),
          _buildOrderCard(
            "Coffee Name",
            "100",
            "Completed",
            statusBg: const Color(0xFFE5F9ED),
            statusText: const Color(0xFF27AE60),
            isOutlinedBtn: true,
            onDetailsPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderStatusPage(initialStep: 3),
                ),
              );
            },
          ),
        ],
      );
    } else if (_selectedTabIndex == 2) {
      // 2. กรณี Cancelled
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildOrderCard(
            "Coffee Name",
            "100",
            "Cancel",
            statusBg: const Color(0xFFFFE5E5),
            statusText: Colors.red,
            isOutlinedBtn: false,
            onDetailsPressed: () {},
          ),
        ],
      );
    } else {
      // 3. กรณี In Progress (Default)
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildOrderCard(
            "Coffee Name",
            "100",
            "Pending",
            statusBg: Colors.grey.shade300,
            onDetailsPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderStatusPage(initialStep: 0)),
              );
            },
          ),
          _buildOrderCard(
            "Coffee Name",
            "100",
            "Preparing",
            statusBg: Colors.grey.shade300,
            onDetailsPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderStatusPage(initialStep: 1)),
              );
            },
          ),
          _buildOrderCard(
            "Coffee Name",
            "100",
            "Shipping",
            statusBg: Colors.grey.shade300,
            onDetailsPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderStatusPage(initialStep: 2)),
              );
            },
          ),
        ],
      );
    }
  }

  Widget _buildOrderCard(
    String name,
    String price,
    String status, {
    required Color statusBg,
    Color statusText = Colors.black87,
    bool isOutlinedBtn = false,
    required VoidCallback onDetailsPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // รูปภาพ คงขนาดไว้ตายตัวเพราะเป็น Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/coffee2.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ใช้ Expanded หุ้ม Text เพื่อให้ตัดบรรทัดได้ ไม่ล้นจอ
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: statusText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ใช้ Flexible กันกรณีราคาตัวเลขยาวมากๆ ไม่ให้ไปทับปุ่ม
                    Flexible(
                      child: Text(
                        "฿$price",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1D2A4D),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 30,
                      child: isOutlinedBtn
                          ? OutlinedButton(
                              onPressed: onDetailsPressed,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: primaryColor2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                              ),
                              child: Text("Details",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor2)),
                            )
                          : ElevatedButton(
                              onPressed: onDetailsPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                elevation: 0,
                              ),
                              child: const Text("Details",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)),
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