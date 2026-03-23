import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedFile = File(image.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

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
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- 1. ส่วน QR Code ---
            _buildSectionCard(
              child: Column(
                children: [
                  const Text(
                    "Total Amount: 300 THB",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 15),
                  Image.asset(
                    'assets/images/qr_payment.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.qr_code_2,
                      size: 200,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Download QR",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- 2. ส่วนข้อมูลบัญชีธนาคาร ---
            _buildSectionCard(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/icons/kbank_logo.png',
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.account_balance, size: 50),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kasikornbank",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Account Name",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text("00000000000000", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFF1D2A4D),
                        width: 0.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      "Copy",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- 3. ส่วนอัปโหลดหลักฐานการโอน ---
            _buildUploadSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // --- 4. ปุ่ม Confirm Payment (ย้ายมาที่ bottomNavigationBar) ---
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 35),
        child: ElevatedButton(
          onPressed: _selectedFile == null
              ? null
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Payment...')),
                  );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor2, // ใช้สีน้ำเงินใหม่
            disabledBackgroundColor: Colors.grey.shade300,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), // ปรับเป็นมน 12
            ),
            elevation: 0,
          ),
          child: const Text(
            "Confirm Payment",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: child,
    );
  }

  Widget _buildUploadSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _selectedFile != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _selectedFile!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(
                  Icons.cloud_upload_outlined,
                  size: 60,
                  color: Colors.grey,
                ),
          const SizedBox(height: 10),
          Text(
            _selectedFile != null ? "File Selected" : "Upload Transfer Receipt",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const Text(
            "Supports JPG, PNG files only",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 15),
          OutlinedButton(
            onPressed: _pickImage,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: _selectedFile != null
                    ? Colors.green
                    : Colors.grey.shade300,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              _selectedFile != null ? "Change File" : "Select File",
              style: TextStyle(
                color: _selectedFile != null ? Colors.green : Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
