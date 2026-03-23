import 'package:coffee/login/add_basic_user.dart';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart'; // ดึงค่า primaryColor2 มาใช้

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.06),
                  
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please enter your username and password\nto log in.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: size.height * 0.04),

                  // --- Username ---
                  const Text(
                    'Username',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      // เปลี่ยนขอบตอน Focus เป็นสีน้ำเงิน
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryColor2, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Password ---
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      // เปลี่ยนขอบตอน Focus เป็นสีน้ำเงิน
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryColor2, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () => setState(() => _isObscure = !_isObscure),
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  // ลิงก์ลืมรหัสผ่าน (เปลี่ยนเป็นสีน้ำเงิน)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(color: primaryColor2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // --- ปุ่ม Login ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UserPage2()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor2, // สีน้ำเงิน
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                 const SizedBox(height: 20), // ระยะห่างระหว่างสองปุ่ม

                  // --- ปุ่ม Register (แบบเต็มปุ่ม) ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UserPage2()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: primaryColor2, width: 1.5), // เส้นขอบสีน้ำเงิน
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18, 
                          color: primaryColor2, // ตัวหนังสือสีน้ำเงิน
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('or', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: size.height * 0.035),

                  _buildSocialButton('Continue with Google', 'assets/icons/google.png'),
                  const SizedBox(height: 16),
                  _buildSocialButton('Continue with LINE', 'assets/icons/LINE.png', iconSize: 24),
                  const SizedBox(height: 16),
                  _buildSocialButton('Continue with Facebook', 'assets/icons/facebook.png'),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, String assetPath, {double iconSize = 18}) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        side: BorderSide(color: Colors.grey.shade200),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, width: iconSize, height: iconSize, fit: BoxFit.contain),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}