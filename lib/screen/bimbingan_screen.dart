import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'viewBimbingan_screen.dart';
import 'detailBimbingan_screen.dart';

class BimbinganScreen extends StatefulWidget {
  const BimbinganScreen({super.key});

  @override
  State<BimbinganScreen> createState() => _BimbinganScreenState();
}

class _BimbinganScreenState extends State<BimbinganScreen> {
  int _selectedIndex = 2;
  String _selectedFilter = 'Semua Bimbingan';

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const InfoSidangScreen()));
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const ProfilScreen()));
        break;
    }
  }

  void onAddPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tombol Add ditekan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF149BF6);

    return Scaffold(
      // --- APPBAR ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        toolbarHeight: 53,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Suko Tyas",
              style: GoogleFonts.instrumentSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2A4B62),
              ),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            icon: const Icon(Icons.menu, size: 24, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),

      // --- BODY ---
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STATUS BIMBINGAN
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Status Bimbingan",
                        style: GoogleFonts.instrumentSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            "Cetak lembar persetujuan",
                            style: GoogleFonts.instrumentSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2A4B62),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.print, color: Color(0xFF2A4B62)),
                            onPressed: () {
                              debugPrint("Cetak dokumen");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Suko Tyas P",
                          style: GoogleFonts.instrumentSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: const LinearProgressIndicator(
                              value: 5 / 8,
                              minHeight: 13,
                              backgroundColor: Color(0xFFE0E0E0),
                              color: primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "5/8",
                          style: GoogleFonts.instrumentSans(
                            fontSize: 12,
                            color: Color(0xFF2A4B62),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // PEMBIMBINGAN SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pembimbingan",
                  style: GoogleFonts.instrumentSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final newData = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ViewBimbinganScreen()),
                    );

                    // Kalau ada data baru dikembalikan dari halaman form
                    if (newData != null && newData is Map<String, dynamic>) {
                      setState(() {
                        bimbinganList.add(newData);
                      });
                    }
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(
                    "Tambah",
                    style: GoogleFonts.instrumentSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // DROPDOWN FILTER
            DropdownButtonFormField<String>(
              value: _selectedFilter,
              items: const [
                DropdownMenuItem(
                  value: 'Semua Bimbingan',
                  child: Text('Semua Bimbingan'),
                ),
                DropdownMenuItem(value: 'Bab I', child: Text('Bimbingan Bab I')),
                DropdownMenuItem(value: 'Bab II', child: Text('Bimbingan Bab II')),
              ],
              onChanged: (val) {
                setState(() {
                  _selectedFilter = val!;
                });
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 LIST BIMBINGAN
            Expanded(
              child: ListView.builder(
                itemCount: bimbinganList.length,
                itemBuilder: (context, index) {
                  final item = bimbinganList[index];

                  // Tentukan ikon & warnanya berdasarkan status
                  IconData icon;
                  Color iconColor;
                  switch (item["status"]) {
                    case "verified":
                      icon = Icons.check_circle;
                      iconColor = Colors.green;
                      break;
                    case "editable":
                      icon = Icons.edit;
                      iconColor = Colors.orange;
                      break;
                    default:
                      icon = Icons.cancel;
                      iconColor = Colors.red;
                  }

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Text(
                        item["tanggal"],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.instrumentSans(fontSize: 12),
                      ),
                      title: Text(
                        item["namaDosen"],
                        style: GoogleFonts.instrumentSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        item["judul"],
                        style: GoogleFonts.instrumentSans(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(icon, color: iconColor),
                        onPressed: () {
                          if (item["status"] == "editable") {
                            // Jika editable → ke halaman ViewBimbingan
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ViewBimbinganScreen(),
                              ),
                            );
                          } else {
                            // Jika verified / rejected → tampilkan pop-up
                            showDialog(
                              context: context,
                              builder: (context) => DetailBimbinganDialog(data: item),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_alt), label: 'Info Sidang'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Bimbingan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// --- Dummy Screens ---
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Dashboard')));
}

class InfoSidangScreen extends StatelessWidget {
  const InfoSidangScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Info Sidang')));
}

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Profil')));
}

final List<Map<String, dynamic>> bimbinganList = [
  {
    "tanggal": "Senin,\n1 Maret 2025",
    "namaDosen": "Suko Tyas",
    "judul": "Revisi Bab I: Pendahuluan",
    "status": "editable", // artinya masih bisa diedit
  },
  {
    "tanggal": "Rabu,\n5 Maret 2025",
    "namaDosen": "Suko Tyas",
    "judul": "Bimbingan Bab II: Tinjauan Pustaka",
    "status": "verified", // artinya sudah diverifikasi
  },
  {
    "tanggal": "Jumat,\n7 Maret 2025",
    "namaDosen": "Suko Tyas",
    "judul": "Bimbingan Bab III: Metodologi",
    "status": "rejected", // artinya ditolak/diperbaiki
  },
];
