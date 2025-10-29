// lib/change_password_screen.dart
import 'package:flutter/material.dart';

// Definisi warna yang sama dari main.dart
const Color customBlue = Color(0xFF149BF6); 

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
        backgroundColor: customBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Masukkan password baru Anda di bawah ini.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            
            // Input Password Lama
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Lama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 20),

            // Input Password Baru
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Baru',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),

            // Input Konfirmasi Password Baru
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password Baru',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_reset),
              ),
            ),
            const SizedBox(height: 40),

            // Tombol Simpan
            ElevatedButton(
              onPressed: () {
                // Tampilkan SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password berhasil diperbarui! (Simulasi)')),
                );
                // Perintah Navigator.pop akan menutup layar ini dan kembali ke layar ProfileScreen
                Navigator.pop(context); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: customBlue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Simpan Password Baru',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}