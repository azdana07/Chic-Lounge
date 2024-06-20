import 'package:flutter/material.dart';
import 'haircut.dart'; // Pastikan file ini ada dan berisi class HaircutStylingScreen
import 'home.dart'; // Pastikan file ini ada dan berisi class HomePage
import 'haircoloring.dart'; // Pastikan file ini ada dan berisi class HairColoringScreen
import 'hairspa.dart'; // Import file hair_spa.dart yang baru dibuat
import 'smoothing&rebonding.dart'; // Import file smoothing_rebonding.dart yang baru dibuat
import 'perming.dart'; // Import file perming.dart yang baru dibuat
import 'booking_page.dart'; // Import file booking_page.dart yang baru dibuat

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int _selectedIndex = 1; // Sesuaikan indeks ini sesuai dengan tab galeri

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 1) {
      // Tab galeri sudah aktif
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookingPage()),
      );
    } else if (index == 3) {
      // Navigasi ke halaman profil jika diperlukan
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galeri Rambut'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildGalleryItem(context, 'Haircut & Styling', 'assets/haircut_styling.jpeg'),
            buildGalleryItem(context, 'Hair Coloring', 'assets/hair_coloring.jpeg'),
            buildGalleryItem(context, 'Hair Spa', 'assets/hair_spa.jpeg'),
            buildGalleryItem(context, 'Smoothing & Rebonding', 'assets/smoothing_rebonding.jpeg'),
            buildGalleryItem(context, 'Perming', 'assets/perming.jpeg'),
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

  Widget buildGalleryItem(BuildContext context, String title, String imagePath) {
  return GestureDetector(
    onTap: () {
      if (title == 'Haircut & Styling') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HaircutStylingScreen()),
        );
      } else if (title == 'Hair Coloring') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HairColoringScreen()),
        );
      } else if (title == 'Hair Spa') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HairSpaScreen()),
        );
      } else if (title == 'Smoothing & Rebonding') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SmoothingRebondingScreen()),
        );
      } else if (title == 'Perming') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PermingScreen()),
        );
      }
      // Tambahkan kondisi untuk halaman lain jika diperlukan
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200, // Sesuaikan sesuai kebutuhan
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Menggunakan BoxFit.cover agar gambar memanjang dan memenuhi kotak
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}