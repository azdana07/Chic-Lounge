import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intan Firdausi',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Intan Firdausi'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/owner2.jpeg'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Intan Firdausi',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Nama: Intan Firdausi',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Tempat, Tanggal Lahir: Gresik, 04 Maret 2004',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Alamat: Desa Genengan, RT.10, RW.01, Balongpanggang Gresik',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'No.HP: 085806010041',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Email: 22082010059@students.student.upnjatim.ac.id',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'GitHub: github.com/intanfirdausi04',
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