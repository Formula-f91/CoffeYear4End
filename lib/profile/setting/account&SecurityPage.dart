import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/profile/setting/socialMedaiPage.dart';
import 'package:coffee/profile/setting/changePassword.dart';

class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- 1. ส่วนหัวหน้าจอ (AppBar) ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Account & Security",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // --- 2. ส่วนรูปโปรไฟล์และปุ่มแก้ไข ---
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70, // ขนาดใหญ่ตามรูปภาพ
                    backgroundImage: AssetImage(
                      'assets/images/profile.png',
                    ), // ใช้รูปกาแฟจาก assets ของคุณ
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      // Logic สำหรับการแก้ไขรูปภาพ
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Edit Photo",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- 3. รายการเมนูการตั้งค่า ---
            _buildSecurityItem(
              "Username",
              onTap: () {
                _showEditUsernameSheet(
                  context,
                ); // เรียกใช้ฟังก์ชันเปิด Bottom Sheet
              },
            ),
            _buildSecurityItem(
              "Gender",
              onTap: () {
                _showEditGenderSheet(context);
              },
            ),
            _buildSecurityItem(
              "Phone Number",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePhonePage(),
                  ),
                );
              },
            ),
            _buildSecurityItem(
              "Social Media",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SocialMediaPage(),
                  ),
                );
              },
            ),
            _buildSecurityItem(
              "Change Password",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePasswordPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget สำหรับแต่ละรายการเมนู
  Widget _buildSecurityItem(String title, {required VoidCallback onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }
}

void _showEditUsernameSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // เพื่อให้ Bottom Sheet ดันขึ้นตามคีย์บอร์ด
    backgroundColor:
        Colors.transparent, // ทำให้ขอบนอกโปร่งใสเพื่อใช้ความโค้งของเราเอง
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(
            context,
          ).viewInsets.bottom, // ดันขึ้นเมื่อคีย์บอร์ดมา
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            // ขีดสีเทาเล็กๆ ด้านบน (Handle)
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Edit Username",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 15),
                  // ช่องกรอกข้อมูล (TextField) ตามรูป
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFC07651)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // ปุ่ม Confirm สีน้ำตาลส้ม
                  ElevatedButton(
                    onPressed: () {
                      // Logic บันทึกชื่อใหม่
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor2,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _showEditGenderSheet(BuildContext context) {
  // กำหนดค่าเริ่มต้น (ควรดึงจากข้อมูลผู้ใช้จริง)
  String selectedGender = "Male";

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // เพื่อให้เห็นขอบมนที่เรากำหนดเอง
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // ให้ขนาดพอดีกับเนื้อหา
              children: [
                // แถบเส้นเทาด้านบน (Handle)
                Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // หัวข้อและปุ่มปิด
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Edit Gender",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 15),

                // ตัวเลือก Male
                _buildGenderOption(
                  label: "Male",
                  value: "Male",
                  groupValue: selectedGender,
                  onChanged: (val) {
                    setModalState(() => selectedGender = val!);
                  },
                ),
                const SizedBox(height: 12),

                // ตัวเลือก Female
                _buildGenderOption(
                  label: "Female",
                  value: "Female",
                  groupValue: selectedGender,
                  onChanged: (val) {
                    setModalState(() => selectedGender = val!);
                  },
                ),

                const SizedBox(height: 30),

                // ปุ่ม Confirm
                ElevatedButton(
                  onPressed: () {
                    // บันทึกข้อมูลที่นี่
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:primaryColor2,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildGenderOption({
  required String label,
  required String value,
  required String groupValue,
  required ValueChanged<String?> onChanged,
}) {
  bool isSelected = value == groupValue;
  return GestureDetector(
    onTap: () => onChanged(value),
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ), // ปรับ padding ให้สมดุล
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? secondaryColor2: Colors.grey.shade200,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        // เปลี่ยนจาก MainAxisAlignment.spaceBetween เป็น Start เพื่อให้ชิดซ้าย
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 1. ย้าย Radio มาไว้ข้างหน้า
          Radio<String>(
            value: value,
            groupValue: groupValue,
            activeColor: secondaryColor2, // สีน้ำตาลตามรูปที่คุณต้องการ
            onChanged: onChanged,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ), // ช่วยลดช่องว่างส่วนเกินรอบจุด Radio
          ),
          const SizedBox(width: 8), // เพิ่มระยะห่างระหว่างจุดกับข้อความ
          // 2. ข้อความ Male/Female อยู่ต่อจากจุด
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}

class ChangePhonePage extends StatefulWidget {
  const ChangePhonePage({super.key});

  @override
  State<ChangePhonePage> createState() => _ChangePhonePageState();
}

class _ChangePhonePageState extends State<ChangePhonePage> {
  bool isOTPSent = false; // ตัวแปรสลับหน้า

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
        title: const Text(
          "Change Phone Number",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: isOTPSent ? _buildVerifyOTPStep() : _buildEnterPhoneStep(),
            ),
          ),
          // ปุ่ม Next ด้านล่างสุด
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            child: ElevatedButton(
              onPressed: () {
                setState(
                  () => isOTPSent = true,
                ); // เมื่อกด Next จะสลับไปหน้า OTP
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildEnterPhoneStep() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Enter phone number",
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
      const SizedBox(height: 10),
      TextField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFC07651)),
          ),
        ),
      ),
    ],
  );
}

Widget _buildVerifyOTPStep() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Please enter the OTP sent to your phone",
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
      const SizedBox(height: 10),
      const Text(
        "+66 99 999 9999",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      // ช่องกรอก OTP 6 ช่อง
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) => _buildOTPBox()),
      ),
      const SizedBox(height: 30),
      // ปุ่ม Resend Code
      Center(
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            side: BorderSide(color: Colors.grey.shade200),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Resend Code",
            style: TextStyle(
              color: Color(0xFF1D2A4D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}

// Widget สำหรับช่องสี่เหลี่ยมแต่ละช่อง
Widget _buildOTPBox() {
  return SizedBox(
    width: 50,
    height: 60,
    child: TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFC07651)),
        ),
      ),
    ),
  );
}
