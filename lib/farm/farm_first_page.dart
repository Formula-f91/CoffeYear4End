import 'package:coffee/constants.dart';
import 'package:coffee/cupping/coffee_event_screen.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/farm_home_page.dart';
import 'package:coffee/farm/cuppingfarm/CoffeeEventListOnlyScreen.dart';
import 'package:coffee/profile/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:coffee/notifications/notificationsPage.dart';

class FarmFirstPage extends StatefulWidget {
  const FarmFirstPage({super.key});

  @override
  State<FarmFirstPage> createState() => _FarmFirstPageState();
}

class _FarmFirstPageState extends State<FarmFirstPage> {
  int _selectedIndex = 0;

  // รายการหน้าจอสำหรับโหมด Farm
  final List<Widget> _pages = [
    const FarmHomePage(),
    const CoffeeEventScreen(),
    // const CoffeeEventListOnlyScreen(), // ใช้หน้าเดิมจาก General User
    const NotificationsPage(),
    const ProfilePage() // ใช้หน้าเดิมจาก General User
    // const ProfilePageWithoutOrders(), // ใช้หน้าเดิมจาก General User
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: primaryColor2, // สีธีมเดิม
          unselectedItemColor: Colors.grey.shade400,
          items: const [
            BottomNavigationBarItem(
              // ถ้าหน้า Home ของฟาร์มใน Figma ใช้ไอคอนต่างออกไป ให้เปลี่ยนที่นี่
              icon: ImageIcon(AssetImage("assets/icons/Bag.png"), size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/Vector.png"), size: 25),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/Icon.png"), size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/user.png"), size: 28),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
