import 'package:flutter/material.dart';
import 'package:coffee/profile/order/problemIdentification.dart';
import 'package:coffee/constants.dart'; // เรียกใช้ primaryColor2

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

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
              borderRadius: BorderRadius.vertical(top: Radius.circular(0)), // กรอบเหลี่ยม
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
                                  ? const Color(0xFFF2994A) // สีดาวเก็บไว้เหมือนเดิม
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
                            borderRadius: BorderRadius.circular(0), // กรอบเหลี่ยม
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0), // กรอบเหลี่ยม
                            borderSide: BorderSide(
                              color: primaryColor2, // ขอบสีน้ำเงินเมื่อกดพิมพ์
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
                          minimumSize: const Size(double.infinity, 50),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // ปุ่มเหลี่ยม
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 16,
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

  void _showProofBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(0)), // กรอบเหลี่ยม
          ),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Proof of Delivery',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRect( // เปลี่ยนเป็น ClipRect เพื่อให้รูปเป็นสี่เหลี่ยมขอบคม
                  child: InteractiveViewer(
                    child: Image.asset(
                      'assets/images/proofOfDelivery.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor2, // สีน้ำเงิน
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // ปุ่มเหลี่ยม
                    ),
                    elevation: 0,
                  ),
                  child: const Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
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
          "Details",
          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildOrderInfoCard(),
            const SizedBox(height: 20),
            _buildTrackingCard(context),
            const SizedBox(height: 100), 
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProblemIdentificationPage(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: primaryColor2), // ขอบสีน้ำเงิน
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero), // ปุ่มเหลี่ยม
                ),
                child: Text("Claim", style: TextStyle(color: primaryColor2, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showReviewSheet(context), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor2, // สีน้ำเงิน
                  minimumSize: const Size(double.infinity, 50),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero), // ปุ่มเหลี่ยม
                  elevation: 0,
                ),
                child: const Text("Review", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero, // การ์ดเหลี่ยม
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRect( // รูปภาพเหลี่ยม
                child: Image.asset('assets/images/coffee.png', width: 80, height: 80, fit: BoxFit.cover),
              ),
              const SizedBox(width: 15),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Coffee Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("฿100", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow("Order Time", "28 Jul 2026  11:09"),
          _buildInfoRow("Payment Time", "28 Jul 2026  13:00"),
          _buildInfoRow("Payment Method", "QR Payment"),
        ],
      ),
    );
  }

  Widget _buildTrackingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero, // การ์ดเหลี่ยม
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tracking Number", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
              Row(
                children: [
                  const Text("TH12345678910", style: TextStyle(color: Colors.black, fontSize: 12)),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      print("Copied!");
                    },
                    child: Text(
                      "Copy", 
                      style: TextStyle(
                        color: primaryColor2, // ตัวอักษรสีน้ำเงิน
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 30),
          _buildTimelineItem(context, "3 Aug 26\n12:34", "Review", "View Proof of Delivery", isFirst: true, assetPath: 'assets/icons/star.png'),
          _buildTimelineItem(context, "1 Aug 26\n09:34", "Shipped", "Your package is on its way", assetPath: 'assets/icons/delivery.png'),
          _buildTimelineItem(context, "1 Aug 26\n09:34", "Preparing", "Your order is being prepared for shipment", assetPath: 'assets/icons/box.png'),
          _buildTimelineItem(context, "31 Jul 26\n15:34", "Pending Payment", "Waiting for payment to be confirmed", isLast: true, assetPath: 'assets/icons/wallet.png'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, String time, String title, String sub, {bool isFirst = false, bool isLast = false, required String assetPath}) {
    bool isProofLink = sub == "View Proof of Delivery";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Text(time, textAlign: TextAlign.right, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
        ),
        const SizedBox(width: 15),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isFirst ? primaryColor2 : Colors.grey.shade300, // สีน้ำเงิน
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                assetPath,
                width: 35,
                height: 35,
                color: Colors.white,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.circle, color: Colors.white, size: 30),
              ),
            ),
            if (!isLast) Container(width: 2, height: 45, color: Colors.grey.shade200),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: isProofLink ? () => _showProofBottomSheet(context) : null,
                child: Text(
                  sub,
                  style: TextStyle(
                    color: isProofLink ? primaryColor2 : Colors.grey, // สีน้ำเงินสำหรับลิงก์
                    fontSize: 12,
                    decoration: isProofLink ? TextDecoration.underline : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}