import 'package:flutter/material.dart';
import 'package:coffee/profile/order/orderHistoryPage.dart';
import 'package:coffee/profile/order/orderDetailPage.dart';
import 'package:coffee/constants.dart'; // เรียกใช้ primaryColor2 (สีน้ำเงิน)

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({super.key});

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  // 0 = In Progress, 1 = Completed, 2 = Cancelled
  int selectedTab = 0;

  void _showReviewSheet(BuildContext context) {
    int selectedRating = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Review",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black54),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "What do you think of this order?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Please rate and write a review",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                selectedRating = index + 1;
                              });
                            },
                            child: Icon(
                              Icons.star,
                              color: index < selectedRating
                                  ? const Color(0xFFF2994A)
                                  : Colors.grey.shade200,
                              size: 45,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 25),
                      TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Write your review here...",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: primaryColor2, // ใช้สีน้ำเงิน
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          print("Rating submitted: $selectedRating");
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor2, // สีน้ำเงิน
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

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
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _buildTabItem("In Progress", 0),
                  _buildTabItem("Completed", 1),
                  _buildTabItem("Cancelled", 2),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                // --- แท็บ In Progress ---
                if (selectedTab == 0) ...[
                  _buildOrderCard(
                    title: "Coffee Name",
                    statusText: "To Pay",
                    statusBg: Colors.grey.shade200,
                    statusTextColor: Colors.grey.shade700,
                    tag: "Repeat 2 Order",
                    tagBg: const Color(0xFFFFEBE6), // สีชมพูอ่อน
                    tagText: primaryColor2, // สีน้ำเงิน
                  ),
                  _buildOrderCard(
                    title: "Coffee Name",
                    statusText: "To Pay",
                    statusBg: Colors.grey.shade200,
                    statusTextColor: Colors.grey.shade700,
                    tag: "First purchase",
                    tagBg: const Color(0xFFE8F5E9), // สีเขียวอ่อน
                    tagText: const Color(0xFF4CAF50),
                  ),
                  _buildOrderCard(
                    title: "Coffee Name",
                    statusText: "To Pay",
                    statusBg: Colors.grey.shade200,
                    statusTextColor: Colors.grey.shade700,
                    tag: "First purchase",
                    tagBg: const Color(0xFFE8F5E9),
                    tagText: const Color(0xFF4CAF50),
                  ),
                ] 
                // --- แท็บ Completed ---
                else if (selectedTab == 1) ...[
                  _buildOrderCard(
                    title: "Coffee Name",
                    statusText: "Claim",
                    statusBg: const Color(0xFFFFEBE6), // สีชมพูอ่อน
                    statusTextColor: primaryColor2, // สีน้ำเงิน
                    tag: "Repeat 2 Order",
                    tagBg: Colors.blue.shade50, // สีฟ้าอ่อน
                    tagText: primaryColor2, // สีน้ำเงิน
                    isCompletedTab: true,
                  ),
                  _buildOrderCard(
                    title: "Coffee Name",
                    statusText: "Completed",
                    statusBg: const Color(0xFFE8F5E9), // สีเขียวอ่อน
                    statusTextColor: const Color(0xFF4CAF50),
                    tag: "First purchase",
                    tagBg: const Color(0xFFE8F5E9),
                    tagText: const Color(0xFF4CAF50),
                    isCompletedTab: true,
                  ),
                  _buildOrderCard(
                    title: "Coffee Name",
                    statusText: "Completed",
                    statusBg: const Color(0xFFE8F5E9), // สีเขียวอ่อน
                    statusTextColor: const Color(0xFF4CAF50),
                    tag: "First purchase",
                    tagBg: const Color(0xFFE8F5E9),
                    tagText: const Color(0xFF4CAF50),
                    isCompletedTab: true,
                  ),
                ] 
                // --- แท็บ Cancelled ---
                else ...[
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        "No Cancelled Orders",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 10),
                
                // --- ส่วนหัวตารางสรุป ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderHistoryPage(),
                        ),
                      ),
                      child: Text(
                        "Order History >",
                        style: TextStyle(color: primaryColor2, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                
                // --- ตารางสรุป (มีเส้นคั่นกลาง) ---
                _buildSummaryTable(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget: การ์ดคำสั่งซื้อ ---
  Widget _buildOrderCard({
    required String title,
    required String statusText,
    required Color statusBg,
    required Color statusTextColor,
    required String tag,
    required Color tagBg,
    required Color tagText,
    bool isCompletedTab = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/coffee.png',
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
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // ป้ายสถานะ (มุมขวาบน)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 10,
                          color: statusTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 4),
                // ป้าย Tag ใต้ชื่อ
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: tagBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(fontSize: 10, color: tagText, fontWeight: FontWeight.bold),
                  ),
                ),
                
                const SizedBox(height: 15),

                // ราคาและปุ่มกด
                Row(
                  children: [
                    const Text(
                      "฿100",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    
                    // --- ปุ่มสำหรับแท็บ In Progress ---
                    if (!isCompletedTab)
                      SizedBox(
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetailsPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor2, // สีน้ำเงิน
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                          ),
                          child: const Text(
                            "Details",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      )
                    // --- ปุ่มสำหรับแท็บ Completed ---
                    else ...[
                      SizedBox(
                        height: 28,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetailsPage()));
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primaryColor2), // ขอบสีน้ำเงิน
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), // กรอบเหลี่ยม
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: Text(
                            "Details",
                            style: TextStyle(fontSize: 10, color: primaryColor2), // ตัวหนังสือสีน้ำเงิน
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () => _showReviewSheet(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor2, // สีน้ำเงิน
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), // กรอบเหลี่ยม
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: const Text(
                            "Review",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget: Tab ด้านบน ---
  Widget _buildTabItem(String label, int index) {
    bool isActive = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: isActive
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                : [],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

 // --- Widget: ตารางสรุปแบบไม่มีเส้นคั่นกลาง ---
  Widget _buildSummaryTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // --- หัวตาราง (Header) ---
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order", style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
                Text("Price", style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
              ],
            ),
          ),
          const Divider(height: 1),
          
          // --- รายการสินค้า ---
          const SizedBox(height: 4), // เว้นระยะนิดหน่อยให้ดูไม่ชิดเส้นเกินไป
          _buildSummaryItemRow("Coffee Name", "฿100"),
          _buildSummaryItemRow("Coffee Name", "฿100"),
          _buildSummaryItemRow("Coffee Name", "฿100"),
          const SizedBox(height: 4),
          
          const Divider(height: 1),
          
          // --- ยอดรวม (Total) ---
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Total", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("฿300", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget ย่อย: สำหรับสร้างแถวรายการสินค้าแต่ละชิ้น ---
  Widget _buildSummaryItemRow(String itemName, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(itemName, style: const TextStyle(fontSize: 12)),
          Text(price, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  }