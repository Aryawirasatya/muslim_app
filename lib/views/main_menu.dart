import 'package:flutter/material.dart';
import 'jadwal_shalat_screen.dart';
import 'list_surah_screen.dart';
import 'list_doa_screen.dart';
import 'tentang_aplikasi_screen.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    JadwalShalatScreen(),
    ListSurahScreen(),
    ListDoaScreen(),
    TentangAplikasiScreen(),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Shalat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Al-Qur\'an',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Doa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }
}
