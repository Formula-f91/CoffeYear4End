import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/home/discountPage.dart';
import 'package:coffee/home/addressPage.dart';
import 'package:coffee/home/paymentPage.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

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
          "Checkout",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. ส่วนเลือกที่อยู่ (Address) ---
            _buildMenuSelector(
              "Address",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectAddressPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // --- 2. รายละเอียดคำสั่งซื้อ (Order Details) ---
            const Text(
              "Order Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildOrderRow("Coffee Name", "฿100"),
            _buildOrderRow("Coffee Name", "฿100"),
            _buildOrderRow("Coffee Name", "฿100"),
            _buildOrderRow("Total", "฿300", isTotal: true),
            const Divider(height: 30),

            // --- 3. ส่วนลด (Discount) ---
            const Text(
              "Discount",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildMenuSelector(
              "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DiscountsPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // --- 4. ย้ายมาที่ bottomNavigationBar และใช้สีใหม่ ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Row(
          children: [
            const Text(
              "฿300",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D2A4D),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor2, // ใช้สีน้ำเงินใหม่
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // ปรับเป็นมน 12
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildMenuSelector(String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderRow(String label, String price, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D2A4D),
            ),
          ),
        ],
      ),
    );
  }
}
