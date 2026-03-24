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

  // ใช้ IndexedStack แทน _pages[_selectedIndex]
  // เพื่อให้ทุก tab ยังคง state ไว้เมื่อสลับ tab
  final List<Widget> _pages = const [
    CoffeeHomePageNew(),
    CoffeeEventScreen(),
    
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack render ทุก tab พร้อมกัน แต่แสดงแค่ tab ที่ selected
      // ทำให้ state ของแต่ละ tab ไม่ถูก dispose เมื่อสลับ tab
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
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
              icon: Icon(Icons.home_rounded, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.coffee_rounded, size: 28),
              label: 'Cupping',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notifications_rounded, size: 28),
            //   label: 'Notifications',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded, size: 28),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}