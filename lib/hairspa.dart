import 'package:flutter/material.dart';

   void main() {
     runApp(MyApp());
   }

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         debugShowCheckedModeBanner: false,
         home: HairSpaScreen(),
       );
     }
   }

   class HairSpaScreen extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         backgroundColor: Color(0xFFD4B2A3), // Background color as in the image
         appBar: AppBar(
           backgroundColor: Color(0xFFD4B2A3), // AppBar color as in the image
           elevation: 0,
           leading: IconButton(
             icon: Icon(Icons.arrow_back, color: Colors.black),
             onPressed: () {
               Navigator.pop(context); // Kembali ke halaman sebelumnya saat tombol kembali ditekan
             },
           ),
           title: Text('Hair Spa', style: TextStyle(color: Colors.black)),
         ),
         body: Center(
           child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: HairServiceCard(
               imageUrl: 'assets/hairspa.jpg', // Gambar yang sesuai dengan halaman Hair Spa
               title: 'Hair Spa', // Judul halaman
               price: 'Rp. 248.000', // Harga layanan
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
                 fit: BoxFit.cover,
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
