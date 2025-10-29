import 'package:flutter/material.dart';
// Impor semua layar
import 'change_password_screen.dart'; 
import 'guidance_form_screen.dart'; 
import 'pendaftaran_ta.dart'; // Import file pendaftaran

// Definisi konstanta
const Color customBlue = Color(0xFF149BF6); 
const double avatarRadius = 41.0; 
const double bottomIconSize = 40.0; 

// PENTING: Fungsi main() harus ada!
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Profil dan Tugas Akhir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        brightness: Brightness.light, 
      ),
      // Set MainScreenWrapper sebagai halaman awal
      home: const MainScreenWrapper(),
    );
  }
}

// ===========================================
// WIDGET UTAMA (MAIN SCREEN WRAPPER)
// ===========================================

// Widget ini menampung BottomNavigationBar dan mengelola perpindahan antar tab.
class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({super.key});

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  // Index 1 adalah Pendaftaran TA (Ikon Notes) - Menjadi tab aktif saat start
  int _selectedIndex = 1; 

  // Daftar Widgets yang akan ditampilkan sesuai index BottomNavigationBar
  static final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('Halaman Home')),              // Index 0: Home
    const PendaftaranTaScreen(),                       // Index 1: Pendaftaran Tugas Akhir
    const GuidanceFormScreen(),                          // Index 2: Formulir Bimbingan
    const ProfileScreen(),                             // Index 3: Profil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tampilkan Widget yang dipilih dari _widgetOptions
      body: _widgetOptions.elementAt(_selectedIndex),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          // Ikon description/notes yang aktif (biru)
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Daftar TA'),
          // Ikon study/akademik
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Study'), 
          // Ikon profil
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: customBlue, 
        unselectedItemColor: Colors.grey, 
        onTap: _onItemTapped,
        iconSize: bottomIconSize, 
        // Menonaktifkan label agar lebih mirip desain gambar
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// ===========================================
// CLUSTER LAYAR PROFIL
// ===========================================

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void _changePassword() {
    // Navigasi ke layar Ubah Password
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
    );
  }

  void _logout() {
    _showSnackbar('Tombol Logout DITEKAN. Anda akan diarahkan ke halaman Login.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3F2FD), Colors.white, Color(0xFFE3F2FD)],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Bagian Header Profil
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: avatarRadius, 
                      backgroundColor: customBlue.withOpacity(0.8), 
                      child: const Text('H', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Hanifah Yumna', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('hanifahyumna@gmail.com', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    _buildUserInfoRow(Icons.person, 'Hanifah Yumna', isBold: true),
                    const SizedBox(height: 15),
                    _buildUserInfoRow(Icons.badge, '3.34.24.2.05', isLink: true),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    _buildActionButton(context, icon: Icons.vpn_key, label: 'Ubah password', color: customBlue, onPressed: _changePassword),
                    const SizedBox(height: 20),
                    _buildActionButton(context, icon: Icons.logout, label: 'Logout', color: customBlue, onPressed: _logout),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(IconData icon, String text, {bool isLink = false, bool isBold = false}) {
    return Row(
      children: <Widget>[
        Icon(icon, color: customBlue, size: 30),
        const SizedBox(width: 15),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isLink ? customBlue : Colors.black,
            decoration: isLink ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(fontSize: 16, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}