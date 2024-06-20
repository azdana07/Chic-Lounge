import 'package:flutter/material.dart';

class HairColoringScreen extends StatelessWidget {
  final List<Map<String, String>> hairColors = [
    {'id': 'BLONDE', 'price': 'Rp. 150.000', 'image': 'assets/blonde.jpeg'},
    {'id': 'BALAYAGE', 'price': 'Rp. 210.000', 'image': 'assets/balayage.jpeg'},
    {'id': 'BLACK', 'price': 'Rp. 113.000', 'image': 'assets/black.jpeg'},
    {'id': 'CHERRY RED', 'price': 'Rp. 188.000', 'image': 'assets/cherry_red.jpeg'},
    {'id': 'GINGER', 'price': 'Rp. 150.000', 'image': 'assets/ginger.jpeg'},
    {'id': 'CARAMEL', 'price': 'Rp. 172.000', 'image': 'assets/caramel.jpeg'},
    {'id': 'AUBURN', 'price': 'Rp. 172.000', 'image': 'assets/auburn.jpeg'},
    {'id': 'STRAWBERRY BLONDE', 'price': 'Rp. 172.000', 'image': 'assets/strawberry_blonde.jpeg'},
  ];

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
            Navigator.pop(context);
          },
        ),
        title: Text('Hair Coloring', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: hairColors.length,
          itemBuilder: (context, index) {
            return HairColoringCard(
              id: hairColors[index]['id']!,
              price: hairColors[index]['price']!,
              imageUrl: hairColors[index]['image']!,
            );
          },
        ),
      ),
    );
  }
}

class HairColoringCard extends StatelessWidget {
  final String id;
  final String price;
  final String imageUrl;

  HairColoringCard({required this.id, required this.price, required this.imageUrl});

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
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(price),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
