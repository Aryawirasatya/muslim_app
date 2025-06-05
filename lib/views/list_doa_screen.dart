import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/viewmodel/doa_viewmodel.dart';
import 'detail_doa_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ListDoaScreen extends StatefulWidget {
  const ListDoaScreen({super.key});

  @override
  _ListDoaScreenState createState() => _ListDoaScreenState();
}

class _ListDoaScreenState extends State<ListDoaScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<DoaViewModel>(context, listen: false).getDoaList();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DoaViewModel>(context);

    // Tambahkan definisi warna agar konsisten dengan ListSurahScreen
    final backgroundColor = const Color(0xFFCEF0EF); // pastel teal
    final cardColor       = Colors.white;             // putih bersih
    final textPrimary     = const Color(0xFF1B1B1B);  // hitam lembut
    final textSecondary   = Colors.grey.shade700;     // abu lembut
    final iconColor       = Colors.black54;           // abu lembut

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Doa harian",
          style: TextStyle(
            color: Colors.white, // Teks AppBar tetap putih
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: viewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.teal),
              )
            : viewModel.errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      viewModel.errorMessage,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    itemCount: viewModel.doaList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final doa = viewModel.doaList[index];
                      return Card(
                        color: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        shadowColor: Colors.teal.withOpacity(0.3),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          title: Text(
                            doa.doa ?? "Tidak ada judul",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: textPrimary,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              doa.artinya ?? "Tidak ada arti",
                              style: TextStyle(
                                fontSize: 14,
                                color: textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: iconColor,
                          ),
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: DetailDoaScreen(doa: doa),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
