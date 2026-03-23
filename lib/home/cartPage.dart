import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/home/checkOutPage.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
          "My Cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // รายการสินค้าในตะกร้า
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildCartItem();
        },
      ),

      // --- ส่วนสรุปยอดและปุ่มสั่งซื้อ (ใช้สีใหม่ primaryColor2) ---
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
                      builder: (context) => const CheckoutPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor2, // ใช้สีน้ำเงินใหม่
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Order Now",
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

  Widget _buildCartItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          // Checkbox (ใช้สีน้ำเงินใหม่ secondaryColor2)
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: secondaryColor2, // สีน้ำเงินเข้มใหม่
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.check, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                  children: [
                    const Text(
                      "Coffee Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "฿100",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2A4D),
                      ),
                    ),
                    Row(
                      children: [
                        _buildQtyBtn(Icons.remove),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "2",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        _buildQtyBtn(Icons.add),
                      ],
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

  Widget _buildQtyBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 16, color: Colors.grey),
    );
  }
}
