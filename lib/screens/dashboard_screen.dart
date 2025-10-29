import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/schedule_detail_dialog.dart';

// Enum untuk mendefinisikan tipe filter yang tersedia
enum FilterType { none, room, time }

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _focusedDay = DateTime(2025, 1);
  DateTime? _selectedDay;

  // Variabel state untuk menyimpan filter yang sedang aktif
  FilterType _activeFilter = FilterType.none;

  final List<Map<String, dynamic>> _semuaJadwal = [
    // Data dummy
    {
      "tanggal": DateTime(2025, 10, 28),
      "nama": "rivan Santoso",
      "nim": "3.34.24.34",
      "jurusan": "D3 Teknik Informatika",
      "judul": "Aplikasi Peminjaman Ruang",
      "deskripsi": "Sistem untuk manajemen peminjaman ruang kelas.",
      "jam": "10:00 WIB",
      "tempat": "Gedung SB II/01",
      "pembimbing": ["Pak Suko", "Pak Amran"],
      "penguji": ["Bu Ida", "Pak Budi"],
    },
    {
      "tanggal": DateTime(2025, 10, 28),
      "nama": "Budi Santoso",
      "nim": "3.34.24.100",
      "jurusan": "D3 Teknik Informatika",
      "judul": "Aplikasi Peminjaman Ruang",
      "deskripsi": "Sistem untuk manajemen peminjaman ruang kelas.",
      "jam": "10:00 WIB",
      "tempat": "Gedung SB II/01",
      "pembimbing": ["Pak Suko", "Pak Amran"],
      "penguji": ["Bu Ida", "Pak Budi"],
    },
    {
      "tanggal": DateTime(2025, 10, 29),
      "nama": "Farhan Dwi Cahyanto",
      "nim": "3.34.24.211",
      "jurusan": "D3 Teknik Informatika",
      "judul": "Pemantik Api Berbasis Web",
      "deskripsi": "Alat pemantik otomatis yang dikontrol melalui website.",
      "jam": "08:00 WIB",
      "tempat": "Lab Multimedia SB II/04",
      "pembimbing": ["Pak Suko", "Pak Amran"],
      "penguji": ["Pak Suko", "Pak Amran"],
    },
  ];

  // ## LOGIKA FILTER DIMASUKKAN DI SINI ##
  List<Map<String, dynamic>> get _jadwalTampil {
    if (_selectedDay == null) return [];

    List<Map<String, dynamic>> dailySchedules = _semuaJadwal
        .where((e) => isSameDay(e['tanggal'], _selectedDay))
        .toList();

    // Terapkan pengurutan berdasarkan filter yang aktif
    switch (_activeFilter) {
      case FilterType.room:
        dailySchedules.sort((a, b) => a['tempat'].compareTo(b['tempat']));
        break;
      case FilterType.time:
        dailySchedules.sort((a, b) {
          String timeA = a['jam'].split(' ')[0]; // "08:00"
          String timeB = b['jam'].split(' ')[0]; // "10:00"
          return timeA.compareTo(timeB);
        });
        break;
      case FilterType.none:
      default:
        // Tidak perlu diurutkan
        break;
    }

    return dailySchedules;
  }

  void _showDetail(Map<String, dynamic> j) {
    showDialog(
      context: context,
      builder: (_) => ScheduleDetailDialog(schedule: j),
    );
  }

  // Sisa method (seperti _selectedMonthLabel, _selectYear, dll.) tetap sama
  // ...

  @override
  Widget build(BuildContext context) {
    // ... Isi method build tetap sama ...
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Column(
        children: [
          _buildTopBar(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildCalendarCard(),
              _buildScheduleTitle(), // Ini akan memanggil widget yang telah kita ubah
            ],
          ),
          Expanded(
            child: _jadwalTampil.isEmpty
                ? _buildEmptySchedule()
                : _buildScheduleList(),
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: _buildFAB(),
      bottomSheet: _buildBottomNavBar(),
    );
  }

  // ## WIDGET JUDUL DIPERBARUI DI SINI ##
  Widget _buildScheduleTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Jadwal Sidang Tugas Akhir',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          PopupMenuButton<FilterType>(
            onSelected: (FilterType result) {
              setState(() {
                // Perbarui state filter saat opsi dipilih
                _activeFilter = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterType>>[
              const PopupMenuItem<FilterType>(
                value: FilterType.time,
                child: Text('Berdasarkan Waktu'),
              ),
              const PopupMenuItem<FilterType>(
                value: FilterType.room,
                child: Text('Berdasarkan Ruang'),
              ),
              // Hanya tampilkan opsi Reset jika ada filter yang aktif
              if (_activeFilter != FilterType.none) const PopupMenuDivider(),
              if (_activeFilter != FilterType.none)
                const PopupMenuItem<FilterType>(
                  value: FilterType.none,
                  child: Text('Reset Filter'),
                ),
            ],
            // Ganti ikon dan warnanya sesuai state
            icon: Icon(
              Icons.filter_list,
              color: _activeFilter != FilterType.none
                  ? const Color(0xFF1E88E5) // Warna biru jika aktif
                  : Colors.black54, // Warna abu-abu jika tidak aktif
            ),
          ),
        ],
      ),
    );
  }

  // ... Sisa kode widget lainnya (seperti _buildTopBar, _buildHeader, dll) tetap sama ...
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

  Widget _buildTopBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
        ),
      ),
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12.0,
        bottom: 12.0,
        right: 24.0,
      ),
      child: const Text(
        'Suko Tyas',
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF34495E),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFB3E5FC), // Biru muda
            Color(0xFFE3F2FD), // Biru sangat muda
          ],
        ),
      ),
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
            )
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
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down,
                    color: Colors.white, size: 20)
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
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down,
                    color: Colors.white, size: 20)
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
      locale: 'en_US',
      rowHeight: 40,
      daysOfWeekHeight: 24,
      headerVisible: false,
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
        // Atur gaya hari kerja (Senin-Jumat)
        weekdayStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54, // Warna hitam/abu-abu
        ),
        weekendStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54, // Sebelumnya: Colors.redAccent
        ),
      ),
      calendarStyle: CalendarStyle(
        weekendTextStyle: const TextStyle(color: Colors.black54),
        todayDecoration: BoxDecoration(color: blueMain, shape: BoxShape.circle),
        selectedDecoration:
            BoxDecoration(color: blueMain, shape: BoxShape.circle),
      ),
    );
  }

  Widget _buildEmptySchedule() {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/kalender.png',
                height: 400,
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
    return PopupMenuButton<String>(
      offset: const Offset(0, -120),
      onSelected: (value) {
        switch (value) {
          case 'daftar_ta':
            print('Pilih Daftar Tugas Akhir');
            break;
          case 'daftar_sidang':
            print('Pilih Daftar Sidang');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'daftar_ta',
          child: Row(
            children: [
              Icon(Icons.article_outlined, color: Colors.black54),
              SizedBox(width: 8),
              Text('Daftar Tugas Akhir'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'daftar_sidang',
          child: Row(
            children: [
              Icon(Icons.school_outlined, color: Colors.black54),
              SizedBox(width: 8),
              Text('Daftar Sidang'),
            ],
          ),
        ),
      ],
      child: Container(
        width: 56.0,
        height: 56.0,
        decoration: const BoxDecoration(
          color: Color(0xFF1E88E5),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.school, color: Colors.white, size: 28),
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.add, color: Color(0xFF1E88E5), size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      color: const Color(0xFFF4F6F8),
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
