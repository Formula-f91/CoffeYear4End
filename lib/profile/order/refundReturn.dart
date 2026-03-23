import 'package:flutter/material.dart';
import 'package:coffee/profile/order/refundDetailPage.dart';
import 'package:coffee/constants.dart'; // เรียกใช้ primaryColor2

class RefundReturnFlow extends StatefulWidget {
  const RefundReturnFlow({super.key});

  @override
  State<RefundReturnFlow> createState() => _RefundReturnFlowState();
}

class _RefundReturnFlowState extends State<RefundReturnFlow> {
  // ควบคุมว่าจะโชว์หน้าไหน: 0 = หน้ารายละเอียด, 1 = หน้ากรอกธนาคาร
  int _currentPage = 0;
  String? _selectedBank = 'Krungthai Bank';

  void _togglePage() {
    setState(() {
      _currentPage = _currentPage == 0 ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
          onPressed: () {
            if (_currentPage == 1) {
              _togglePage();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Refund/Return',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: _currentPage == 0 ? _buildDetailsView() : _buildBankInfoView(),
      
      // --- ย้ายปุ่มมาไว้ใน Bottom Navigation Bar ---
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade200)), // เส้นคั่นบางๆ ด้านบน
          ),
          child: ElevatedButton(
            onPressed: () {
              if (_currentPage == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RefundDetailsPage(),
                  ),
                );
              } else {
                _togglePage(); // คำสั่งปุ่ม Submit 
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor2, // ใช้สีน้ำเงินหลัก
              minimumSize: const Size(double.infinity, 50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // ปุ่มขอบเหลี่ยม
              ),
              elevation: 0,
            ),
            child: Text(
              _currentPage == 0 ? "Send request" : "Submit",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- VIEW 1: หน้ารายละเอียดสินค้า ---
  Widget _buildDetailsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductCard(),
          const SizedBox(height: 24),
          const Text("Total amount refunded", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 4),
          const Text("฿ 100", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
          const Divider(height: 32),
          
          // ส่วนที่กดแล้วจะสลับไปหน้าธนาคาร
          InkWell(
            onTap: _togglePage,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Text("Return to", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const Spacer(),
                  Image.asset('assets/icons/krungthai.png', width: 22, height: 22, errorBuilder: (c,e,s) => const Icon(Icons.account_balance, size: 20)),
                  const SizedBox(width: 8),
                  const Text("123456xxxx", style: TextStyle(fontSize: 14)),
                  const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                ],
              ),
            ),
          ),
          const Divider(height: 32),
          
          const Text("Note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          _buildTextField("Add a note...", maxLines: 3),
          const SizedBox(height: 24),
          
          const Text("Upload evidence", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          const Text("Upload clear photos or videos with sufficient lighting, showing the product together with its original packaging and labels (if any).", style: TextStyle(fontSize: 12, color: Color(0xFF606060))),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSquareImage('assets/images/coffee2.png'),
              const SizedBox(width: 12),
              _buildAddImageButton(),
            ],
          ),
          const SizedBox(height: 8),
          const Text("Please avoid capturing faces or sensitive information.", style: TextStyle(fontSize: 12, color: Color(0xFF606060))),
          const SizedBox(height: 20), // ลบปุ่มเดิมออกจากตรงนี้
        ],
      ),
    );
  }

  // --- VIEW 2: หน้ากรอกบัญชีธนาคาร ---
  Widget _buildBankInfoView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Total amount refunded", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          const Text("฿ 100", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
          const Divider(height: 32),
          const Text("Choose Refund Method Banking", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          _buildBankDropdown(),
          const SizedBox(height: 24),
          const Text("Please fill in the following information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const Divider(height: 24),
          const Text("Bank Account Number", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          const SizedBox(height: 10),
          _buildTextField("Please enter your bank account number"),
          const SizedBox(height: 20),
          const Text("Full Name as per Bank Account", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          const SizedBox(height: 10),
          _buildTextField("Please enter your first and last name"),
          const SizedBox(height: 20), // ลบปุ่มเดิมออกจากตรงนี้
        ],
      ),
    );
  }

  // --- Reusable Widgets ---

  Widget _buildProductCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.zero, // การ์ดขอบเหลี่ยม
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRect( // รูปภาพขอบเหลี่ยม
                child: Image.asset('assets/images/coffee2.png', width: 70, height: 70, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Coffee Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(height: 8),
                    Text("฿ 100", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          _buildInfoRow("Order Time", "28 Jul 2026 11:09"),
          _buildInfoRow("Payment Time", "28 Jul 2026 13:00"),
          _buildInfoRow("Payment Method", "xxxxxxx"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
          borderSide: BorderSide(color: Colors.grey.shade300)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
          borderSide: BorderSide(color: Colors.grey.shade300)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
          borderSide: BorderSide(color: primaryColor2) // สีขอบเปลี่ยนเป็นสีน้ำเงินเมื่อกดพิมพ์
        ),
      ),
    );
  }

  Widget _buildBankDropdown() {
    final List<Map<String, String>> banks = [
      {'name': 'Krungthai Bank', 'icon': 'assets/icons/krungthai.png'},
      {'name': 'Krungsri Bank', 'icon': 'assets/icons/krungsri.png'},
      {'name': 'Kasikorn Bank', 'icon': 'assets/icons/kasikron.png'},
      {'name': 'SCB Bank', 'icon': 'assets/icons/scb.png'},
      {'name': 'Bangkok Bank', 'icon': 'assets/icons/bangkok.png'},
    ];

    return DropdownButtonFormField<String>(
      value: _selectedBank,
      isExpanded: true, 
      icon: const Icon(Icons.keyboard_arrow_down),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
          borderSide: BorderSide(color: primaryColor2),
        ),
      ),
      items: banks.map((bank) {
        return DropdownMenuItem<String>(
          value: bank['name'],
          child: Row(
            children: [
              ClipRect( // รูปธนาคารในตัวเลือกขอบเหลี่ยม
                child: Image.asset(
                  bank['icon']!,
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) => 
                      const Icon(Icons.account_balance, size: 24, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                bank['name']!,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _selectedBank = val;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return banks.map<Widget>((bank) {
          return Row(
            children: [
              Image.asset(
                bank['icon']!,
                width: 24,
                height: 24,
                errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 24),
              ),
              const SizedBox(width: 12),
              Text(bank['name']!),
            ],
          );
        }).toList();
      },
    );
  }

  Widget _buildSquareImage(String path) {
    return ClipRect( // รูปหลักฐานขอบเหลี่ยม
      child: Image.asset(path, width: 80, height: 80, fit: BoxFit.cover),
    );
  }

  Widget _buildAddImageButton() {
    return Container(
      width: 80, height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.zero, // กล่องเพิ่มรูปภาพขอบเหลี่ยม
      ),
      child: Icon(Icons.camera_alt_outlined, color: Colors.grey[400], size: 30),
    );
  }
}