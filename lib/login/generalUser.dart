import 'package:flutter/material.dart';
import 'package:coffee/firstPage.dart';
import 'package:coffee/constants.dart'; // ดึงค่า primaryColor2 มาใช้

class UserPhoneInputPage extends StatelessWidget {
  const UserPhoneInputPage({super.key});

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
        centerTitle: true,
        title: const Text(
          'Phone Number',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter phone number',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                // เปลี่ยนขอบตอน Focus เป็นสีน้ำเงิน
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: primaryColor2, 
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // ย้ายปุ่ม Next มาไว้ที่ bottomNavigationBar
      bottomNavigationBar: _buildBottomButton(context, 'Next', () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OtpVerificationPage(),
          ),
        );
      }),
    );
  }

  Widget _buildBottomButton(BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2, // สีน้ำเงิน
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // ปรับให้มนเข้ากับช่องกรอก
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// 2. หน้ากรอก OTP
// -------------------------------------------------------------------------
class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

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
        centerTitle: true,
        title: const Text(
          'Phone Number',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please enter the OTP sent to',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              '+66 99 999 9999',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 24),
            // ช่องกรอก OTP 6 ช่อง
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => _buildOtpBox(context)),
            ),
            const SizedBox(height: 24),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  // Logic สำหรับส่งรหัสใหม่
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Resend Code',
                  style: TextStyle(color: Color(0xFF5F657B), fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      // ย้ายปุ่ม Next มาไว้ที่ bottomNavigationBar
      bottomNavigationBar: _buildBottomButton(context, 'Next', () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const FirstPage())
        );
      }),
    );
  }

  Widget _buildBottomButton(BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2, // สีน้ำเงิน
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: "", 
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
            ),
            // สีน้ำเงินตอน Focus
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor2, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}