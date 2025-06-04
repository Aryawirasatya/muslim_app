import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/jadwal_shalat_screen.dart';
import 'package:flutter_application_1/views/list_doa_screen.dart';
import 'package:flutter_application_1/views/list_surah_screen.dart';
import 'package:flutter_application_1/views/tentang_aplikasi_screen.dart';
import 'package:flutter_application_1/views/dzikir_digital_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<_MenuItem> menuItems = const [
    _MenuItem(
      title: "Jadwal Shalat",
      icon: Icons.access_time,
      gradient: LinearGradient(
        colors: [Color(0xFF4CAF50), Color(0xFF80E27E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      page: JadwalShalatScreen(),
    ),
    _MenuItem(
      title: "Al-Qur'an",
      icon: Icons.menu_book,
      gradient: LinearGradient(
        colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      page: ListSurahScreen(),
    ),
    _MenuItem(
      title: "Doa Harian",
      icon: Icons.volunteer_activism,
      gradient: LinearGradient(
        colors: [Color(0xFFFFC107), Color(0xFFFFF59D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      page: ListDoaScreen(),
    ),
    _MenuItem(
      title: "Tentang Aplikasi",
      icon: Icons.info_outline,
      gradient: LinearGradient(
        colors: [Color(0xFF9C27B0), Color(0xFFE1BEE7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      page: TentangAplikasiScreen(),
    ),
  ];

  final String haditsRingkasan =
      "Sesungguhnya amal yang paling dicintai oleh Allah adalah yang paling terus-menerus meskipun sedikit.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Assalamu’alaikum,\n",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "Selamat Datang\n",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                        letterSpacing: 0.3,
                      ),
                    ),
                    TextSpan(
                      text: "Semoga harimu penuh berkah",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Hadits Card
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.teal.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hadits Pilihan",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.teal.shade900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        haditsRingkasan,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.teal.shade800.withOpacity(0.8),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Tombol Dzikir Digital
             SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.spa_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Buka Counter Dzikir",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    shadowColor: Colors.teal.shade300,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: DzikirDigitalScreen(),
                      withNavBar: true,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),


              // Grid Menu
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return _MenuCard(item: item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatefulWidget {
  final _MenuItem item;
  const _MenuCard({required this.item, super.key});

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.05,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _pressController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _pressController.reverse();
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: widget.item.page,
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  void _onTapCancel() {
    _pressController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        decoration: BoxDecoration(
          gradient: widget.item.gradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            splashColor: Colors.white30,
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.item.icon,
                  size: 52,
                  color: Colors.white,
                ),
                const SizedBox(height: 18),
                Text(
                  widget.item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final LinearGradient gradient;
  final Widget page;

  const _MenuItem({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.page,
  });
}
