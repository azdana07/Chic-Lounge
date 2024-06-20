// owner_selection.dart

import 'package:flutter/material.dart';

class OwnerSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Owner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AzdanaHasfiNabilahPage()),
                );
              },
              child: Text('Azdana Hasfi Nabilah'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IntanFirdausiPage()),
                );
              },
              child: Text('Intan Firdausi'),
            ),
          ],
        ),
      ),
    );
  }
}

class AzdanaHasfiNabilahPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Azdana Hasfi Nabilah'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileWidget(
              name: 'Azdana Hasfi Nabilah',
              imagePath: 'assets/owner1.jpeg',
              birthPlace: 'Mojokerto',
              birthDate: '07 Juli 2004',
              address: 'Desa Tangunan, RT.10, RW.05, Puri Mojokerto',
              phoneNumber: '085806361803',
              email: '22082010076@students.student.upnjatim.ac.id',
              github: 'Github.github.com/azdana07',
              education: 'Mahasiswa S1 Sistem Informasi',
              university: 'UPN VETERAN JAWA TIMUR',
            ),
          ],
        ),
      ),
    );
  }
}

class IntanFirdausiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intan Firdausi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileWidget(
              name: 'Intan Firdausi',
              imagePath: 'assets/owner2.jpeg',
              birthPlace: 'Gresik',
              birthDate: '04 Maret 2004',
              address: 'Desa Genengan, RT.10, RW.01, Balongpanggang Gresik',
              phoneNumber: '085806010041',
              email: '22082010059@students.student.upnjatim.ac.id',
              github: 'github.com/intanfirdausi04',
              education: 'Mahasiswa S1 Sistem Informasi',
              university: 'UPN VETERAN JAWA TIMUR',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String name;
  final String imagePath;
  final String birthPlace;
  final String birthDate;
  final String address;
  final String phoneNumber;
  final String email;
  final String github;
  final String education;
  final String university;

  ProfileWidget({
    required this.name,
    required this.imagePath,
    required this.birthPlace,
    required this.birthDate,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.github,
    required this.education,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50.0,
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(height: 16.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Nama: $name',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          'Tempat, Tanggal Lahir: $birthPlace, $birthDate',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          'Alamat: $address',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          'No.HP: $phoneNumber',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          'Email: $email',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          'GitHub: $github',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          'Pendidikan: $education',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          university,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
