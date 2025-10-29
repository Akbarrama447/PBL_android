import 'package:flutter/material.dart';

// Definisikan warna yang digunakan (diambil dari main.dart/pendaftaran_ta.dart)
const Color customBlue = Color(0xFF149BF6);
const Color lightBlueHeader = Color(0xFFE1F5FE); 
// Warna background field input (dari gambar Anda)
const Color fieldBackgroundColor = Color(0xFFFBEFFF); 

class GuidanceFormScreen extends StatefulWidget {
  const GuidanceFormScreen({super.key});

  @override
  State<GuidanceFormScreen> createState() => _GuidanceFormScreenState();
}

class _GuidanceFormScreenState extends State<GuidanceFormScreen> {
  // Daftar nama Pembimbing
  final List<String> _pembimbingList = [
    'Pembimbing 1: Dr. Siti Nuraini, M.T.',
    'Pembimbing 2: Suko Tyas, S.Kom., M.Eng.',
  ];

  // Nilai yang dipilih. Kita set default ke Pembimbing 2 (sesuai screenshot terakhir Anda)
  String? _selectedPembimbing = 'Pembimbing 2: Suko Tyas, S.Kom., M.Eng.';

  void _submitJudul() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Judul Bimbingan Diajukan dengan Pembimbing: $_selectedPembimbing!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===========================================
            // 1. HEADER KUSTOM (Suko Tyas & Daftar Bimbingan)
            // ===========================================
            Container(
              padding: EdgeInsets.only(top: statusBarHeight + 15, bottom: 15, left: 20, right: 20),
              decoration: const BoxDecoration(
                color: lightBlueHeader,
                border: Border(bottom: BorderSide(color: customBlue, width: 2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('Suko Tyas', style: TextStyle(color: Colors.black54, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Daftar Bimbingan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: customBlue),
                  ),
                ],
              ),
            ),
            
            // ===========================================
            // 2. ISI FORMULIR
            // ===========================================
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- JUDUL BIMBINGAN ---
                  _buildLabel('Judul Bimbingan'),
                  TextFormField(
                    maxLines: 2,
                    decoration: _getInputDecoration('Masukkan Judul Tugas Akhir (wajib diisi)'),
                  ),
                  const SizedBox(height: 25),

                  // --- DESKRIPSI / REKAN KELOMPOK ---
                  _buildLabel('Deskripsi'),
                  TextFormField(
                    maxLines: 2,
                    decoration: _getInputDecoration('Masukkan Nama Rekan Kelompok (opsional)'),
                  ),
                  const SizedBox(height: 25),
                  
                  // --- PEMBIMBING (Dropdown) ---
                  _buildLabel('Pembimbing'),
                  
                  // Komponen DROPDOWNBUTTONFORIFIELD
                  DropdownButtonFormField<String>(
                    value: _selectedPembimbing,
                    isExpanded: true,
                    // Desain agar mirip field input yang lain
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fieldBackgroundColor,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: customBlue)),
                    ),
                    items: _pembimbingList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPembimbing = newValue;
                      });
                    },
                  ),

                  const SizedBox(height: 30),
                  
                  // --- TOMBOL AJUKAN JUDUL ---
                  ElevatedButton(
                    onPressed: _submitJudul,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Ajukan Judul', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar diurus oleh MainScreenWrapper (main.dart)
    );
  }

  // Fungsi pembantu untuk label teks
  Widget _buildLabel(String text) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // Fungsi pembantu untuk dekorasi input field
  InputDecoration _getInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: fieldBackgroundColor,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: customBlue)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}