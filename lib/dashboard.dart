import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SITAMA App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
      ),
      home: const DashboardPage(),
    );
  }
}
// =======================================================================
// HALAMAN DASHBOARD
// =======================================================================

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Set initial focused day to January 2025 to match the screenshot
  DateTime _focusedDay = DateTime(2025, 1);
  DateTime? _selectedDay;

  // --- LOGIC AND DATA (UNCHANGED) ---
  // This data and the methods to display details and pick dates are kept from your original code.

  final List<Map<String, dynamic>> _semuaJadwal = [
    {
      "tanggal": DateTime(2025, 10, 20),
      "nama": "Kh. Dimas Ramdhan",
      "nim": "3.34.24.120",
      "jurusan": "D3 Teknik Informatika",
      "judul": "Sensor Pendeteksi Semut",
      "deskripsi": "Alat sensor pendeteksi semut",
      "jam": "08:00 WIB",
      "tempat": "Lab Multimedia SB II/04",
      "pembimbing": ["Pak Suko", "Pak Amran"],
      "penguji": ["Pak Suko", "Pak Amran"],
    },
    {
      "tanggal": DateTime(2025, 10, 21),
      "nama": "Farhan Dwi Cahyanto",
      "nim": "3.34.24.211",
      "jurusan": "D3 Teknik Informatika",
      "judul": "Pemantik Api Berbasis Web",
      "deskripsi": "Alat pemantik otomatis yang dikontrol melalui website",
      "jam": "13:00 WIB",
      "tempat": "Lab Multimedia SB II/04",
      "pembimbing": ["Pak Suko", "Pak Amran"],
      "penguji": ["Pak Suko", "Pak Amran"],
    },
    {
      "tanggal": DateTime(2025, 10, 21),
      "nama": "Farhan Dwi Cahyanto",
      "nim": "3.34.24.211",
      "jurusan": "D3 Teknik Informatika",
      "judul": "Pemantik Api Berbasis Web",
      "deskripsi": "Alat pemantik otomatis yang dikontrol melalui website",
      "jam": "13:00 WIB",
      "tempat": "Lab Multimedia SB II/04",
      "pembimbing": ["Pak Suko", "Pak Amran"],
      "penguji": ["Pak Suko", "Pak Amran"],
    },
    {
      "tanggal": DateTime(2025, 10, 21),
      "nama": "Farhan Dwi Cahyanto",
      "nim": "3.34.24.211",
      "jurusan": "D3 Teknik Informatika",
      "judul": "Pemantik Api Berbasis Web",
      "deskripsi": "Alat pemantik otomatis yang dikontrol melalui website",
      "jam": "13:00 WIB",
      "tempat": "Lab Multimedia SB II/04",
      "pembimbing": ["Pak Suko", "Pak Amran"],
      "penguji": ["Pak Suko", "Pak Amran"],
    },
    {
      "tanggal": DateTime(2025, 10, 21),
      "nama": "Farhan Dwi Cahyanto",
      "nim": "3.34.24.211",
      "jurusan": "D3 Teknik Informatika",
      "judul": "Pemantik Api Berbasis Web",
      "deskripsi": "Alat pemantik otomatis yang dikontrol melalui website",
      "jam": "13:00 WIB",
      "tempat": "Lab Multimedia SB II/04",
      "pembimbing": ["Pak Suko", "Pak Amran"],
      "penguji": ["Pak Suko", "Pak Amran"],
    },
  ];

  List<Map<String, dynamic>> get _jadwalTampil {
    if (_selectedDay == null) return [];
    return _semuaJadwal
        .where((e) => isSameDay(e['tanggal'], _selectedDay))
        .toList();
  }

  void _showDetail(Map<String, dynamic> j) {
    final String tanggalFormatted = DateFormat(
      'EEEE, d MMMM yyyy',
      'id_ID',
    ).format(j['tanggal']);
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF1E88E5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      j['nama'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${j['nim']} - ${j['jurusan']}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              j['tempat'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              tanggalFormatted,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          j['jam'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      "Judul Tugas Akhir",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    Text(j['judul']),
                    const SizedBox(height: 10),
                    Text(
                      "Deskripsi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    Text(j['deskripsi']),
                    const SizedBox(height: 10),
                    Text(
                      "Dosen Pembimbing",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    for (var d in j['pembimbing']) Text("• $d"),
                    const SizedBox(height: 10),
                    Text(
                      "Dosen Penguji",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    for (var d in j['penguji']) Text("• $d"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Tutup"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _selectedMonthLabel(DateTime d) {
    return [
      'JANUARI',
      'FEBRUARI',
      'MARET',
      'APRIL',
      'MEI',
      'JUNI',
      'JULI',
      'AGUSTUS',
      'SEPTEMBER',
      'OKTOBER',
      'NOVEMBER',
      'DESEMBER',
    ][d.month - 1];
  }

  void _selectMonth(BuildContext context) async {
    final int? pickedMonth = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Pilih Bulan'),
          children: List.generate(12, (index) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, index + 1);
              },
              child: Text(_selectedMonthLabel(DateTime(0, index + 1))),
            );
          }),
        );
      },
    );

    if (pickedMonth != null) {
      setState(() {
        _focusedDay = DateTime(_focusedDay.year, pickedMonth, 1);
      });
    }
  }

  void _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _focusedDay,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        _focusedDay = DateTime(picked.year, _focusedDay.month, 1);
      });
    }
  }

  // --- UI WIDGETS (REBUILT) ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Column(
        children: [
          // Bagian atas yang fixed (header, calendar, title)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Header
              _buildHeader(),

              // Section 2: Calendar Card
              _buildCalendarCard(),

              // Section 3: Schedule Title
              _buildScheduleTitle(),
            ],
          ),

          // Bagian konten yang bisa scroll
          Expanded(
            child: _jadwalTampil.isEmpty
                ? _buildEmptySchedule()
                : _buildScheduleList(),
          ),

          // Spacer untuk bottom navigation
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: _buildFAB(),
      bottomSheet: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
      decoration: const BoxDecoration(color: Color(0xFFE3F2FD)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Datang,',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Suko Tyas',
            style: TextStyle(
              fontSize: 22,
              color: Color(0xFF34495E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildDateSelectors(),
              const SizedBox(height: 10),
              _buildTableCalendar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelectors() {
    const Color blueMain = Color(0xFF1E88E5);
    return Row(
      children: [
        InkWell(
          onTap: () => _selectMonth(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: blueMain,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  _selectedMonthLabel(_focusedDay),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () => _selectYear(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: blueMain,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  _focusedDay.year.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableCalendar() {
    const Color blueMain = Color(0xFF1E88E5);
    return TableCalendar(
      locale: 'en_US', // Use 'en_US' for Mo, Tu, We labels as in the image
      rowHeight: 40,
      daysOfWeekHeight: 24,
      headerVisible: false, // Custom header is used above
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
        weekendStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(color: blueMain, shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(
          color: blueMain,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildScheduleTitle() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Text(
        'Jadwal Sidang Tugas Akhir',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildEmptySchedule() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height *
            0.6, // Gunakan persentase dari tinggi layar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/kalender.png',
                height: 400, // Bisa disesuaikan antara 400-600
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Tidak ditemukan jadwal\nsidang Tugas Akhir',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      children: _jadwalTampil.map((j) {
        return GestureDetector(
          onTap: () => _showDetail(j),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          j['nama'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          j['judul'],
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          j['tempat'],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 48,
                    width: 1,
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  Text(
                    j['jam'],
                    style: const TextStyle(
                      color: Color(0xFF1E88E5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        // FAB action
      },
      backgroundColor: const Color(0xFF1E88E5),
      elevation: 4.0,
      shape: const CircleBorder(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.school, color: Colors.white, size: 28),
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Color(0xFF1E88E5), // Blue background for contrast
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      color: const Color(0xFFF4F6F8), // Match scaffold background
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home_filled, color: Color(0xFF1E88E5)),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.school, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}