import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//halaman edit data siswa
class Editpage extends StatefulWidget {
  final Map<String, dynamic>? data; //data suasawa yang akan di edit (jika ada)
  const Editpage({super.key, this.data});

  @override
  State<Editpage> createState() => _FormSiswaPageState();
}

//state untuk halaman Editpage
class _FormSiswaPageState extends State<Editpage> {
  final _formKey = GlobalKey<FormState>();// key untuk validasi form
  final supabase = Supabase.instance.client; //inisialisasi supabase client

  int _currentStep = 0; //step saat ini pada stepper

  // deklarasi controller untuk setiap field input
  late TextEditingController _nisnController;
  late TextEditingController _namaController;
  late TextEditingController _jenisKelaminController;
  late TextEditingController _agamaController;
  late TextEditingController _tempatLahirController;
  late TextEditingController _tanggalLahirController;
  late TextEditingController _noHpController;
  late TextEditingController _nikController;

//alamat siswa
  late TextEditingController _dusunController;
  late TextEditingController _desaController;
  late TextEditingController _kecamatanController;
  late TextEditingController _kabupatenController;
  late TextEditingController _provinsiController;
  late TextEditingController _kodePosController;
  late TextEditingController _jalanController;
  late TextEditingController _rtRwController;

//data orang tua/wali
  late TextEditingController _namaAyahController;
  late TextEditingController _namaIbuController;
  late TextEditingController _namaWaliController;

//alamat orang tua
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
    final data = widget.data ?? {};// ambil data siswa, jika null isi {} kosong
    final waliData = data['wali'] ?? {}; //ambil data wali dari siswa

    // Inisialisasi controller dengan data siswa (jika ada)
    _nisnController = TextEditingController(text: data['nisn'] ?? '');
    _namaController = TextEditingController(text: data['nama_lengkap'] ?? '');
    _jenisKelaminController =
        TextEditingController(text: data['jenis_kelamin'] ?? '');
    _agamaController = TextEditingController(text: data['agama'] ?? '');
    _tempatLahirController =
        TextEditingController(text: data['tempat_lahir'] ?? '');
    _tanggalLahirController =
        TextEditingController(text: data['tanggal_lahir'] ?? '');
    _noHpController = TextEditingController(text: data['no_telp'] ?? '');
    _nikController = TextEditingController(text: data['nik'] ?? '');

    // Alamat Siswa
    _dusunController = TextEditingController(text: data['dusun'] ?? '');
    _desaController = TextEditingController(text: data['desa'] ?? '');
    _kecamatanController = TextEditingController(text: data['kecamatan'] ?? '');
    _kabupatenController = TextEditingController(text: data['kabupaten'] ?? '');
    _provinsiController = TextEditingController(text: data['provinsi'] ?? '');
    _kodePosController = TextEditingController(text: data['kode_pos'] ?? '');
    _jalanController = TextEditingController(text: data['jalan'] ?? '');
    _rtRwController = TextEditingController(text: data['rt_rw'] ?? '');

    // Orang Tua / Wali
    _namaAyahController = TextEditingController(text: waliData['nama_ayah'] ?? '');
    _namaIbuController = TextEditingController(text: waliData['nama_ibu'] ?? '');
    _namaWaliController = TextEditingController(text: waliData['nama_wali'] ?? '');

