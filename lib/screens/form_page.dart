import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormSiswaPage extends StatefulWidget {
  final Map<String, dynamic>? data;
  const FormSiswaPage({super.key, this.data});

  @override
  State<FormSiswaPage> createState() => _FormSiswaPageState();
}

class _FormSiswaPageState extends State<FormSiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  int _currentStep = 0;

  // ------------------------------
  // Controllers: Data Pribadi
  // ------------------------------
  late TextEditingController _nisnController;
  late TextEditingController _namaController;
  late TextEditingController _jenisKelaminController;
  late TextEditingController _agamaController;
  late TextEditingController _tempatLahirController;
  late TextEditingController _tanggalLahirController;
  late TextEditingController _noHpController;
  late TextEditingController _nikController;

  // ------------------------------
  // Controllers: Alamat Siswa
  // ------------------------------
  late TextEditingController _dusunController;
  late TextEditingController _desaController;
  late TextEditingController _kecamatanController;
  late TextEditingController _kabupatenController;
  late TextEditingController _provinsiController;
  late TextEditingController _kodePosController;
  late TextEditingController _jalanController;
  late TextEditingController _rtRwController;

  // ------------------------------
  // Controllers: Orang Tua / Wali
  // ------------------------------
  late TextEditingController _namaAyahController;
  late TextEditingController _namaIbuController;
  late TextEditingController _namaWaliController;

  // Alamat Orang Tua / Wali
  late TextEditingController _dusunOrangTuaController;
  late TextEditingController _desaOrangTuaController;
  late TextEditingController _kecamatanOrangTuaController;
  late TextEditingController _kabupatenOrangTuaController;
  late TextEditingController _provinsiOrangTuaController;
  late TextEditingController _kodePosOrangTuaController;
  late TextEditingController _jalanOrangTuaController;
  late TextEditingController _rtRwOrangTuaController;

  @override
  void initState() {
    super.initState();

    // ambil data (jika edit)
    final data = widget.data ?? {};
    final waliData = data['wali'] ?? {};

    // Inisialisasi controller Data Pribadi
    _nisnController = TextEditingController(text: data['nisn'] ?? '');
    _namaController = TextEditingController(text: data['nama_lengkap'] ?? '');
    _jenisKelaminController = TextEditingController(text: data['jenis_kelamin'] ?? '');
    _agamaController = TextEditingController(text: data['agama'] ?? '');
    _tempatLahirController = TextEditingController(text: data['tempat_lahir'] ?? '');
    _tanggalLahirController = TextEditingController(text: data['tanggal_lahir'] ?? '');
    _noHpController = TextEditingController(text: data['no_telp'] ?? '');
    _nikController = TextEditingController(text: data['nik'] ?? '');

    // Inisialisasi alamat siswa
    _dusunController = TextEditingController(text: data['dusun'] ?? '');
    _desaController = TextEditingController(text: data['desa'] ?? '');
    _kecamatanController = TextEditingController(text: data['kecamatan'] ?? '');
    _kabupatenController = TextEditingController(text: data['kabupaten'] ?? '');
    _provinsiController = TextEditingController(text: data['provinsi'] ?? '');
    _kodePosController = TextEditingController(text: data['kode_pos'] ?? '');
    _jalanController = TextEditingController(text: data['jalan'] ?? '');
    _rtRwController = TextEditingController(text: data['rt_rw'] ?? '');

    // Inisialisasi orang tua/wali
    _namaAyahController = TextEditingController(text: waliData['nama_ayah'] ?? '');
    _namaIbuController = TextEditingController(text: waliData['nama_ibu'] ?? '');
    _namaWaliController = TextEditingController(text: waliData['nama_wali'] ?? '');

    _jalanOrangTuaController = TextEditingController(text: waliData['jalan'] ?? '');
    _rtRwOrangTuaController = TextEditingController(text: waliData['rt_rw'] ?? '');
    _dusunOrangTuaController = TextEditingController(text: waliData['dusun'] ?? '');
    _desaOrangTuaController = TextEditingController(text: waliData['desa'] ?? '');
    _kecamatanOrangTuaController = TextEditingController(text: waliData['kecamatan'] ?? '');
    _kabupatenOrangTuaController = TextEditingController(text: waliData['kabupaten'] ?? '');
    _provinsiOrangTuaController = TextEditingController(text: waliData['provinsi'] ?? '');
    _kodePosOrangTuaController = TextEditingController(text: waliData['kode_pos'] ?? '');
  }

  @override
  void dispose() {
    // Dispose semua controller saat widget dihancurkan
    _nisnController.dispose();
    _namaController.dispose();
    _jenisKelaminController.dispose();
    _agamaController.dispose();
    _tempatLahirController.dispose();
    _tanggalLahirController.dispose();
    _noHpController.dispose();
    _nikController.dispose();

    _dusunController.dispose();
    _desaController.dispose();
    _kecamatanController.dispose();
    _kabupatenController.dispose();
    _provinsiController.dispose();
    _kodePosController.dispose();
    _jalanController.dispose();
    _rtRwController.dispose();

    _namaAyahController.dispose();
    _namaIbuController.dispose();
    _namaWaliController.dispose();

    _jalanOrangTuaController.dispose();
    _rtRwOrangTuaController.dispose();
    _dusunOrangTuaController.dispose();
    _desaOrangTuaController.dispose();
    _kecamatanOrangTuaController.dispose();
    _kabupatenOrangTuaController.dispose();
    _provinsiOrangTuaController.dispose();
    _kodePosOrangTuaController.dispose();

    super.dispose();
  }

  // ------------------------------
  // Helper validators
  // ------------------------------
  String? _validateRequired(String? v, String fieldName) {
    if (v == null || v.trim().isEmpty) return '$fieldName wajib diisi';
    return null;
  }

  String? _validateNISN(String? v) {
    if (v == null || v.trim().isEmpty) return 'NISN wajib diisi';
    if (v.trim().length != 10) return 'NISN harus 10 karakter';
    if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) return 'NISN harus berupa angka 10 digit';
    return null;
  }

  String? _validateNoHp(String? v) {
    if (v == null || v.trim().isEmpty) return 'No HP wajib diisi';
    final t = v.trim();
    if (!RegExp(r'^\d+$').hasMatch(t)) return 'No HP harus berupa angka';
    if (t.length < 12) return 'No HP minimal 12 digit';
    if (t.length > 15) return 'No HP maksimal 15 digit';
    return null;
  }

  String? _validateNIK(String? v) {
    if (v == null || v.trim().isEmpty) return 'NIK wajib diisi';
    final t = v.trim();
    // Umumnya NIK di Indonesia 16 digit — disesuaikan aturan
    if (!RegExp(r'^\d{16}$').hasMatch(t)) return 'NIK harus 16 digit angka';
    return null;
  }

  String? _validateRtRw(String? v) {
    if (v == null || v.trim().isEmpty) return 'RT/RW wajib diisi';
    final t = v.trim();
    // boleh format "001/002" atau hanya angka, tapi aturan diminta "menggunakan angka"
    // Accept digits and optional slash between groups: e.g. 001/002 or 1/2 or 12
    if (!RegExp(r'^\d{1,3}(\/\d{1,3})?$').hasMatch(t)) return 'RT/RW harus angka (contoh: 001/002 atau 1/2)';
    return null;
  }

  // ------------------------------
  // Simpan data (insert / update)
  // ------------------------------
  Future<void> _performSave() async {
    // Pastikan form valid sebelum memanggil fungsi ini
    // Kumpulan data siswa
    final Map<String, dynamic> siswa = {
      'nisn': _nisnController.text.trim(),
      'nama_lengkap': _namaController.text.trim(),
      'jenis_kelamin': _jenisKelaminController.text.trim(),
      'agama': _agamaController.text.trim(),
      'tempat_lahir': _tempatLahirController.text.trim(),
      'tanggal_lahir': _tanggalLahirController.text.trim(),
      'no_telp': _noHpController.text.trim(),
      'nik': _nikController.text.trim(),
      'jalan': _jalanController.text.trim(),
      'rt_rw': _rtRwController.text.trim(),
      'dusun': _dusunController.text.trim(),
      'desa': _desaController.text.trim(),
      'kecamatan': _kecamatanController.text.trim(),
      'kabupaten': _kabupatenController.text.trim(),
      'provinsi': _provinsiController.text.trim(),
      'kode_pos': _kodePosController.text.trim(),
    };

    try {
      // 1) Simpan atau update siswa, ambil id siswa hasil insert/update
      dynamic siswaResponse;
      dynamic siswaId;

      if (widget.data == null) {
        // INSERT baru
        siswaResponse = await supabase.from('siswa').insert(siswa).select('id').single();
        siswaId = siswaResponse['id'];
      } else {
        // UPDATE
        // Prefer update berdasarkan id jika tersedia di widget.data, 
        // fallback ke nisn bila id tidak ada.
        final existingId = widget.data?['id'];
        if (existingId != null) {
          await supabase.from('siswa').update(siswa).eq('id', existingId);
          siswaId = existingId;
        } else {
          // fallback: update by nisn (lama)
          await supabase.from('siswa').update(siswa).eq('nisn', _nisnController.text.trim());
          final fetch = await supabase.from('siswa').select('id').eq('nisn', _nisnController.text.trim()).single();
          siswaId = fetch['id'];
        }
      }

      // 2) Siapkan data wali (note: nama_wali optional)
      final waliData = {
        // Di desain sebelumnya, wali.id disamakan dengan siswaId (jika itu kebijakan DB)
        // Kalau tabel wali punya kolom id terpisah, logika ini bisa disesuaikan.
        // Kita simpan/ubah berdasarkan id wali yang sama dengan siswaId jika mungkin.
        'id': siswaId,
        'nama_ayah': _namaAyahController.text.trim(),
        'nama_ibu': _namaIbuController.text.trim(),
        'nama_wali': _namaWaliController.text.trim(),
        'jalan': _jalanOrangTuaController.text.trim(),
        'rt_rw': _rtRwOrangTuaController.text.trim(),
        'dusun': _dusunOrangTuaController.text.trim(),
        'desa': _desaOrangTuaController.text.trim(),
        'kecamatan': _kecamatanOrangTuaController.text.trim(),
        'kabupaten': _kabupatenOrangTuaController.text.trim(),
        'provinsi': _provinsiOrangTuaController.text.trim(),
        'kode_pos': _kodePosOrangTuaController.text.trim(),
      };

      // 3) Simpan atau update wali
      if (widget.data == null || widget.data?['wali'] == null) {
        // Insert baru
        await supabase.from('wali').insert(waliData);
      } else {
        // Update by id (siswaId)
        await supabase.from('wali').update(waliData).eq('id', siswaId);
      }

      // Notifikasi sukses
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data berhasil disimpan"),
          backgroundColor: Color.fromARGB(255, 255, 149, 149),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      // Notifikasi error
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal simpan data: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Tampilkan konfirmasi sebelum menyimpan (baru / update)
  Future<void> _confirmAndSave() async {
    // Pastikan validasi form dulu
    if (!_formKey.currentState!.validate()) {
      // Jika tidak valid, tampilkan pesan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Perbaiki form yang belum sesuai."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final isNew = widget.data == null;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(isNew ? 'Konfirmasi Simpan' : 'Konfirmasi Ubah'),
        content: Text(isNew ? 'Apakah Anda ingin menyimpan data baru?' : 'Apakah Anda ingin menyimpan perubahan data?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Batal')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Ya')),
        ],
      ),
    );

    if (result == true) {
      await _performSave();
    }
  }

  // ------------------------------
  // Date picker
  // ------------------------------
  Future<void> _pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_tanggalLahirController.text) ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _tanggalLahirController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  // ------------------------------
  // Autocomplete dusun (shared)
  // ------------------------------
  Future<List<String>> _getDusunSuggestions(String query) async {
    try {
      final List<String> dusunList = [];
      final tables = ['kec_kalipare', 'kec_kromengan', 'kec_selorejo', 'kec_sumberpucung'];

      for (var table in tables) {
        final response = await supabase
            .from(table)
            .select('dusun')
            .ilike('dusun', '%$query%')
            .limit(10);
        final data = response as List<dynamic>;
        dusunList.addAll(data.map((e) => e['dusun'] as String).toList());
      }

      return dusunList.toSet().toList();
    } catch (e) {
      // jika gagal, kembalikan list kosong
      print('Error fetching dusun suggestions: $e');
      return [];
    }
  }

  // ------------------------------
  // Ambil data dusun -> isi field alamat siswa
  // ------------------------------
  Future<void> _pilihDusun(String dusun) async {
    try {
      final tables = ['kec_kalipare', 'kec_kromengan', 'kec_selorejo', 'kec_sumberpucung'];
      List<Map<String, dynamic>> allMatches = [];

      for (var table in tables) {
        final response = await supabase
            .from(table)
            .select('dusun, desa, kecamatan, kabupaten, provinsi, kode_pos')
            .eq('dusun', dusun);
        final data = response as List<dynamic>;
        allMatches.addAll(data.map((e) => e as Map<String, dynamic>));
      }

      if (allMatches.isEmpty) {
        setState(() {
          _dusunController.text = dusun;
          _desaController.text = '';
          _kecamatanController.text = '';
          _kabupatenController.text = '';
          _provinsiController.text = '';
          _kodePosController.text = '';
        });
        return;
      }

      if (allMatches.length > 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Apakah data sudah sesuai?"),
            backgroundColor: Color.fromARGB(255, 255, 145, 145),
          ),
        );
      }

      final response = allMatches.first;

      setState(() {
        _dusunController.text = response['dusun'] ?? '';
        _desaController.text = response['desa'] ?? '';
        _kecamatanController.text = response['kecamatan'] ?? '';
        _kabupatenController.text = response['kabupaten'] ?? '';
        _provinsiController.text = response['provinsi'] ?? '';
        _kodePosController.text = response['kode_pos'] ?? '';
      });
    } catch (e) {
      print('Error fetching dusun data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal memuat data alamat: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ------------------------------
  // Ambil data dusun untuk orang tua/wali
  // ------------------------------
  Future<void> _pilihDusunOrangTua(String dusun) async {
    try {
      final tables = ['kec_kalipare', 'kec_kromengan', 'kec_selorejo', 'kec_sumberpucung'];
      List<Map<String, dynamic>> allMatches = [];

      for (var table in tables) {
        final response = await supabase
            .from(table)
            .select('dusun, desa, kecamatan, kabupaten, provinsi, kode_pos')
            .eq('dusun', dusun);
        final data = response as List<dynamic>;
        allMatches.addAll(data.map((e) => e as Map<String, dynamic>));
      }

      if (allMatches.isEmpty) {
        setState(() {
          _dusunOrangTuaController.text = dusun;
          _desaOrangTuaController.text = '';
          _kecamatanOrangTuaController.text = '';
          _kabupatenOrangTuaController.text = '';
          _provinsiOrangTuaController.text = '';
          _kodePosOrangTuaController.text = '';
        });
        return;
      }

      if (allMatches.length > 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Apakah data sudah sesuai?"),
            backgroundColor: Color.fromARGB(255, 255, 145, 145),
          ),
        );
      }

      final response = allMatches.first;

      setState(() {
        _dusunOrangTuaController.text = response['dusun'] ?? '';
        _desaOrangTuaController.text = response['desa'] ?? '';
        _kecamatanOrangTuaController.text = response['kecamatan'] ?? '';
        _kabupatenOrangTuaController.text = response['kabupaten'] ?? '';
        _provinsiOrangTuaController.text = response['provinsi'] ?? '';
        _kodePosOrangTuaController.text = response['kode_pos'] ?? '';
      });
    } catch (e) {
      print('Error fetching dusun data for orang tua: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal memuat data alamat orang tua: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ------------------------------
  // Step UI
  // ------------------------------
  List<Step> _getSteps() => [
        Step(
          title: const Text("Data Pribadi"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              // NISN dengan validasi 10 digit numeric
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _nisnController,
                  decoration: const InputDecoration(labelText: "NISN"),
                  keyboardType: TextInputType.number,
                  validator: _validateNISN,
                ),
              ),

              // Nama lengkap wajib
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: "Nama Lengkap"),
                  validator: (v) => _validateRequired(v, "Nama lengkap"),
                ),
              ),

              // Jenis Kelamin wajib dipilih
              DropdownButtonFormField<String>(
                value: _jenisKelaminController.text.isEmpty ? null : _jenisKelaminController.text,
                items: ["Laki-laki", "Perempuan"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _jenisKelaminController.text = val ?? '';
                  });
                },
                decoration: const InputDecoration(labelText: "Jenis Kelamin"),
                validator: (val) => val == null || val.isEmpty ? "Jenis Kelamin wajib dipilih" : null,
              ),

              // Agama wajib dipilih
              DropdownButtonFormField<String>(
                value: _agamaController.text.isEmpty ? null : _agamaController.text,
                items: [
                  "Islam",
                  "Kristen",
                  "Katolik",
                  "Hindu",
                  "Budha",
                  "Konghucu"
                ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) {
                  setState(() {
                    _agamaController.text = val ?? '';
                  });
                },
                decoration: const InputDecoration(labelText: "Agama"),
                validator: (val) => val == null || val.isEmpty ? "Agama wajib dipilih" : null,
              ),

              // Tempat Lahir wajib
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _tempatLahirController,
                  decoration: const InputDecoration(labelText: "Tempat Lahir"),
                  validator: (v) => _validateRequired(v, "Tempat lahir"),
                ),
              ),

              // Tanggal Lahir wajib (pakai datepicker)
              TextFormField(
                controller: _tanggalLahirController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Tanggal Lahir",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: _pilihTanggal,
                validator: (value) => value == null || value.isEmpty ? "Tanggal lahir wajib diisi" : null,
              ),

              // No HP validasi numeric 12-15
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _noHpController,
                  decoration: const InputDecoration(labelText: "No HP"),
                  keyboardType: TextInputType.phone,
                  validator: _validateNoHp,
                ),
              ),

              // NIK validasi 16 digit numeric
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _nikController,
                  decoration: const InputDecoration(labelText: "NIK"),
                  keyboardType: TextInputType.number,
                  validator: _validateNIK,
                ),
              ),
            ],
          ),
        ),
        Step(
          title: const Text("Alamat"),
          isActive: _currentStep >= 1,
          content: Column(
            children: [
              // Jalan wajib
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _jalanController,
                  decoration: const InputDecoration(labelText: "Jalan"),
                  validator: (v) => _validateRequired(v, "Jalan"),
                ),
              ),

              // RT/RW wajib numeric
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _rtRwController,
                  decoration: const InputDecoration(labelText: "RT/RW"),
                  validator: _validateRtRw,
                ),
              ),

              // Dusun (autocomplete)
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return await _getDusunSuggestions(textEditingValue.text);
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  controller.text = _dusunController.text;
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(labelText: "Dusun"),
                    validator: (value) => value == null || value.isEmpty ? "Dusun wajib diisi" : null,
                    onChanged: (value) {
                      _dusunController.text = value;
                      if (value.isEmpty) {
                        setState(() {
                          _desaController.text = '';
                          _kecamatanController.text = '';
                          _kabupatenController.text = '';
                          _provinsiController.text = '';
                          _kodePosController.text = '';
                        });
                      }
                    },
                  );
                },
                onSelected: (selection) {
                  _pilihDusun(selection);
                },
              ),

              _buildTextField("Desa", _desaController, readOnly: true),
              _buildTextField("Kecamatan", _kecamatanController, readOnly: true),
              _buildTextField("Kabupaten", _kabupatenController, readOnly: true),
              _buildTextField("Provinsi", _provinsiController, readOnly: true),
              _buildTextField("Kode Pos", _kodePosController, readOnly: true),
            ],
          ),
        ),
        Step(
          title: const Text("Orang Tua/Wali"),
          isActive: _currentStep >= 2,
          content: Column(
            children: [
              // Nama Ayah wajib
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _namaAyahController,
                  decoration: const InputDecoration(labelText: "Nama Ayah"),
                  validator: (v) => _validateRequired(v, "Nama ayah"),
                ),
              ),

              // Nama Ibu wajib
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _namaIbuController,
                  decoration: const InputDecoration(labelText: "Nama Ibu"),
                  validator: (v) => _validateRequired(v, "Nama ibu"),
                ),
              ),

              // Nama Wali optional (boleh kosong)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _namaWaliController,
                  decoration: const InputDecoration(labelText: "Nama Wali (boleh kosong)"),
                  validator: (v) {
                    // boleh kosong => null valid
                    if (v == null || v.trim().isEmpty) return null;
                    return null;
                  },
                ),
              ),

              // Alamat Orang Tua / Wali (sama structure)
              _buildTextField("Jalan Orang Tua", _jalanOrangTuaController),
              _buildTextField("RT/RW Orang Tua", _rtRwOrangTuaController, validator: _validateRtRw),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return await _getDusunSuggestions(textEditingValue.text);
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  controller.text = _dusunOrangTuaController.text;
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(labelText: "Dusun Orang Tua"),
                    validator: (value) => value == null || value.isEmpty ? "Dusun orang tua wajib diisi" : null,
                    onChanged: (value) {
                      _dusunOrangTuaController.text = value;
                      if (value.isEmpty) {
                        setState(() {
                          _desaOrangTuaController.text = '';
                          _kecamatanOrangTuaController.text = '';
                          _kabupatenOrangTuaController.text = '';
                          _provinsiOrangTuaController.text = '';
                          _kodePosOrangTuaController.text = '';
                        });
                      }
                    },
                  );
                },
                onSelected: (selection) {
                  _pilihDusunOrangTua(selection);
                },
              ),
              _buildTextField("Desa Orang Tua", _desaOrangTuaController, readOnly: true),
              _buildTextField("Kecamatan Orang Tua", _kecamatanOrangTuaController, readOnly: true),
              _buildTextField("Kabupaten Orang Tua", _kabupatenOrangTuaController, readOnly: true),
              _buildTextField("Provinsi Orang Tua", _provinsiOrangTuaController, readOnly: true),
              _buildTextField("Kode Pos Orang Tua", _kodePosOrangTuaController, readOnly: true),
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9C4), // Kuning pastel (tetap sama)
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 164, 174), // Pink pastel
        title: const Text("Form Data Siswa"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color.fromARGB(255, 255, 164, 174), // Pink pastel for step numbers
                ),
          ),
          child: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            steps: _getSteps(),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: <Widget>[
                  if (_currentStep < _getSteps().length - 1)
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 164, 174), // Pink pastel
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Continue'),
                    ),
                  if (_currentStep == _getSteps().length - 1)
                    ElevatedButton(
                      // Di sini kita panggil konfirmasi sebelum benar-benar menyimpan
                      onPressed: () => _confirmAndSave(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 164, 174),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Simpan'),
                    ),
                  const SizedBox(width: 8),
                  if (_currentStep > 0)
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Cancel'),
                    ),
                ],
              );
            },
            onStepContinue: () {
              // simple navigation step
              if (_currentStep < _getSteps().length - 1) {
                setState(() => _currentStep += 1);
              } else {
                // final step handled by controlsBuilder -> Simpan via _confirmAndSave
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() => _currentStep -= 1);
              }
            },
          ),
        ),
      ),
    );
  }

  // Utility builder untuk textfield sederhana (dengan opsi readOnly dan custom validator)
  Widget _buildTextField(String label, TextEditingController controller, {bool readOnly = false, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(labelText: label),
        validator: validator ?? (value) => value == null || value.isEmpty ? "Wajib diisi" : null,
      ),
    );
  }
}
