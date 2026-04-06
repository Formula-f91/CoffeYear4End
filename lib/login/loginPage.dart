import 'package:coffee/firstPage.dart';
import 'package:coffee/login/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController(); // ใช้เป็น email
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    final email = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกอีเมลและรหัสผ่านให้ครบถ้วน')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      final cuppingProvider = Provider.of<CuppingProvider>(
        context,
        listen: false,
      );
      cuppingProvider.setUserRole(UserRole.consumer);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstPage()),
      );
    } on FirebaseAuthException catch (e) {
      String msg = 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ';
      if (e.code == 'user-not-found') msg = 'ไม่พบบัญชีผู้ใช้นี้';
      if (e.code == 'wrong-password') msg = 'รหัสผ่านไม่ถูกต้อง';
      if (e.code == 'invalid-credential') msg = 'อีเมลหรือรหัสผ่านไม่ถูกต้อง';
      if (e.code == 'invalid-email') msg = 'รูปแบบอีเมลไม่ถูกต้อง';

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final double bannerHeight = size.height * 0.45;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // ── Main Content ───────────────────────────────────────────────
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // ── Banner Image ──────────────────────────────────────
                      SizedBox(
                        height: bannerHeight,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/cupping.jpg',
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),

                      // ── Logo ──────────────────────────────────────────────
                      Positioned(
                        top: padding.top + 16,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            'assets/icon/cuplogoapp.png',
                            height: 110,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // ── Form Card ─────────────────────────────────────────
                      Container(
                        margin: EdgeInsets.only(
                          top: bannerHeight - 200,
                          left: 24,
                          right: 24,
                          bottom: 30,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 36,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 30,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Please enter your email and password to log in.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 28),

                            // ── Email ────────────────────────────────────────
                            const Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(
                                    color: secondaryColor2,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // ── Password ─────────────────────────────────────
                            const Text(
                              'Password',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _passwordController,
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(
                                    color: secondaryColor2,
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () => setState(
                                    () => _isObscure = !_isObscure,
                                  ),
                                ),
                              ),
                            ),

                            // ── Forgot Password ───────────────────────────────
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: _sendPasswordReset,
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                    color: secondaryColor2,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // ── Login Button ──────────────────────────────────
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor2,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // ── Register Button ───────────────────────────────
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage(),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: secondaryColor2,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: secondaryColor2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // ── Loading Overlay ────────────────────────────────────────────
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: CircularProgressIndicator(color: secondaryColor2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ── Forgot Password ────────────────────────────────────────────────────────
  Future<void> _sendPasswordReset() async {
    final email = _usernameController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกอีเมลก่อนกด Forgot Password')),
      );
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ส่งลิงก์รีเซ็ตรหัสผ่านไปที่อีเมลแล้ว'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'เกิดข้อผิดพลาด'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}