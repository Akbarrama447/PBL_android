import 'package:flutter/material.dart';

// Definisi model untuk berkas yang diperlukan
class RequiredFile {
  final String label;
  String fileName;
  
  RequiredFile(this.label, {this.fileName = 'belum ada berkas'});
}

class PendaftaranTaScreen extends StatefulWidget {
  const PendaftaranTaScreen({super.key});

  @override
  State<PendaftaranTaScreen> createState() => _PendaftaranTaScreenState();
}

class _PendaftaranTaScreenState extends State<PendaftaranTaScreen> {
  // Warna kustom dari main.dart
  final Color customBlue = const Color(0xFF149BF6); 
  // Warna background untuk field input
  final Color fieldBackgroundColor = const Color(0xFFFBEFFF); 

  // Daftar berkas yang diperlukan (diinisialisasi)
  final List<RequiredFile> _filesToUpload = [
    ...List.generate(6, (index) => RequiredFile('Surat Keterangan Magang')),
    RequiredFile('Surat Keterangan Bimbingan'),
    RequiredFile('Bukti Pembayaran TA'),
  ];
  

  // Fungsi untuk menampilkan Modal Pemilihan Berkas (Simulasi Upload)
  void _showFilePickerModal(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          // Tinggi modal diatur 45% dari tinggi layar
          height: MediaQuery.of(context).size.height * 0.45, 
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Unggah Berkas: ${_filesToUpload[index].label}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: customBlue),
              ),
              const Divider(),
              const SizedBox(height: 10),
              
              // Informasi berkas yang sedang terunggah
              Text(
                'Status saat ini: ${_filesToUpload[index].fileName}',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // Tombol UPLOAD
              ElevatedButton.icon(
                onPressed: () {
                  // --- TEMPAT LOGIKA FILE PICKER NYATA (e.g., file_picker) ---
                  
                  // SIMULASI BERHASIL
                  String newFileName = 'berkas_ta_${DateTime.now().millisecond}.pdf';
                  
                  // Panggil fungsi penanganan unggah
                  _handleFileUploadSuccess(index, newFileName);

                  Navigator.pop(context); // Tutup modal setelah simulasi
                },
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Pilih dan Unggah Berkas'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: customBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              
              const SizedBox(height: 10),
              // Tombol Batal
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Batal', style: TextStyle(color: Colors.grey[600])),
              ),
              
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk menangani hasil pemilihan/pengunggahan berkas (penyimpanan)
  void _handleFileUploadSuccess(int index, String fileName) {
      setState(() {
        _filesToUpload[index].fileName = fileName; // Memperbarui nama file yang tersimpan
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Berkas "${_filesToUpload[index].label}" berhasil diunggah: $fileName')),
      );
  }
  
  // Fungsi yang dipanggil saat ikon di formulir diklik
  void _pickFile(int index) {
    _showFilePickerModal(index);
  }
  
  // Fungsi untuk tombol "Daftar Sidang"
  void _daftarSidang() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proses Pendaftaran Sidang Dimulai...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendaftaran Tugas Akhir'),
        backgroundColor: customBlue,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      // Konten utama formulir yang dapat digulir
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Loop untuk menampilkan semua item unggah berkas dari list
            ...List.generate(
              _filesToUpload.length,
              (index) => _buildFileUploadItem(index),
            ),
            
            const SizedBox(height: 32),
            
            // Tombol "Daftar Sidang"
            Center(
              child: ElevatedButton(
                onPressed: _daftarSidang,
                style: ElevatedButton.styleFrom(
                  backgroundColor: customBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Daftar Sidang',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            const SizedBox(height: 50),
          ],
        ),
      ),
      // Catatan: BottomNavigationBar diurus oleh MainScreenWrapper di main.dart
    );
  }

  // Widget pembantu untuk membuat satu item unggah berkas di dalam formulir
  Widget _buildFileUploadItem(int index) {
    bool isUploaded = _filesToUpload[index].fileName != 'belum ada berkas';
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _filesToUpload[index].label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          TextFormField(
            readOnly: true,
            controller: TextEditingController(text: _filesToUpload[index].fileName),
            style: TextStyle(
              fontWeight: isUploaded ? FontWeight.w600 : FontWeight.w500,
              color: isUploaded ? Colors.black87 : Colors.grey,
            ),
            decoration: InputDecoration(
              // Styling agar mirip gambar UI
              filled: true,
              fillColor: fieldBackgroundColor, 
              
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: customBlue.withOpacity(0.5)), 
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: customBlue.withOpacity(0.3), width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: customBlue, width: 2.0),
              ),
              
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                // IconButton yang memanggil modal UPLOAD
                child: IconButton(
                  icon: Icon(Icons.file_copy, color: customBlue, size: 30),
                  onPressed: () => _pickFile(index), 
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}