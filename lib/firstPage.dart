import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/home/homePage.dart';
import 'package:coffee/cupping/coffee_event_screen.dart';
import 'package:coffee/notifications/notificationsPage.dart';
import 'package:coffee/profile/profilePage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CoffeeHomePage(),
    const CoffeeEventScreen(),
    const NotificationsPage(),
    const ProfilePage(),
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
          selectedItemColor: primaryColor2,
          unselectedItemColor: Colors.grey.shade400,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, size: 28), // หน้าหลัก
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.coffee_rounded, size: 28), // หน้า Cupping/Event
              label: 'Cupping',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_rounded, size: 28), // แจ้งเตือน
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded, size: 28), // โปรไฟล์
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
