import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azdana Hasfi Nabilah',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Azdana Hasfi Nabilah'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imageFile == null
                  ? Image.asset(
                      'assets/owner1.jpeg',  
                      width: 150,
                      height: 150,
                    )
                  : Image.file(
                      _imageFile!,
                      width: 150,
                      height: 150,
                    ),
              SizedBox(height: 16.0),
              Text(
                'Profil Azdana Hasfi Nabilah',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Nama: Azdana Hasfi Nabilah',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Tempat, Tanggal Lahir: Mojokerto, 07 Juli 2004',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Alamat: Desa Tangunan, RT.10, RW.05, Puri Mojokerto',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'No.HP: 085806361803',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Email: 22082010076@students.student.upnjatim.ac.id',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'GitHub: Github.github.com/azdana07',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Pendidikan: Mahasiswa S1 Sistem Informasi',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'UPN VETERAN JAWA TIMUR',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}