import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/distributor/distributor_homePage.dart';
import 'package:coffee/cupping/coffee_event_screen.dart';
import 'package:coffee/notifications/notificationsPage.dart';
import 'package:coffee/distributor/distributorProfilePage.dart';

class DistributorFirstPage extends StatefulWidget {
  const DistributorFirstPage({super.key});

  @override
  State<DistributorFirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<DistributorFirstPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const SellerHomePage(),
    const CoffeeEventScreen(), 
    const NotificationsPage(),
    const DistributorProfilePage(),
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
          showSelectedLabels: false, // ไม่แสดงตัวหนังสือเมื่อเลือก
          showUnselectedLabels: false, // ไม่แสดงตัวหนังสือเมื่อไม่ได้เลือก
          selectedItemColor: primaryColor2, // สีไอคอนเมื่อถูกเลือก
          unselectedItemColor: Colors.grey.shade400, // สีไอคอนเมื่อไม่ถูกเลือก
          items: const [
            BottomNavigationBarItem(
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
