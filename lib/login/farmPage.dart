import 'package:coffee/constants.dart';
import 'package:coffee/farm/farm_first_page.dart';
import 'package:flutter/material.dart';

// -------------------------------------------------------------------------
// 1. หน้ากรอกเบอร์โทรศัพท์ (FarmPhoneInputPage)
// -------------------------------------------------------------------------
class FarmPhoneInputPage extends StatelessWidget {
  const FarmPhoneInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Phone Number',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter phone number', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFC07651),
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // --- เปลี่ยนมาใช้ bottomNavigationBar ---
      bottomNavigationBar: _buildBottomNavigationBar('Next', () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OtpVerificationPage()),
        );
      }),
    );
  }

  // สร้าง Widget กลางสำหรับปุ่มด้านล่าง
  Widget _buildBottomNavigationBar(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // เพิ่มขอบสีเทาด้านบน
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      // เพิ่ม padding 24
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor2,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// 2. หน้ากรอก OTP (OtpVerificationPage)
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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Phone Number',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please enter the OTP sent to your phone',
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
              children: List.generate(6, (index) => _buildOtpBox()),
            ),
            const SizedBox(height: 24),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  // Logic สำหรับส่งรหัสใหม่
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Resend Code',
                  style: TextStyle(color: Color(0xFF5F657B), fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      // --- เปลี่ยนมาใช้ bottomNavigationBar ---
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddRoasteryDetailsPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox() {
    return Container(
      width: 52,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(counterText: "", border: InputBorder.none),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// 3. หน้ากรอกรายละเอียด (AddRoasteryDetailsPage)
// -------------------------------------------------------------------------
class AddRoasteryDetailsPage extends StatefulWidget {
  const AddRoasteryDetailsPage({super.key});

  @override
  State<AddRoasteryDetailsPage> createState() => _AddRoasteryDetailsPageState();
}

class _AddRoasteryDetailsPageState extends State<AddRoasteryDetailsPage> {
  final TextEditingController _farmDetailsController = TextEditingController();

  @override
  void dispose() {
    _farmDetailsController.dispose();
    super.dispose();
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
        centerTitle: true,
        title: const Text(
          'Producer profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // นำ Expanded ออก และใช้ SingleChildScrollView เป็น Body โดยตรง
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Farm Name'),
            _buildTextField(hint: ''),
            const SizedBox(height: 16),

            _buildLabel('Farm Owner / Manager Name'),
            _buildTextField(hint: ''),
            const SizedBox(height: 16),

            _buildLabel('Country'),
            _buildDropdownField(''),
            const SizedBox(height: 16),

            _buildLabel('Coffee Varieties Grown'),
            _buildDropdownField(''),
            const SizedBox(height: 16),

            _buildLabel('Harvest Period'),
            _buildDropdownField(''),
            const SizedBox(height: 16),

            _buildLabel('Elevation (meters above sea level)'),
            _buildTextField(hint: ''),
            const SizedBox(height: 16),

            _buildLabel('Farm Details'),
            _buildTextField(
              hint: '',
              maxLines: 4,
              maxLength: 200,
              controller: _farmDetailsController,
            ),
            const SizedBox(height: 24),

            _buildLabel('Upload Farm Image'),
            _buildUploadBox(),
            const SizedBox(height: 20),

            _buildLabel('Upload Farm Standards'),
            _buildUploadBox(),
            const SizedBox(height: 24),

            _buildLabel('Contact Number'),
            _buildTextField(hint: ''),
            const SizedBox(height: 16),

            _buildLabel('Email'),
            _buildTextField(hint: ''),
            const SizedBox(height: 16),

            _buildLabel('Line'),
            _buildTextField(hint: ''),
            const SizedBox(height: 30),
          ],
        ),
      ),
      // --- เปลี่ยนมาใช้ bottomNavigationBar ---
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FarmFirstPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    ),
  );

  Widget _buildTextField({
    required String hint,
    int maxLines = 1,
    int? maxLength,
    TextEditingController? controller,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            TextField(
              controller: controller,
              maxLines: maxLines,
              maxLength: maxLength,
              onChanged: (text) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                counterText: "",
                contentPadding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(
                    color: Color(0xFFC07651),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            if (maxLength != null)
              Padding(
                padding: const EdgeInsets.only(right: 12, bottom: 8),
                child: Text(
                  "${controller?.text.length ?? 0}/$maxLength",
                  style: TextStyle(
                    color: (controller?.text.length ?? 0) >= maxLength
                        ? Colors.red
                        : const Color(0xFF5F657B),
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hint,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          ),
          isExpanded: true,
          icon: Image.asset('assets/icon/dropdownv3.png', width: 10, height: 6),
          items: const [],
          onChanged: (val) {},
        ),
      ),
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Image.asset(
          'assets/icon/imageiconv3.png',
          width: 118,
          height: 88,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
