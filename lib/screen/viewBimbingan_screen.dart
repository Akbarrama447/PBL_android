import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewBimbinganScreen extends StatefulWidget {
  const ViewBimbinganScreen({super.key});

  @override
  State<ViewBimbinganScreen> createState() => _ViewBimbinganScreenState();
}

class _ViewBimbinganScreenState extends State<ViewBimbinganScreen> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  String? _selectedBab;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF149BF6);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Bimbingan',
          style: GoogleFonts.instrumentSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2A4B62),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Judul Bimbingan",
              style: GoogleFonts.instrumentSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                hintText: "Masukkan judul bimbingan",
                hintStyle: GoogleFonts.instrumentSans(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              "Bab yang dibimbing",
              style: GoogleFonts.instrumentSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _selectedBab,
              items: const [
                DropdownMenuItem(value: 'Bab I', child: Text('Bab I')),
                DropdownMenuItem(value: 'Bab II', child: Text('Bab II')),
                DropdownMenuItem(value: 'Bab III', child: Text('Bab III')),
                DropdownMenuItem(value: 'Bab IV', child: Text('Bab IV')),
                DropdownMenuItem(value: 'Bab V', child: Text('Bab V')),
              ],
              onChanged: (val) {
                setState(() {
                  _selectedBab = val;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              "Catatan Bimbingan",
              style: GoogleFonts.instrumentSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _catatanController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Tuliskan hasil atau catatan bimbingan",
                hintStyle: GoogleFonts.instrumentSans(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_judulController.text.isEmpty || _selectedBab == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Lengkapi semua data sebelum menyimpan")),
                    );
                    return;
                  }

                  final newItem = {
                    "tanggal": "Hari ini",
                    "namaDosen": "Suko Tyas",
                    "judul": "${_selectedBab!}: ${_judulController.text}",
                    "status": "editable",
                  };

                  Navigator.pop(context, newItem);
                },

                icon: const Icon(Icons.save),
                label: Text(
                  "Simpan",
                  style: GoogleFonts.instrumentSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
