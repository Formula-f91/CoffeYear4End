import 'package:coffee/login/registerCategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';

class MailOtpVerificationPage extends StatelessWidget {
  const MailOtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Email',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please enter the OTP sent to',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Mail@gmail.com',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) => _buildOtpBox(context)),
                ),
                const SizedBox(height: 24),
                Center(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
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
        ),
      ),
      bottomNavigationBar: _buildBottomButton(context, 'Next', () {
        // TODO: navigate to next page
      }),
    );
  }

  Widget _buildBottomButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectRolePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
              ),
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
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
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 4),
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