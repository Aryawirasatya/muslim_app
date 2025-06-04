// lib/views/nav_wrapper.dart

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// Import seluruh screen yang sudah ada:
import 'home_screen.dart';
import 'jadwal_shalat_screen.dart';
import 'list_surah_screen.dart';
import 'list_doa_screen.dart';
import 'tentang_aplikasi_screen.dart';

class NavWrapper extends StatefulWidget {
  const NavWrapper({super.key});

  @override
  State<NavWrapper> createState() => _NavWrapperState();
}

class _NavWrapperState extends State<NavWrapper> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    // Tab awal: index 0 (HomeScreen)
    _controller = PersistentTabController(initialIndex: 0);
  }

  /// Daftar widget yang muncul di setiap tab
  List<Widget> _buildScreens() {
    return const [
      HomeScreen(),          // Tab 0 → HomeScreen grid (tetap sama)
      JadwalShalatScreen(),  // Tab 1 → Jadwal Shalat
      ListSurahScreen(),     // Tab 2 → Al-Qur'an
      ListDoaScreen(),       // Tab 3 → Doa Harian
      TentangAplikasiScreen()// Tab 4 → Tentang Aplikasi
    ];
  }

  /// Daftar item navigation bar (ikon + judul + warna)
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.access_time),
        title: ("Shalat"),
        activeColorPrimary: const Color(0xFF4CAF50),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.menu_book),
        title: ("Qur'an"),
        activeColorPrimary: const Color(0xFF2196F3),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.volunteer_activism),
        title: ("Doa"),
        activeColorPrimary: const Color(0xFFFFC107),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.info_outline),
        title: ("Tentang"),
        activeColorPrimary: const Color(0xFF9C27B0),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: kBottomNavigationBarHeight,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.zero,
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // bisa diganti style lain
    );
  }
}
