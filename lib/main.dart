import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SITAMA Login',
      debugShowCheckedModeBanner: false, // Menghilangkan banner "Debug"
      theme: ThemeData(
        // Tema dasar untuk warna biru Polines
        primarySwatch: Colors.blue,
        // Properti untuk menghilangkan efek visual yang tidak ada di desain asli
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
      ),
      home: const LoginScreen(),
    );
  }
}

// Menggunakan StatefulWidget agar kita bisa mengelola state seperti checkbox dan visibility
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // State untuk checkbox "Ingat Saya"
  bool _rememberMe = true;
  // State untuk toggle visibilitas password
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Scaffold untuk kerangka halaman
    return Scaffold(
      body: Container(
        // 1. BACKGROUND GRADASI
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Warna disesuaikan agar mirip dengan gambar (biru muda ke putih)
            colors: [
              Color(0xFFBBDEFB), // Biru Muda Polines Light (Bisa kamu ganti)
              Color(0xFFFFFFFF), // Putih
            ],
          ),
        ),
        // SingleChildScrollView agar layar bisa di-scroll saat keyboard muncul
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Jarak dari atas (margin)
              SizedBox(height: MediaQuery.of(context).padding.top + 60),

              // 2. HEADER: LOGO DAN NAMA APLIKASI
              _buildHeader(),

              const SizedBox(height: 50),

              // 3. FORM LOGIN
              _buildLoginForm(context),

              const SizedBox(height: 30),

              // 4. TOMBOL UTAMA & LOGIN GOOGLE
              _buildActionButtons(context),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget Pembantu (Methods) ---

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo (Pastikan nama file di assets/ sudah benar!)
        Image.asset(
          'assets/logo.jpeg', // Ganti ke 'assets/logo.jpeg' atau nama file kamu
          height: 100,
        ),
        const SizedBox(height: 15),
        // SITAMA Text
        const Text(
          'SITAMA',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0), // Warna biru tua
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    // Theme data untuk border dan dekorasi input
    final inputDecoration = InputDecoration(
      hintText: 'Alamat Email Polines',
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      // Border default
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFFBBDEFB)),
      ),
      // Border saat tidak fokus
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFFBBDEFB)),
      ),
      // Border saat fokus (biru)
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2.0),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Alamat Email
        const Text('Alamat Email',
            style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          decoration: inputDecoration.copyWith(hintText: 'Alamat Email'),
          keyboardType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 20),

        // Label Password
        const Text('Password', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        // Password Field
        TextField(
          obscureText: !_isPasswordVisible, // Menggunakan state
          decoration: inputDecoration.copyWith(
            hintText: 'Password',
            // Ikon mata untuk toggle password
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                // Mengubah state saat ikon diklik
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Checkbox "Ingat Saya" dan "Lupa password?"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Checkbox dan Text
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _rememberMe, // Menggunakan state
                    onChanged: (bool? newValue) {
                      setState(() {
                        _rememberMe = newValue ?? false;
                      });
                    },
                    activeColor: const Color(0xFF2196F3),
                    materialTapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Membuat lebih ringkas
                  ),
                ),
                const SizedBox(width: 4),
                const Text('Ingat Saya', style: TextStyle(fontSize: 14)),
              ],
            ),

            // Lupa Password Button
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Lupa password?',
                style: TextStyle(color: Color(0xFF2196F3), fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Tombol Masuk
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3), // Biru Solid
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Masuk',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Teks "atau"
        const Text('atau', style: TextStyle(color: Colors.grey)),

        const SizedBox(height: 20),

        // Tombol Login Google Polines
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF2196F3), width: 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Menggunakan aset gambar Google (harus ada di assets/images/icon_google.png)
                // Jika kamu kesulitan dengan ikon Google, ganti baris ini dengan Icon(Icons.g_mobiledata, size: 30, color: Colors.blue)
                Image.asset(
                  'assets/google.png', // Ganti dengan path ikon Google kamu
                  height: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Masuk dengan Email Polines',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Keterangan (untuk Dosen)
        const Text(
          '(untuk Dosen)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
