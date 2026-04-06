// lib/profile/profilePage.dart
import 'package:coffee/constants.dart';
import 'package:coffee/login/loginPage.dart';
import 'package:coffee/profile/edit_profile_page.dart';
import 'package:coffee/profile/userGuidePage.dart';
import 'package:coffee/profile/faqPage.dart';
import 'package:coffee/profile/aboutUsPage.dart';
import 'package:coffee/profile/termsOfServicePage.dart';
import 'package:coffee/profile/setting/settingPage.dart';
import 'package:coffee/profile/cupping/recentCuppingPage.dart';
import 'package:coffee/profile/order/orderStatusPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const _HeaderSection(),
              const SizedBox(height: 24),
              _buildMenuSection(context),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final menuItems = [
      // _MenuItem(
      //   icon: Icons.coffee_outlined,
      //   title: "Recent Cuppings",
      //   onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => const RecentCuppingsPage()),
      //   ),
      // ),
      // _MenuItem(
      //   icon: Icons.shopping_bag_outlined,
      //   title: "My Orders",
      //   onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => const OrderStatusPage()),
      //   ),
      // ),
      _MenuItem(
        icon: Icons.menu_book_outlined,
        title: "User Guide",
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UserGuidePage()),
        ),
      ),
      _MenuItem(
        icon: Icons.help_outline_rounded,
        title: "FAQs",
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FaqsPage()),
        ),
      ),
      // _MenuItem(
      //   icon: Icons.info_outline_rounded,
      //   title: "About Us",
      //   onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => const AboutUsPage()),
      //   ),
      // ),
      _MenuItem(
        icon: Icons.description_outlined,
        title: "Terms of Service",
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TermsOfServicePage()),
        ),
      ),
      _MenuItem(
        icon: Icons.settings_outlined,
        title: "Settings",
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AccountSettingsPage()),
        ),
      ),
      _MenuItem(
        icon: Icons.logout_rounded,
        title: "Logout",
        color: Colors.red,
        onTap: () => _showLogoutDialog(context),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          final isLast = i == menuItems.length - 1;
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 2,
                ),
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: (item.color ?? secondaryColor2).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    size: 18,
                    color: item.color ?? secondaryColor2,
                  ),
                ),
                title: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 15,
                    color: item.color ?? Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: item.color?.withOpacity(0.5) ?? Colors.grey.shade400,
                ),
                onTap: item.onTap,
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey.shade100,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// ── Header Section (StatefulWidget เพื่อ refresh หลัง edit) ───────────────────
class _HeaderSection extends StatefulWidget {
  const _HeaderSection();

  @override
  State<_HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<_HeaderSection> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _refreshUser();
  }

  Future<void> _refreshUser() async {
    await FirebaseAuth.instance.currentUser?.reload();
    if (mounted) {
      setState(() => _user = FirebaseAuth.instance.currentUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = (_user?.displayName?.isNotEmpty == true)
        ? _user!.displayName!
        : _user?.email?.split('@').first ?? 'Cupper';
    final email = _user?.email ?? '';
    final photoURL = _user?.photoURL;

    return Column(
      children: [
        // ── Avatar ──────────────────────────────────────────────────────────
        Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: secondaryColor2, width: 2.5),
              ),
              child: ClipOval(
                child: photoURL != null
                    ? Image.network(
                        photoURL,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _defaultAvatar(),
                      )
                    : Image.asset(
                        'assets/photo/coffepro.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _defaultAvatar(),
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: secondaryColor2,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.edit, size: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // ── ชื่อ ─────────────────────────────────────────────────────────────
        Text(
          displayName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 4),

        // ── Email ────────────────────────────────────────────────────────────
        if (email.isNotEmpty)
          Text(
            email,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        const SizedBox(height: 8),

        // ── Role badge ───────────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
            color: secondaryColor2.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: secondaryColor2.withOpacity(0.3)),
          ),
          child: Text(
            "Consumer",
            style: TextStyle(
              color: secondaryColor2,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ── แก้ไขโปรไฟล์ ─────────────────────────────────────────────────────
        GestureDetector(
          onTap: () async {
            final updated = await Navigator.push<bool>(
              context,
              MaterialPageRoute(builder: (_) => const EditProfilePage()),
            );
            if (updated == true) _refreshUser(); // refresh ถ้าแก้ไขสำเร็จ
          },
          child: Text(
            "แก้ไขโปรไฟล์",
            style: TextStyle(
              color: secondaryColor2,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: secondaryColor2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _defaultAvatar() => Container(
    color: secondaryColor2.withOpacity(0.12),
    child: Icon(
      Icons.person,
      size: 50,
      color: secondaryColor2.withOpacity(0.5),
    ),
  );
}

// ── Logout Dialog ──────────────────────────────────────────────────────────────
void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 0.5),
              ),
              child: const Icon(Icons.logout, color: Colors.red, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              "Logout",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Are you sure you want to logout?",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(ctx);
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                          (route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Logout"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// ── Menu item model ────────────────────────────────────────────────────────────
class _MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });
}
