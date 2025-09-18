import 'package:flutter/material.dart';
import 'edit_page.dart'; // mendefinisikan `Editpage`

class DetailSiswaPage extends StatelessWidget {
  final Map<String, dynamic>? data;
  const DetailSiswaPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final siswaData = data ?? {};
    final waliData = siswaData['wali'] ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9C4), // Kuning pastel, sesuai dengan form
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 164, 174), // Pink pastel
        title: const Text("Detail Data Siswa"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian 1: Data Pribadi
            _buildSectionTitle("Data Pribadi"),
            _buildInfoCard("NISN", siswaData['nisn'] ?? 'Tidak tersedia'),
            _buildInfoCard("Nama Lengkap", siswaData['nama_lengkap'] ?? 'Tidak tersedia'),
            _buildInfoCard("Jenis Kelamin", siswaData['jenis_kelamin'] ?? 'Tidak tersedia'),
            _buildInfoCard("Agama", siswaData['agama'] ?? 'Tidak tersedia'),
            _buildInfoCard("Tempat Lahir", siswaData['tempat_lahir'] ?? 'Tidak tersedia'),
            _buildInfoCard("Tanggal Lahir", siswaData['tanggal_lahir'] ?? 'Tidak tersedia'),
            _buildInfoCard("No HP", siswaData['no_telp'] ?? 'Tidak tersedia'),
            _buildInfoCard("NIK", siswaData['nik'] ?? 'Tidak tersedia'),

            const SizedBox(height: 24),

            // Bagian 2: Alamat Siswa
            _buildSectionTitle("Alamat Siswa"),
            _buildInfoCard("Jalan", siswaData['jalan'] ?? 'Tidak tersedia'),
            _buildInfoCard("RT/RW", siswaData['rt_rw'] ?? 'Tidak tersedia'),
            _buildInfoCard("Dusun", siswaData['dusun'] ?? 'Tidak tersedia'),
            _buildInfoCard("Desa", siswaData['desa'] ?? 'Tidak tersedia'),
            _buildInfoCard("Kecamatan", siswaData['kecamatan'] ?? 'Tidak tersedia'),
            _buildInfoCard("Kabupaten", siswaData['kabupaten'] ?? 'Tidak tersedia'),
            _buildInfoCard("Provinsi", siswaData['provinsi'] ?? 'Tidak tersedia'),
            _buildInfoCard("Kode Pos", siswaData['kode_pos'] ?? 'Tidak tersedia'),

            const SizedBox(height: 24),

            // Bagian 3: Orang Tua / Wali
            _buildSectionTitle("Orang Tua / Wali"),
            _buildInfoCard("Nama Ayah", waliData['nama_ayah'] ?? 'Tidak tersedia'),
            _buildInfoCard("Nama Ibu", waliData['nama_ibu'] ?? 'Tidak tersedia'),
            _buildInfoCard("Nama Wali", waliData['nama_wali'] ?? 'Tidak tersedia'),
            _buildInfoCard("Jalan Orang Tua", waliData['jalan'] ?? 'Tidak tersedia'),
            _buildInfoCard("RT/RW Orang Tua", waliData['rt_rw'] ?? 'Tidak tersedia'),
            _buildInfoCard("Dusun Orang Tua", waliData['dusun'] ?? 'Tidak tersedia'),
            _buildInfoCard("Desa Orang Tua", waliData['desa'] ?? 'Tidak tersedia'),
            _buildInfoCard("Kecamatan Orang Tua", waliData['kecamatan'] ?? 'Tidak tersedia'),
            _buildInfoCard("Kabupaten Orang Tua", waliData['kabupaten'] ?? 'Tidak tersedia'),
            _buildInfoCard("Provinsi Orang Tua", waliData['provinsi'] ?? 'Tidak tersedia'),
            _buildInfoCard("Kode Pos Orang Tua", waliData['kode_pos'] ?? 'Tidak tersedia'),

            const SizedBox(height: 24),

            // Tombol Edit (opsional, kembali ke form edit)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman edit, kirim data yang sama
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Editpage(data: data))); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 164, 174),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Edit Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk judul section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 164, 174),
        ),
      ),
    );
  }

  // Widget untuk card info (label: value)
  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '$label:',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}