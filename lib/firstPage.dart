import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/home/homePage.dart';
import 'package:coffee/cupping/coffee_event_screen.dart';
import 'package:coffee/cupping/createcupping/add_cupping_session_screen.dart'
    hide secondaryColor2;
import 'package:coffee/model/session_model.dart';
import 'package:coffee/notifications/notificationsPage.dart';
import 'package:coffee/profile/profilePage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;

  // ── Sessions อยู่ที่นี่ — ส่งลงทั้ง Home tab และ CoffeeEvent tab ──────────
  final List<SessionModel> _sessions = [];

  // ── Session callbacks ─────────────────────────────────────────────────────
  void _addSession(SessionModel s) =>
      setState(() => _sessions.add(s));

  void _updateSession(int index, SessionModel updated) =>
      setState(() => _sessions[index] = updated);

  void _removeSession(int index) =>
      setState(() => _sessions.removeAt(index));

  // ── เปิด AddCoffeeInfoPage จาก Home → Quick Action "New Session" ──────────
  Future<void> _openNewSession() async {
    final result = await Navigator.push<SessionModel>(
      context,
      MaterialPageRoute(builder: (_) => const AddCoffeeInfoPage()),
    );
    if (result != null) _addSession(result);
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // สร้าง pages ใน build เพื่อให้รับ _sessions ที่อัพเดตแล้วทุกครั้ง
    final pages = [
      // Tab 0 — Home
      CoffeeHomePageNew(
        sessions: _sessions,
        onNewSession: _openNewSession,
      ),
      // Tab 1 — CoffeeEvent
      CoffeeEventScreen(
        sessions: _sessions,
        onAdd: _addSession,
        onUpdate: _updateSession,
        onRemove: _removeSession,
      ),
      // Tab 2 — Profile
      const ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
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