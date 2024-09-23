import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DynamicFormPage(),
    );
  }
}

class DynamicFormPage extends StatefulWidget {
  @override
  _DynamicFormPageState createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicFormPage> {
  String _selectedJobStatus = 'Bekerja';
  String? _selectedFaculty;
  String? _selectedProdi;
  String? _selectedWaitingTime;
  String? _selectedSalary;

  // Fakultas and Prodi data
  final Map<String, List<String>> facultyProdiMap = {
    'Fakultas Ekonomi': ['Manajemen', 'Akuntansi', 'Perbankan Syariah'],
    'Fakultas Sains dan Teknologi': [
      'Teknik Arsitektur',
      'Teknik Informatika',
      'Fisika',
      'Kimia',
      'Biologi',
      'Matematika',
      'Perpustakaan dan Ilmu Informasi'
    ],
    'Fakultas Syariah': [
      'Hukum Tata Negara',
      'Hukum Keluarga Islam',
      'Hukum Ekonomi Syariah',
      'Ilmu Alquran dan Tafsir'
    ],
    'Fakultas Kedokteran dan Ilmu Kesehatan': ['Pendidikan Dokter', 'Farmasi'],
    'Fakultas Psikologi': ['Psikologi'],
    'Fakultas Humaniora': ['Bahasa dan Sastra Arab', 'Sastra Inggris'],
    'Fakultas Ilmu Tarbiyah dan Keguruan': [
      'Pendidikan Agama Islam',
      'Pendidikan IPS',
      'Pendidikan PGMI',
      'Pendidikan Bahasa Arab',
      'Pendidikan PIAUD',
      'Manajemen Pendidikan Islam',
      'Tadris Bahasa Inggris',
      'Tadris Matematika'
    ],
  };

  List<String> _prodiList = [];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CDC UIN MALANG'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // General Information Fields
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'NIM'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nomor Telepon/HP'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alamat Email'),
              ),

              // Fakultas Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Fakultas'),
                value: _selectedFaculty,
                items: facultyProdiMap.keys
                    .map((faculty) => DropdownMenuItem(
                          value: faculty,
                          child: Text(faculty),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFaculty = value;
                    _prodiList = facultyProdiMap[_selectedFaculty] ?? [];
                    _selectedProdi =
                        null; // Reset the Prodi when Fakultas changes
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a Fakultas' : null,
              ),

              // Prodi Dropdown (dependent on Fakultas)
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Prodi'),
                value: _selectedProdi,
                items: _prodiList
                    .map((prodi) => DropdownMenuItem(
                          value: prodi,
                          child: Text(prodi),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProdi = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a Prodi' : null,
              ),

              // Job Status Radio Buttons
              Text('Jelaskan status Anda saat ini'),
              Column(
                children: [
                  RadioListTile<String>(
                    title: Text('Bekerja (full time/part time)'),
                    value: 'Bekerja',
                    groupValue: _selectedJobStatus,
                    onChanged: (value) {
                      setState(() {
                        _selectedJobStatus = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Wiraswasta'),
                    value: 'Wiraswasta',
                    groupValue: _selectedJobStatus,
                    onChanged: (value) {
                      setState(() {
                        _selectedJobStatus = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Melanjutkan pendidikan'),
                    value: 'Pendidikan',
                    groupValue: _selectedJobStatus,
                    onChanged: (value) {
                      setState(() {
                        _selectedJobStatus = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Tidak kerja tetapi sedang mencari kerja'),
                    value: 'Mencari Kerja',
                    groupValue: _selectedJobStatus,
                    onChanged: (value) {
                      setState(() {
                        _selectedJobStatus = value!;
                      });
                    },
                  ),
                ],
              ),

              // Dynamic Forms based on job status
              if (_selectedJobStatus == 'Bekerja') ..._buildWorkingFields(),
              if (_selectedJobStatus == 'Wiraswasta')
                ..._buildEntrepreneurFields(),
              if (_selectedJobStatus == 'Pendidikan')
                ..._buildEducationFields(),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form submission logic
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWorkingFields() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Nama Instansi/Perusahaan'),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Alamat Instansi'),
      ),
      SizedBox(height: 20),

      // Waiting Time Radio Buttons
      Text('Berapa lama waktu tunggu untuk mendapatkan pekerjaan pertama?'),
      Column(
        children: [
          RadioListTile<String>(
            title: Text('Kira-kira 3 bulan setelah lulus'),
            value: '3_bulan',
            groupValue: _selectedWaitingTime,
            onChanged: (value) {
              setState(() {
                _selectedWaitingTime = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Kira-kira 3-6 bulan setelah lulus'),
            value: '3_6_bulan',
            groupValue: _selectedWaitingTime,
            onChanged: (value) {
              setState(() {
                _selectedWaitingTime = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Kira-kira lebih dari 12 bulan setelah lulus'),
            value: 'lebih_12_bulan',
            groupValue: _selectedWaitingTime,
            onChanged: (value) {
              setState(() {
                _selectedWaitingTime = value!;
              });
            },
          ),
        ],
      ),

      // Salary Radio Buttons
      Text('Berapa rata-rata pendapatan per bulan (take home pay)?'),
      Column(
        children: [
          RadioListTile<String>(
            title: Text('Rp. 0 – 2.150.000,00'),
            value: '0_2_million',
            groupValue: _selectedSalary,
            onChanged: (value) {
              setState(() {
                _selectedSalary = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Rp. 2.150.000,00 – 3.450.000,00'),
            value: '2_3_million',
            groupValue: _selectedSalary,
            onChanged: (value) {
              setState(() {
                _selectedSalary = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('> Rp. 10.000.000,00'),
            value: '10_million',
            groupValue: _selectedSalary,
            onChanged: (value) {
              setState(() {
                _selectedSalary = value!;
              });
            },
          ),
        ],
      ),
    ];
  }
}

List<Widget> _buildEntrepreneurFields() {
  return [
    TextFormField(
      decoration: InputDecoration(labelText: 'Nama Usaha'),
    ),
    TextFormField(
      decoration: InputDecoration(labelText: 'Alamat Usaha'),
    ),
  ];
}

List<Widget> _buildEducationFields() {
  return [
    TextFormField(
      decoration: InputDecoration(labelText: 'Institusi Pendidikan'),
    ),
    TextFormField(
      decoration: InputDecoration(labelText: 'Program Studi Lanjutan'),
    ),
  ];
}
