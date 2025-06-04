import 'package:flutter/material.dart';
import 'package:flutter_application_1/viewmodel/jadwal_shalat_viewmodel.dart';
import 'package:provider/provider.dart';
import 'detail_jadwal_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class JadwalShalatScreen extends StatefulWidget {
  const JadwalShalatScreen({super.key});

  @override
  State<JadwalShalatScreen> createState() => _JadwalShalatScreenState();
}

class _JadwalShalatScreenState extends State<JadwalShalatScreen> {
  final Map<int, String> lokasiList = {
    1206: "Kab. Cianjur",
    1301: "Kab. Bandung",
    1303: "Kab. Bogor",
    3273: "Kab. Bandung Barat",
    1202: "Kota Bandung",
    1201: "Kota Bandung",
    1203: "Kab. Bekasi",
    1204: "Kota Bogor",
    1205: "Kota Ciamis",
    1207: "Kota Cirebon",
    1208: "Kota Garut",
    1209: "Kota Indramayu",
    1210: "Kota Majalengka",
    1211: "Kota Pangandaran",
    1212: "Kota Purwakarta",
    1213: "Kota Subang",
    1214: "Kota Sukabumi",
    1215: "Kota Sumedang",
    1225: "Kota Depok",
  };

  int selectedLokasiId = 1206;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final viewModel = Provider.of<JadwalShalatViewModel>(context, listen: false);
    viewModel.getJadwalShalat(
      lokasiId: selectedLokasiId,
      tahun: now.year,
      bulan: now.month,
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JadwalShalatViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Jadwal Shalat"),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Column(
        children: [
          // Dropdown Lokasi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: DropdownButtonFormField<int>(
              value: selectedLokasiId,
              decoration: InputDecoration(
                labelText: "Pilih Lokasi",
                labelStyle: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.w600),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal.shade700, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              dropdownColor: Colors.white,
              iconEnabledColor: Colors.teal.shade700,
              onChanged: (int? newId) {
                if (newId != null) {
                  setState(() {
                    selectedLokasiId = newId;
                  });
                  final now = DateTime.now();
                  viewModel.getJadwalShalat(
                    lokasiId: selectedLokasiId,
                    tahun: now.year,
                    bulan: now.month,
                  );
                }
              },
              items: lokasiList.entries.map((entry) {
                return DropdownMenuItem<int>(
                  value: entry.key,
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),

          // Konten Jadwal
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => viewModel.refreshJadwal(lokasiId: selectedLokasiId),
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.errorMessage.isNotEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  viewModel.errorMessage,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: () => viewModel.refreshJadwal(lokasiId: selectedLokasiId),
                                  icon: const Icon(Icons.refresh),
                                  label: const Text("Coba Lagi"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal.shade700,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          itemCount: viewModel.jadwalShalat?.data?.jadwal?.length ?? 0,
                          separatorBuilder: (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final jadwal = viewModel.jadwalShalat!.data!.jadwal![index];
                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                title: Text(
                                  jadwal.tanggal ?? "Tidak diketahui",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    "Subuh: ${jadwal.subuh}, Maghrib: ${jadwal.maghrib}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                                trailing: const Icon(Icons.chevron_right, color: Colors.teal),
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: DetailJadwalScreen(jadwal: jadwal),
                                    withNavBar: true,
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