    _jalanOrangTuaController = TextEditingController(text: waliData['jalan'] ?? '');
    _rtRwOrangTuaController = TextEditingController(text: waliData['rt_rw'] ?? '');
    _dusunOrangTuaController = TextEditingController(text: waliData['dusun'] ?? '');
    _desaOrangTuaController = TextEditingController(text: waliData['desa'] ?? '');
    _kecamatanOrangTuaController =
        TextEditingController(text: waliData['kecamatan'] ?? '');
    _kabupatenOrangTuaController =
        TextEditingController(text: waliData['kabupaten'] ?? '');
    _provinsiOrangTuaController =
        TextEditingController(text: waliData['provinsi'] ?? '');
    _kodePosOrangTuaController =
        TextEditingController(text: waliData['kode_pos'] ?? '');
  }

  @override
  void dispose() {
    for (var c in [
      _nisnController,
      _namaController,
      _jenisKelaminController,
      _agamaController,
      _tempatLahirController,
      _tanggalLahirController,
      _noHpController,
      _nikController,
      _dusunController,
      _desaController,
      _kecamatanController,
      _kabupatenController,
      _provinsiController,
      _kodePosController,
      _jalanController,
      _rtRwController,
      _namaAyahController,
      _namaIbuController,
      _namaWaliController,
      _dusunOrangTuaController,
      _desaOrangTuaController,
      _kecamatanOrangTuaController,
      _kabupatenOrangTuaController,
      _provinsiOrangTuaController,
      _kodePosOrangTuaController,
      _jalanOrangTuaController,
      _rtRwOrangTuaController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.pinkAccent),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  List<Step> _getSteps() => [
        Step(
          title: const Text("Data Pribadi"),
          content: Column(children: [
            _buildTextField("NISN", _nisnController),
            _buildTextField("Nama Lengkap", _namaController),
            _buildTextField("Jenis Kelamin", _jenisKelaminController),
            _buildTextField("Agama", _agamaController),
            _buildTextField("Tempat Lahir", _tempatLahirController),
            _buildTextField("Tanggal Lahir", _tanggalLahirController),
            _buildTextField("No HP", _noHpController),
            _buildTextField("NIK", _nikController),
          ]),
        ),
        Step(
          title: const Text("Alamat"),
          content: Column(children: [
            _buildTextField("Jalan", _jalanController),
            _buildTextField("RT/RW", _rtRwController),
            _buildTextField("Dusun", _dusunController),
            _buildTextField("Desa", _desaController, readOnly: true),
            _buildTextField("Kecamatan", _kecamatanController, readOnly: true),
            _buildTextField("Kabupaten", _kabupatenController, readOnly: true),
            _buildTextField("Provinsi", _provinsiController, readOnly: true),
            _buildTextField("Kode Pos", _kodePosController, readOnly: true),
          ]),
        ),
        Step(
          title: const Text("Orang Tua/Wali"),
          content: Column(children: [
            _buildTextField("Nama Ayah", _namaAyahController),
            _buildTextField("Nama Ibu", _namaIbuController),
            _buildTextField("Nama Wali", _namaWaliController),
            _buildTextField("Jalan", _jalanOrangTuaController),
            _buildTextField("RT/RW", _rtRwOrangTuaController),
            _buildTextField("Dusun", _dusunOrangTuaController),
            _buildTextField("Desa", _desaOrangTuaController, readOnly: true),
            _buildTextField("Kecamatan", _kecamatanOrangTuaController, readOnly: true),
            _buildTextField("Kabupaten", _kabupatenOrangTuaController, readOnly: true),
            _buildTextField("Provinsi", _provinsiOrangTuaController, readOnly: true),
            _buildTextField("Kode Pos", _kodePosOrangTuaController, readOnly: true),
          ]),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data Siswa"),
        backgroundColor: Colors.yellow.shade200,
        foregroundColor: Colors.pink.shade200,
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,//step aktif
          steps: _getSteps(),//daftar step
          type: StepperType.vertical,//tipe stepper
          controlsBuilder: (context, details) {
            return Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade200,
                  ),
                  onPressed: details.onStepContinue,//tombol lanjut/simpan
                  child: const Text("Lanjut / Simpan"),
                ),
                const SizedBox(width: 12),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.yellow.shade700,
                  ),
                  onPressed: details.onStepCancel,//tombol kembali
                  child: const Text("Kembali"),
                ),
              ],
            );
          },
          onStepContinue: () {
            if (_currentStep < _getSteps().length - 1) {
              setState(() => _currentStep++);//lanjut ke step berikutnya
            } else {
              _confirmAndSave();//simpan data
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);//kembali ke step sebelumnya
            }
          },
        ),
      ),
    );
  }

//fungsi untuk konfirmasi dan simpan data
  void _confirmAndSave() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Data berhasil disimpan!'),
          backgroundColor: const Color.fromARGB(255, 255, 157, 157),//warna snackbar
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
