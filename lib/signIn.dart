import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class formField extends StatefulWidget {
  const formField({super.key});

  @override
  State<formField> createState() => _formFieldState();
}

class _formFieldState extends State<formField> {
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dateController.text = '${pickedDate.toLocal()}'
            .split(' ')[0]; // Format tanggal YYYY-MM-DD
      });
    }
  }

  String? _selectedNationality;
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Lengkapi Identitas Diri',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Agar Anda dapat terhubung dengan semua fasilitas kesehatan yang pernah dikunjungi',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Text("Email *"),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan Email",
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Nomor Telepon *"),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan Nomor Telepon(+62)",
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Kewarganegaraan *"),
                      ],
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Pilih Kewarganegaraan",
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                      value: _selectedNationality, // Nilai yang dipilih
                      items: <String>[
                        'Indonesia',
                        'Asing',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedNationality = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih kewarganegaraan Anda';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Nama Lengkap *"),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "*Nama harus sesuai dengan KTP",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan nama lengkap",
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Tanggal Lahir *"),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _dateController,
                      readOnly:
                          true, // Menandakan bahwa pengguna tidak bisa mengetik langsung
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan tanggal lahir",
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("NIK *"),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan NIK sesuai KTP",
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Jenis Kelamin *"),
                      ],
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Pilih Jenis Kelamin",
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                      value: _selectedGender, // Nilai yang dipilih
                      items: <String>[
                        'Laki-laki',
                        'Perempuan',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih jenis kelamin Anda';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.blue,
                          ),
                          minimumSize: WidgetStatePropertyAll(Size(500, 50)),
                        ),
                        child: Text("Daftar",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          ;
                        }),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
