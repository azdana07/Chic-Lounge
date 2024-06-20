import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _changePassword() {
    if (_passwordController.text == _confirmPasswordController.text) {
      // Logika untuk mengganti password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password berhasil diubah')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password dan konfirmasi password tidak cocok')),
      );
    }
  }

  // Navigasi bottom navigation bar
  int _selectedIndex = 3; // Index untuk halaman Profile

  void _onItemTapped(int index) {
    if (index == 3) {
      return; // Jika memilih halaman yang sudah aktif (ProfilePage), tidak melakukan navigasi ulang
    }
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi ke halaman sesuai index yang dipilih
    switch (index) {
      case 0:
        // Navigasi ke halaman Home
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        // Navigasi ke halaman Gallery
        Navigator.pushReplacementNamed(context, '/gallery');
        break;
      case 2:
        // Navigasi ke halaman Booking
        Navigator.pushReplacementNamed(context, '/booking');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.brown, // Mengatur warna AppBar
        // Hapus ikon back (leading) dari AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/me.jpeg'), // Ganti dengan gambar profil pengguna
            ),
            SizedBox(height: 20),
            Text(
              'Azdan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'azdana@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Nama Lengkap'),
              subtitle: Text('Azdana Hasfi'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('azdana@gmail.com'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Nomor Telepon'),
              subtitle: Text('+62 123 4567 890'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Alamat'),
              subtitle: Text('Desa Tangunan, Puri, Mojokerto 61363'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Ganti Password'),
              subtitle: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Masukkan Password Baru',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Konfirmasi Password'),
              subtitle: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Konfirmasi Password Baru',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              child: Text('Simpan Password Baru'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk logout
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}