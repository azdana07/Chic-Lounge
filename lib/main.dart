import 'package:flutter/material.dart';
import 'home.dart'; // Import HomePage
import 'booking_page.dart'; // Import BookingPage
import 'galeri_rambut.dart'; // Import GalleryPage
import 'daftar_akun.dart'; // Import RegisterPage
import 'profilepage.dart'; // Import ProfilePage
import 'owner_selection.dart'; 

void main() {
  runApp(ChicLoungeApp());
}

class ChicLoungeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chic Lounge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FancyLoginPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/gallery': (context) => GalleryPage(),
        '/booking': (context) => BookingPage(),
        '/register': (context) => RegisterPage(),
        '/profile_selection': (context) => ProfileSelection(),
        '/owner_selection': (context) => ProfileOwnerSelection(),
      },
    );
  }
  
  ProfileSelection() {}
  
  ProfileOwnerSelection() {}
}

class FancyLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 251),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'CHIC LOUNGE',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 2, 3, 9),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Charming Hair & Impeccable Care',
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 12, 2, 2),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 103, 84, 70),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Masukkan Username Anda',
                          prefixIcon: Icon(Icons.person, color: const Color.fromARGB(255, 54, 55, 55)),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Password Anda',
                          prefixIcon: Icon(Icons.lock, color: const Color.fromARGB(255, 54, 55, 55)),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 142, 143, 145),
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
                        child: Text('LOGIN'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Daftar Akun',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OwnerSelectionPage()),
                    );
                  },
                  child: Text(
                    'Owner',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                                   Text(
                     'Senin-Jum\'at 09.00-17.00.\n'
                     'Sabtu-Minggu 08.00-17.00.\n'
                     'Jl. Mandiri no 33 Dsn Gedangklutuk Ds\n'
                     'Banjaragung, Mojokerto 61363',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       fontSize: 14,
                       color: Colors.black,
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
