import 'package:coffee/constants.dart';
import 'package:coffee/profile/order/orderStatusPage.dart';
import 'package:coffee/profile/subscriptionPage.dart';
import 'package:flutter/material.dart';
import 'package:coffee/profile/userGuidePage.dart';
import 'package:coffee/profile/faqPage.dart';
import 'package:coffee/profile/aboutUsPage.dart';
import 'package:coffee/profile/termsOfServicePage.dart';
import 'package:coffee/profile/setting/settingPage.dart';
import 'package:coffee/profile/cupping/recentCuppingPage.dart';

class DistributorProfilePage extends StatelessWidget {
  const DistributorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Username",
          style: TextStyle(
            color: Color(0xFF4A4A4A),
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/setting-2.png',
              color: Colors.black,
              width: 28,
              height: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountSettingsPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  // นำทางไปหน้า SubscriptionPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubscriptionPage(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/professional.png',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children: [
                  _buildMenuTile(
                    "Recent Cuppings",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecentCuppingsPage(),
                      ),
                    ),
                  ),
                  _buildMenuTile(
                    "My Orders",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderStatusPage(),
                      ),
                    ),
                  ),
                  _buildMenuTile(
                    "User Guide",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserGuidePage(),
                      ),
                    ),
                  ),
                  _buildMenuTile(
                    "FAQs",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FaqsPage()),
                    ),
                  ),
                  _buildMenuTile(
                    "About Us",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUsPage(),
                      ),
                    ),
                  ),
                  _buildMenuTile(
                    "Terms of Service",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsOfServicePage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(String title, {required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 5,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: primaryColor2, // ใช้สีน้ำเงินตามธีมใหม่
          ),
          onTap: onTap,
        ),
        const Divider(height: 1, indent: 25, endIndent: 25, thickness: 0.8),
      ],
    );
  }
}