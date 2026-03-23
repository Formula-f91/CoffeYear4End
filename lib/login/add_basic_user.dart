import 'package:coffee/login/mail_otp.dart';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';

class UserPage2 extends StatefulWidget {
  const UserPage2({super.key});

  @override
  State<UserPage2> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage2> {
  String _gender = 'Female';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0, // เพิ่มบรรทัดนี้
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Basic User Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildProfileSection(),
            const SizedBox(height: 30),
            _buildLabel('Username'),
            _buildTextField(hint: 'Enter your username'),
            const SizedBox(height: 16),
             Row(
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const Spacer(),
                _buildGenderChip('Female'),
                const SizedBox(width: 12),
                _buildGenderChip('Male'),
              ],
            ),
            const SizedBox(height: 20),
           
            const SizedBox(height: 20),
            _buildLabel('Password'),
            _buildTextField(hint: 'Enter your password', isPassword: true),
            const SizedBox(height: 20),
            _buildLabel('Confirm Password'),
            _buildTextField(hint: 'Confirm your password', isPassword: true),
            const SizedBox(height: 40),
            _buildLabel('Phone Number'),
            _buildTextField(hint: 'Enter your phone number', keyboardType: TextInputType.phone),
            const SizedBox(height: 20),
            _buildLabel('Email'),
            _buildTextField(hint: 'Enter your email', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton('Confirm'),
    );
  }

  Widget _buildProfileSection() {
    return Center(
      child: Column(
        children: [
          const Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 1),
            ),
            child: Center(
              child: Image.asset(
                "assets/icons/Camera (1).png",
                width: 56,
                height: 56,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Upload Image',
              style: TextStyle(color: primaryColor2, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      );

  Widget _buildTextField({
    required String hint,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: primaryColor2, width: 2),
        ),
        suffixIcon: isPassword
            ? Icon(Icons.visibility_off_outlined, color: Colors.grey.shade300)
            : null,
      ),
    );
  }

  Widget _buildGenderChip(String value) {
    bool isSelected = _gender == value;
    return GestureDetector(
      onTap: () => setState(() => _gender = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor2.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? primaryColor2 : Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor2 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(String text) {
  return Container(
    color: Colors.white,
    child: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MailOtpVerificationPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              elevation: 0,
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
}