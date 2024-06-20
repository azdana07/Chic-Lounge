import 'package:flutter/material.dart';

class PermingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD4B2A3),
      appBar: AppBar(
        backgroundColor: Color(0xFFD4B2A3),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya saat tombol kembali ditekan
          },
        ),
        title: Text('Perming', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              HairServiceCard(
                imageUrl: 'assets/P001.jpg',
                title: 'P001',
                price: 'Rp. 448.000',
              ),
              SizedBox(height: 16),
              HairServiceCard(
                imageUrl: 'assets/P002.jpg',
                title: 'P002',
                price: 'Rp. 276.000',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HairServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  HairServiceCard({required this.imageUrl, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.contain, // Menggunakan BoxFit.contain agar gambar tidak terpotong
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
