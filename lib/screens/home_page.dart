import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'edit_page.dart'; // Editpage
import 'form_page.dart'; // FormSiswaPage
import 'detail_page.dart'; // DetailSiswaPage
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //client supabase untuk akses database
  final supabase = Supabase.instance.client;
  
  //cek koneksi internet
  final Connectivity _connectivity = Connectivity();
  late Stream<List<ConnectivityResult>> _connectivityStream;

  @override
  void initState() {
    super.initState();

    // Listener untuk notifikasi jaringan
    _connectivityStream = _connectivity.onConnectivityChanged;
    _connectivityStream.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        //jika jaringan terputus, tampilkan snackbar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Jaringan terputus!"),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    });
  }

// ambil data sisawa + relasi wali dari supabase
  Future<List<dynamic>> getSiswa() async {
    try {
      final response = await supabase
          .from('siswa')
          .select('*, wali(*)') // Mengambil data siswa dan wali terkait
          .order('id', ascending: false);// urutkan dari terbaru
      return response;
    } on SocketException {
      throw 'Tidak ada koneksi internet';
    } catch (e) {
      throw 'Terjadi masalah koneksi dengan server';
    }
  }

//hpaus data siwa berdasarkan id
  Future<void> deleteSiswa(String id) async {
    await supabase.from('siswa').delete().eq('id', id);
    setState(() {});
  }

//konfirmasi sebelum hapus data
  Future<void> _confirmDelete(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,// dialog tidak bisa ditutup dengan tap luar 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Hapus"),
          content: const Text("Apakah kamu yakin ingin menghapus data ini?"),
          actions: [
            TextButton(
              child: const Text("Tidak"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Ya"),
              onPressed: () async {
                Navigator.of(context).pop();
                await deleteSiswa(id);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Data berhasil dihapus"),
                      backgroundColor: Color.fromARGB(255, 255, 144, 144),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

//Warna baris list siswa bergantian (zebra effect)
  Color _getRowColor(int index) {
    return index % 2 == 0
        ? const Color(0xFFFFF0F5) // soft pink muda
        : const Color(0xFFFFE4E6); // pink pastel
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 164, 174),
        title: const Text(
          "Data Siswa",
          style: TextStyle(
            color: Color.fromARGB(221, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      //background gradient
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 249, 248, 191),
              Color(0xFFFFFFFF)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        //Ambil data dari supabase menggunakan futurebuilder
        child: FutureBuilder<List<dynamic>>(
          future: getSiswa(),
          builder: (context, snapshot) {
            //loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.pinkAccent),
              );
            }

          // error handling
            if (snapshot.hasError) {
              String errorMessage = snapshot.error.toString();
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                      ),
                      onPressed: () {
                        setState(() {}); // refresh retry
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            }
            
            // jika data kosong
            final siswaList = snapshot.data ?? [];

            if (siswaList.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school,
                      size: 80,
                      color: Colors.pinkAccent,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Data siswa kosong",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Untuk menambahkan data, klik tombol +",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }

            // jika ada data -> tampilkan list siswa
            return ListView.builder(
              itemCount: siswaList.length,
              itemBuilder: (context, index) {
                final siswa = siswaList[index];

                return Container(
                  color: _getRowColor(index),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //data siswa (nama, nisn, jenis kelamin)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              siswa['nama_lengkap'] ?? '-',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              siswa['nisn'] ?? '-',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              siswa['jenis_kelamin'] ?? '-',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // tombol aksi: Lihat, edit, hapus
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: Color.fromARGB(255, 33, 150, 243),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailSiswaPage(data: siswa),
                                ),
                              ).then((_) => setState(() {}));
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 67, 170, 255),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Editpage(data: siswa),
                                ),
                              ).then((_) => setState(() {}));
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 239, 89, 78),
                            ),
                            onPressed: () =>
                                _confirmDelete(siswa['id'].toString()),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),

      //tombol tambah data siswa
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormSiswaPage()),
          ).then((_) => setState(() {}));
        },
      ),
    );
  }
}