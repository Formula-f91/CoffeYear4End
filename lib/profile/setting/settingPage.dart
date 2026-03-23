import 'package:coffee/login/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:coffee/profile/setting/account&SecurityPage.dart';
import 'package:coffee/profile/setting/changeLanguagePage.dart';
import 'package:coffee/home/addressPage.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- 1. AppBar พร้อมปุ่มย้อนกลับ ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Account Settings",
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- 2. รายการเมนูการตั้งค่า ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                _buildSettingItem(
                  "Account & Security",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountSecurityPage()));
                  },
                ),
                _buildSettingItem(
                  "Change Language",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeLanguagePage()));
                  },
                ),
                _buildSettingItem(
                  "Shipping Address",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectAddressPage()));
                  },
                ),
              ],
            ),
          ),

          // --- 3. ปุ่มออกจากระบบด้านล่าง ---
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 40),
            child: OutlinedButton(
              onPressed: () {
                // Logic สำหรับออกจากระบบ
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: BorderSide(color: Colors.grey.shade200),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget สำหรับแต่ละรายการเมนู (ListTile สไตล์มินิมอล)
  Widget _buildSettingItem(String title, {required VoidCallback onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
