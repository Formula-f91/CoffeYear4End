import 'package:coffee/login/username_page.dart';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    FocusScope.of(context).unfocus();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('รหัสผ่านและการยืนยันรหัสผ่านไม่ตรงกัน'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      // สมัครสำเร็จ → ไปหน้าตั้ง Username
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UsernamePage()),
      );
    } on FirebaseAuthException catch (e) {
      String msg = 'เกิดข้อผิดพลาดในการสมัครสมาชิก';
      if (e.code == 'email-already-in-use') msg = 'อีเมลนี้ถูกใช้งานแล้ว';
      if (e.code == 'weak-password') msg = 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
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

                      // ── Back Button ───────────────────────────────────────
                      Positioned(
                        top: padding.top + 10,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.35),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),

                      // ── Form Card ─────────────────────────────────────────
                      Container(
                        margin: EdgeInsets.only(
                          top: bannerHeight - 300,
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
                              'Create Account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Fill in your details to get started.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 28),

                            // ── Email ─────────────────────────────────────────
                            const Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: _inputDecoration('Enter your email'),
                            ),
                            const SizedBox(height: 20),

                            // ── Password ──────────────────────────────────────
                            const Text(
                              'Password',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _passwordController,
                              obscureText: _isObscure,
                              decoration: _inputDecoration(
                                'Enter your password',
                                suffix: IconButton(
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
                            const SizedBox(height: 20),

                            // ── Confirm Password ──────────────────────────────
                            const Text(
                              'Confirm Password',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _confirmPasswordController,
                              obscureText: _isObscureConfirm,
                              decoration: _inputDecoration(
                                'Confirm your password',
                                suffix: IconButton(
                                  icon: Icon(
                                    _isObscureConfirm
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () => setState(
                                    () =>
                                        _isObscureConfirm = !_isObscureConfirm,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),

                            // ── Register Button ───────────────────────────────
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed:
                                    _isLoading ? null : _handleRegister,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor2,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            Center(
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Already have an account? Login',
                                  style: TextStyle(
                                    color: secondaryColor2,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
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

  InputDecoration _inputDecoration(String hint, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(color: secondaryColor2, width: 2),
      ),
    );
  }
}