import 'package:flutter/material.dart';
import 'package:coffee/distributor_firstPage.dart';
import 'package:coffee/constants.dart'; // ดึงค่า primaryColor2 มาใช้

// -------------------------------------------------------------------------
// 1. หน้ากรอกเบอร์โทรศัพท์
// -------------------------------------------------------------------------
class DistributorPhoneInputPage extends StatelessWidget {
  const DistributorPhoneInputPage({super.key});

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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
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
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor2, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(context, 'Next', () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OtpVerificationPage()),
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
                backgroundColor: primaryColor2,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DistributorProfilePagelogin()),
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
                backgroundColor: primaryColor2,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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

// -------------------------------------------------------------------------
// 3. หน้า Distributor Profile
// -------------------------------------------------------------------------
class DistributorProfilePagelogin extends StatefulWidget {
  const DistributorProfilePagelogin({super.key});

  @override
  State<DistributorProfilePagelogin> createState() => _DistributorProfilePageState();
}

class _DistributorProfilePageState extends State<DistributorProfilePagelogin> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _aboutController.dispose();
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
        title: const Text(
          "Distributor Profile",
          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField("Supplier / Company Name"),
                _buildDropdownField("Country"),
                _buildInputField(
                  "Address Details",
                  isMultiLine: true,
                  maxLength: 200,
                  controller: _addressController,
                ),
                const Text(
                  "Company Logo",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                _buildLogoUploadSection(),
                const SizedBox(height: 20),
                _buildInputField("Website"),
                _buildInputField("Contact Number"),
                _buildInputField("Email"),
                _buildInputField("Line"),
                _buildInputField(
                  "About / Description",
                  isMultiLine: true,
                  maxLength: 500,
                  controller: _aboutController,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(context, 'Confirm', () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DistributorFirstPage()),
        );
      }),
    );
  }

  Widget _buildBottomButton(BuildContext context, String text, VoidCallback onPressed) {
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
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor2,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), // ขอบ 0
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

  Widget _buildInputField(String label, {bool isMultiLine = false, String? hint, int? maxLength, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Stack(
          children: [
            TextField(
              controller: controller,
              maxLength: maxLength,
              maxLines: isMultiLine ? 4 : 1,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade400),
                counterText: "",
                contentPadding: const EdgeInsets.fromLTRB(15, 15, 60, 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: primaryColor2, width: 2),
                ),
              ),
            ),
            if (maxLength != null && controller != null)
              Positioned(
                right: 10,
                bottom: 10,
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller,
                  builder: (context, value, child) {
                    return Text("${value.text.length}/$maxLength", style: TextStyle(fontSize: 11, color: Colors.grey.shade500));
                  },
                ),
              ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildDropdownField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: primaryColor2, width: 2),
              ),
            ),
            items: const [],
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildLogoUploadSection() {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10)),
          child: Icon(Icons.image_outlined, size: 50, color: Colors.grey.shade300),
        ),
      ),
    );
  }
}