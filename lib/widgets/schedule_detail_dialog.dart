import 'package:flutter/material.dart';

class ScheduleDetailDialog extends StatelessWidget {
  final Map<String, dynamic> schedule;

  const ScheduleDetailDialog({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // ClipRRect untuk memastikan semua sudut (termasuk header biru) membulat
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Membuat dialog sekecil kontennya
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // == Bagian Header Biru ==
            Container(
              color: const Color(0xFF2196F3),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schedule['nama'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${schedule['nim']} – ${schedule['jurusan']}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // == Bagian Konten Putih ==
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailSection('Judul Tugas Akhir', schedule['judul']),
                  const SizedBox(height: 16),
                  _buildDetailSection('Deskripsi', schedule['deskripsi']),
                  const SizedBox(height: 16),
                  _buildLecturerList(
                      'Dosen Pembimbing', schedule['pembimbing']),
                  const SizedBox(height: 16),
                  _buildLecturerList('Dosen Penguji', schedule['penguji']),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildInfoChip(schedule['tempat']),
                      const SizedBox(width: 8),
                      _buildInfoChip(schedule['jam']),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget bantuan untuk membuat bagian judul dan isi
  Widget _buildDetailSection(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color(0xFF34495E),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  // Widget bantuan untuk membuat daftar dosen bernomor
  Widget _buildLecturerList(String title, List<dynamic> lecturers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color(0xFF34495E),
          ),
        ),
        const SizedBox(height: 4),
        // Looping untuk membuat list nomor
        ...List.generate(lecturers.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              '${index + 1}. ${lecturers[index]}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          );
        }),
      ],
    );
  }

  // Widget bantuan untuk membuat chip info di bawah
  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1E88E5),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
