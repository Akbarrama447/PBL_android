import 'package:flutter/material.dart';
// --- TAMBAHAN LOGIKA ---
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'home_page.dart'; // Impor halaman home baru
// -----------------------

//
// -------------------------------------------------------------------
// ---------------- GANTI ALAMAT IP DI BAWAH INI ---------------------
// -------------------------------------------------------------------
//
// Ganti IP ini sesuai situasimu:
// - Pakai "10.0.2.2" jika kamu pakai Emulator Android
// - Pakai "192.168.x.x" (IP laptopmu) jika kamu pakai HP Fisik
//   (Pastikan 'php artisan serve --host=0.0.0.0' sudah jalan)
const String API_HOST = "192.168.1.83:8000"; // <--- GANTI INI
//
// -------------------------------------------------------------------

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
        primarySwatch: Colors.blue,
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // State UI-mu yang sudah ada
  bool _rememberMe = true;
  bool _isPasswordVisible = false;

  // --- TAMBAHAN LOGIKA ---
  // Controller untuk mengambil teks dari TextField
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // State untuk status loading tombol
  bool _isLoading = false;
  // State untuk menampilkan pesan error
  String _errorMessage = '';

  @override
  void dispose() {
    // Selalu dispose controller untuk menghindari memory leak
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk memanggil API Login
  Future<void> _login() async {
    // 1. Tampilkan loading di tombol & bersihkan error lama
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // 2. Kirim request POST ke API Laravel
      final response = await http.post(
        Uri.parse('http://$API_HOST/api/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // 3. JIKA SUKSES (STATUS 200)
        final String token = responseBody['token'];

        // Simpan token ke HP
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        // Pindah ke Halaman Home
        if (mounted) { // Cek apakah widget masih ada
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } else {
        // 4. JIKA GAGAL (Status bukan 200, misal 401)
        setState(() {
          _errorMessage = responseBody['message'] ?? 'Login gagal. Coba lagi.';
        });
      }
    } catch (e) {
      // 5. JIKA ERROR KONEKSI (Server mati, IP salah, HP tidak ada internet)
      setState(() {
        _errorMessage = 'Gagal terhubung ke server. Cek IP & koneksi internetmu.';
      });
    } finally {
      // 6. APAPUN HASILNYA, hentikan loading
      setState(() {
        _isLoading = false;
      });
    }
  }
  // --- AKHIR DARI TAMBAHAN LOGIKA ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFBBDEFB),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 60),
              _buildHeader(),
              const SizedBox(height: 50),
              _buildLoginForm(context),

              // --- TAMBAHAN LOGIKA: Tampilkan Error ---
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              // ------------------------------------

              const SizedBox(height: 30),
              _buildActionButtons(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/logo.jpeg',
          height: 100,
        ),
        const SizedBox(height: 15),
        const Text(
          'SITAMA',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final inputDecoration = InputDecoration(
      hintText: 'Alamat Email',
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFFBBDEFB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFFBBDEFB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2.0),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Alamat Email', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController, // <-- SAMBUNGKAN CONTROLLER
          decoration: inputDecoration.copyWith(hintText: 'Alamat Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        const Text('Password', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController, // <-- SAMBUNGKAN CONTROLLER
          obscureText: !_isPasswordVisible,
          decoration: inputDecoration.copyWith(
            hintText: 'Password',
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _rememberMe = newValue ?? false;
                      });
                    },
                    activeColor: const Color(0xFF2196F3),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 4),
                const Text('Ingat Saya', style: TextStyle(fontSize: 14)),
              ],
            ),
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
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            // --- TAMBAHAN LOGIKA ---
            // Nonaktifkan tombol saat loading, panggil _login saat tidak
            onPressed: _isLoading ? null : _login,
            // ---------------------
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 0,
            ),
            // --- TAMBAHAN LOGIKA ---
            // Ganti teks jadi loading spinner
            child: _isLoading
                ? const SizedBox(
                    width: 25,
                    height: 25,
                    // Bikin spinner-nya warna putih
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3.0,
                    ),
                  )
                : const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            // ---------------------
          ),
        ),
        const SizedBox(height: 20),
        const Text('atau', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              // TODO: Logika login Google
            },
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
                Image.asset(
                  'assets/google.png',
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
        const Text(
          '(untuk Dosen)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

