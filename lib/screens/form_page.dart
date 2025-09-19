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

  // Controllers: Data Pribadi
  late TextEditingController _nisnController;
  late TextEditingController _namaController;
  late TextEditingController _jenisKelaminController;
  late TextEditingController _agamaController;
  late TextEditingController _tempatLahirController;
  late TextEditingController _tanggalLahirController;
  late TextEditingController _noHpController;
  late TextEditingController _nikController;

  // Controllers: Alamat Siswa
  late TextEditingController _dusunController;
  late TextEditingController _desaController;
  late TextEditingController _kecamatanController;
  late TextEditingController _kabupatenController;
  late TextEditingController _provinsiController;
  late TextEditingController _kodePosController;
  late TextEditingController _jalanController;
  late TextEditingController _rtRwController;

  // Controllers: Orang Tua / Wali
  late TextEditingController _namaAyahController;
  late TextEditingController _namaIbuController;
  late TextEditingController _namaWaliController;
  late TextEditingController _jalanOrangTuaController;
  late TextEditingController _rtRwOrangTuaController;
  late TextEditingController _dusunOrangTuaController;
  late TextEditingController _desaOrangTuaController;
  late TextEditingController _kecamatanOrangTuaController;
  late TextEditingController _kabupatenOrangTuaController;
  late TextEditingController _provinsiOrangTuaController;
  late TextEditingController _kodePosOrangTuaController;

  @override
  void initState() {
    super.initState();

    final data = widget.data ?? {};
    final waliData = data['wali'] ?? {};

    _nisnController = TextEditingController(text: data['nisn'] ?? '');
    _namaController = TextEditingController(text: data['nama_lengkap'] ?? '');
    _jenisKelaminController = TextEditingController(text: data['jenis_kelamin'] ?? '');
    _agamaController = TextEditingController(text: data['agama'] ?? '');
    _tempatLahirController = TextEditingController(text: data['tempat_lahir'] ?? '');
    _tanggalLahirController = TextEditingController(text: data['tanggal_lahir'] ?? '');
    _noHpController = TextEditingController(text: data['no_telp'] ?? '');
    _nikController = TextEditingController(text: data['nik'] ?? '');

    _dusunController = TextEditingController(text: data['dusun'] ?? '');
    _desaController = TextEditingController(text: data['desa'] ?? '');
    _kecamatanController = TextEditingController(text: data['kecamatan'] ?? '');
    _kabupatenController = TextEditingController(text: data['kabupaten'] ?? '');
    _provinsiController = TextEditingController(text: data['provinsi'] ?? '');
    _kodePosController = TextEditingController(text: data['kode_pos'] ?? '');
    _jalanController = TextEditingController(text: data['jalan'] ?? '');
    _rtRwController = TextEditingController(text: data['rt_rw'] ?? '');

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
    if (!RegExp(r'^\d{16}$').hasMatch(t)) return 'NIK harus 16 digit angka';
    return null;
  }

  String? _validateRtRw(String? v) {
    if (v == null || v.trim().isEmpty) return 'RT/RW wajib diisi';
    final t = v.trim();
    if (!RegExp(r'^\d{1,3}(\/\d{1,3})?$').hasMatch(t)) return 'RT/RW harus angka (contoh: 001/002 atau 1/2)';
    return null;
  }

  Future<int?> _getExistingAlamatMasterId(Map<String, dynamic> addressData) async {
    final kecamatanKeys = [
      'kecamatan_sumberpucung_id',
      'kecamatan_kalipare_id',
      'kecamatan_selorejo_id',
      'kecamatan_kromengan_id'
    ];
    for (var key in kecamatanKeys) {
      if (addressData.containsKey(key) && addressData[key] != null) {
        print('Checking alamat_master for $key: ${addressData[key]}');
        final response = await supabase
            .from('alamat_master')
            .select('id')
            .eq(key, addressData[key])
            .limit(1)
            .maybeSingle();
        print('Response from alamat_master check: $response');
        if (response != null && response['id'] != null) {
          return response['id'] as int;
        }
      }
    }
    return null;
  }

  Future<void> _performSave() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Perbaiki form yang belum sesuai."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Validasi kecamatan
      if (_kecamatanController.text.isEmpty) {
        throw Exception('Kecamatan siswa tidak boleh kosong');
      }
      if (_kecamatanOrangTuaController.text.isEmpty) {
        throw Exception('Kecamatan orang tua tidak boleh kosong');
      }

      // Prepare student address
      Map<String, dynamic> siswaAddress = {};
      print('Preparing siswa address for kecamatan: ${_kecamatanController.text}');
      switch (_kecamatanController.text) {
        case 'Sumberpucung':
          final response = await supabase
              .from('kec_sumberpucung')
              .select('id')
              .eq('kecamatan', 'Sumberpucung')
              .limit(1)
              .single();
          print('kec_sumberpucung response: $response');
          siswaAddress['kecamatan_sumberpucung_id'] = response['id'];
          break;
        case 'Kalipare':
          final response = await supabase
              .from('kec_kalipare')
              .select('id')
              .eq('kecamatan', 'Kalipare')
              .limit(1)
              .single();
          print('kec_kalipare response: $response');
          siswaAddress['kecamatan_kalipare_id'] = response['id'];
          break;
        case 'Selorejo':
          final response = await supabase
              .from('kec_selorejo')
              .select('id')
              .eq('kecamatan', 'Selorejo')
              .limit(1)
              .single();
          print('kec_selorejo response: $response');
          siswaAddress['kecamatan_selorejo_id'] = response['id'];
          break;
        case 'Kromengan':
          final response = await supabase
              .from('kec_kromengan')
              .select('id')
              .eq('kecamatan', 'Kromengan')
              .limit(1)
              .single();
          print('kec_kromengan response: $response');
          siswaAddress['kecamatan_kromengan_id'] = response['id'];
          break;
        default:
          throw Exception('Kecamatan tidak valid: ${_kecamatanController.text}');
      }

      // Remove 'id' from siswaAddress to avoid PostgrestException
      final cleanSiswaAddress = Map<String, dynamic>.from(siswaAddress)..remove('id');
      print('Inserting/Updating alamat_master for siswa: $cleanSiswaAddress');

      // Check for existing alamat_master record
      int? alamatMasterId;
      if (widget.data?['alamat_master_id'] != null) {
        alamatMasterId = widget.data!['alamat_master_id'] as int;
        print('Updating alamat_master for siswa with ID: $alamatMasterId');
        await supabase.from('alamat_master').update(cleanSiswaAddress).eq('id', alamatMasterId);
      } else {
        alamatMasterId = await _getExistingAlamatMasterId(cleanSiswaAddress);
        print('Existing alamat_master_id: $alamatMasterId');
        if (alamatMasterId == null) {
          print('Inserting new alamat_master for siswa');
          final alamatMasterResponse = await supabase
              .from('alamat_master')
              .insert(cleanSiswaAddress)
              .select('id')
              .single();
          print('alamat_master insert response: $alamatMasterResponse');
          if (alamatMasterResponse['id'] == null) {
            throw Exception('Gagal mendapatkan ID dari alamat_master untuk siswa');
          }
          alamatMasterId = alamatMasterResponse['id'] as int;
        }
      }

      // Prepare student data
      final siswa = {
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
        'alamat_master_id': alamatMasterId,
        'wali_id': null, // Temporary placeholder
      };
      print('Siswa data: $siswa');

      dynamic siswaId;
      if (widget.data == null) {
        print('Inserting new siswa');
        final siswaResponse = await supabase.from('siswa').insert(siswa).select('id').single();
        print('siswa insert response: $siswaResponse');
        if (siswaResponse['id'] == null) {
          throw Exception('Gagal mendapatkan ID dari siswa');
        }
        siswaId = siswaResponse['id'];
      } else {
        final existingId = widget.data?['id'];
        if (existingId != null) {
          print('Updating siswa with ID: $existingId');
          await supabase.from('siswa').update(siswa).eq('id', existingId);
          siswaId = existingId;
        } else {
          throw Exception('ID siswa tidak ditemukan untuk pembaruan');
        }
      }

      // Prepare guardian address
      Map<String, dynamic> waliAddress = {};
      print('Preparing wali address for kecamatan: ${_kecamatanOrangTuaController.text}');
      switch (_kecamatanOrangTuaController.text) {
        case 'Sumberpucung':
          final response = await supabase
              .from('kec_sumberpucung')
              .select('id')
              .eq('kecamatan', 'Sumberpucung')
              .limit(1)
              .single();
          print('kec_sumberpucung response for wali: $response');
          waliAddress['kecamatan_sumberpucung_id'] = response['id'];
          break;
        case 'Kalipare':
          final response = await supabase
              .from('kec_kalipare')
              .select('id')
              .eq('kecamatan', 'Kalipare')
              .limit(1)
              .single();
          print('kec_kalipare response for wali: $response');
          waliAddress['kecamatan_kalipare_id'] = response['id'];
          break;
        case 'Selorejo':
          final response = await supabase
              .from('kec_selorejo')
              .select('id')
              .eq('kecamatan', 'Selorejo')
              .limit(1)
              .single();
          print('kec_selorejo response for wali: $response');
          waliAddress['kecamatan_selorejo_id'] = response['id'];
          break;
        case 'Kromengan':
          final response = await supabase
              .from('kec_kromengan')
              .select('id')
              .eq('kecamatan', 'Kromengan')
              .limit(1)
              .single();
          print('kec_kromengan response for wali: $response');
          waliAddress['kecamatan_kromengan_id'] = response['id'];
          break;
        default:
          throw Exception('Kecamatan orang tua tidak valid: ${_kecamatanOrangTuaController.text}');
      }

      // Remove 'id' from waliAddress to avoid PostgrestException
      final cleanWaliAddress = Map<String, dynamic>.from(waliAddress)..remove('id');
      print('Inserting/Updating alamat_master for wali: $cleanWaliAddress');

      // Check for existing alamat_master record for wali
      int? alamatWaliId;
      if (widget.data?['wali']?['alamat_id'] != null) {
        alamatWaliId = widget.data!['wali']['alamat_id'] as int;
        print('Updating alamat_master for wali with ID: $alamatWaliId');
        await supabase.from('alamat_master').update(cleanWaliAddress).eq('id', alamatWaliId);
      } else {
        alamatWaliId = await _getExistingAlamatMasterId(cleanWaliAddress);
        print('Existing alamat_wali_id: $alamatWaliId');
        if (alamatWaliId == null) {
          print('Inserting new alamat_master for wali');
          final alamatWaliResponse = await supabase
              .from('alamat_master')
              .insert(cleanWaliAddress)
              .select('id')
              .single();
          print('alamat_master insert response for wali: $alamatWaliResponse');
          if (alamatWaliResponse['id'] == null) {
            throw Exception('Gagal mendapatkan ID dari alamat_master untuk wali');
          }
          alamatWaliId = alamatWaliResponse['id'] as int;
        }
      }

      // Prepare guardian data
      final waliData = {
        'nama_ayah': _namaAyahController.text.trim(),
        'nama_ibu': _namaIbuController.text.trim(),
        'nama_wali': _namaWaliController.text.trim(),
        'alamat_id': alamatWaliId,
        'jalan': _jalanOrangTuaController.text.trim(),
        'rt_rw': _rtRwOrangTuaController.text.trim(),
        'dusun': _dusunOrangTuaController.text.trim(),
        'desa': _desaOrangTuaController.text.trim(),
        'kecamatan': _kecamatanOrangTuaController.text.trim(),
        'kabupaten': _kabupatenOrangTuaController.text.trim(),
        'provinsi': _provinsiOrangTuaController.text.trim(),
        'kode_pos': _kodePosOrangTuaController.text.trim(),
      };

      // Remove 'id' from waliData to avoid PostgrestException
      final cleanWaliData = Map<String, dynamic>.from(waliData)..remove('id');
      print('Wali data: $cleanWaliData');

      dynamic waliId;
      if (widget.data == null || widget.data?['wali'] == null) {
        print('Inserting new wali');
        final waliResponse = await supabase.from('wali').insert(cleanWaliData).select('id').single();
        print('wali insert response: $waliResponse');
        if (waliResponse['id'] == null) {
          throw Exception('Gagal mendapatkan ID dari wali');
        }
        waliId = waliResponse['id'];
      } else {
        final existingWaliId = widget.data?['wali']['id'];
        if (existingWaliId != null) {
          print('Updating wali with ID: $existingWaliId');
          await supabase.from('wali').update(cleanWaliData).eq('id', existingWaliId);
          waliId = existingWaliId;
        } else {
          print('Inserting new wali (existing wali data but no ID)');
          final waliResponse = await supabase.from('wali').insert(cleanWaliData).select('id').single();
          print('wali insert response: $waliResponse');
          if (waliResponse['id'] == null) {
            throw Exception('Gagal mendapatkan ID dari wali');
          }
          waliId = waliResponse['id'];
        }
      }

      // Update siswa with wali_id
      print('Updating siswa with wali_id: $waliId');
      await supabase.from('siswa').update({'wali_id': waliId}).eq('id', siswaId);
      print('Siswa wali_id update completed');

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data berhasil disimpan"),
          backgroundColor: Color.fromARGB(255, 255, 169, 169),
        ),
      );
      print('Navigating back with success');
      Navigator.pop(context, true);
    } catch (e) {
      print('Error in _performSave: $e');
      if (!mounted) return;
      String errorMessage = "Gagal simpan data: $e";
      if (e is PostgrestException) {
        errorMessage = "Gagal simpan data: ${e.message} (code: ${e.code})";
        if (e.code == 'PGRST116') {
          errorMessage = "Gagal simpan data: Query mengembalikan terlalu banyak baris. Hubungi admin untuk memeriksa data kecamatan.";
        } else if (e.code == '428C9') {
          errorMessage = "Gagal simpan data: Kolom ID tidak dapat diset secara manual.";
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _confirmAndSave() async {
    if (!_formKey.currentState!.validate()) {
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
        print('Dusun suggestions from $table: $response');
        final data = response as List<dynamic>;
        dusunList.addAll(data.map((e) => e['dusun'] as String).toList());
      }
      return dusunList.toSet().toList();
    } catch (e) {
      print('Error fetching dusun suggestions: $e');
      return [];
    }
  }

  Future<void> _pilihDusun(String dusun) async {
    try {
      final tables = ['kec_kalipare', 'kec_kromengan', 'kec_selorejo', 'kec_sumberpucung'];
      List<Map<String, dynamic>> allMatches = [];
      for (var table in tables) {
        final response = await supabase
            .from(table)
            .select('dusun, desa, kecamatan, kabupaten, provinsi, kode_pos')
            .eq('dusun', dusun);
        print('Dusun data from $table: $response');
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

  Future<void> _pilihDusunOrangTua(String dusun) async {
    try {
      final tables = ['kec_kalipare', 'kec_kromengan', 'kec_selorejo', 'kec_sumberpucung'];
      List<Map<String, dynamic>> allMatches = [];
      for (var table in tables) {
        final response = await supabase
            .from(table)
            .select('dusun, desa, kecamatan, kabupaten, provinsi, kode_pos')
            .eq('dusun', dusun);
        print('Dusun data for orang tua from $table: $response');
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

  List<Step> _getSteps() => [
        Step(
          title: const Text("Data Pribadi"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _nisnController,
                  decoration: const InputDecoration(labelText: "NISN"),
                  keyboardType: TextInputType.number,
                  validator: _validateNISN,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: "Nama Lengkap"),
                  validator: (v) => _validateRequired(v, "Nama lengkap"),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _jenisKelaminController.text.isEmpty ? null : _jenisKelaminController.text,
                items: ["Laki-laki", "Perempuan"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _jenisKelaminController.text = val ?? ''),
                decoration: const InputDecoration(labelText: "Jenis Kelamin"),
                validator: (val) => val == null || val.isEmpty ? "Jenis Kelamin wajib dipilih" : null,
              ),
              DropdownButtonFormField<String>(
                value: _agamaController.text.isEmpty ? null : _agamaController.text,
                items: ["Islam", "Kristen", "Katolik", "Hindu", "Budha", "Konghucu"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _agamaController.text = val ?? ''),
                decoration: const InputDecoration(labelText: "Agama"),
                validator: (val) => val == null || val.isEmpty ? "Agama wajib dipilih" : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _tempatLahirController,
                  decoration: const InputDecoration(labelText: "Tempat Lahir"),
                  validator: (v) => _validateRequired(v, "Tempat lahir"),
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _noHpController,
                  decoration: const InputDecoration(labelText: "No HP"),
                  keyboardType: TextInputType.phone,
                  validator: _validateNoHp,
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _jalanController,
                  decoration: const InputDecoration(labelText: "Jalan"),
                  validator: (v) => _validateRequired(v, "Jalan"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _rtRwController,
                  decoration: const InputDecoration(labelText: "RT/RW"),
                  validator: _validateRtRw,
                ),
              ),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();
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
                onSelected: (selection) => _pilihDusun(selection),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _namaAyahController,
                  decoration: const InputDecoration(labelText: "Nama Ayah"),
                  validator: (v) => _validateRequired(v, "Nama ayah"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _namaIbuController,
                  decoration: const InputDecoration(labelText: "Nama Ibu"),
                  validator: (v) => _validateRequired(v, "Nama ibu"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _namaWaliController,
                  decoration: const InputDecoration(labelText: "Nama Wali (boleh kosong)"),
                ),
              ),
              _buildTextField("Jalan Orang Tua", _jalanOrangTuaController, validator: (v) => _validateRequired(v, "Jalan orang tua")),
              _buildTextField("RT/RW Orang Tua", _rtRwOrangTuaController, validator: _validateRtRw),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();
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
                onSelected: (selection) => _pilihDusunOrangTua(selection),
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
      backgroundColor: const Color(0xFFFFF9C4),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 164, 174),
        title: const Text("Form Data Siswa"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color.fromARGB(255, 255, 164, 174),
                ),
          ),
          child: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            steps: _getSteps(),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: [
                  if (_currentStep < _getSteps().length - 1)
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 164, 174),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Continue'),
                    ),
                  if (_currentStep == _getSteps().length - 1)
                    ElevatedButton(
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
              if (_currentStep < _getSteps().length - 1) {
                setState(() => _currentStep += 1);
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

  Widget _buildTextField(String label, TextEditingController controller,
      {bool readOnly = false, String? Function(String?)? validator}) {
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
