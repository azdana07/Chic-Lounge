import 'package:flutter/material.dart';

class HaircutStylingScreen extends StatelessWidget {
  final List<Map<String, String>> haircut = [
    {'id': 'Wolf Haircut', 'price': 'Rp. 95.000', 'image': 'assets/HC001.jpeg'},
    {'id': 'Bob Haircut', 'price': 'Rp. 88.000', 'image': 'assets/HC002.jpeg'},
    {'id': 'Classic Haircut', 'price': 'Rp. 74.000', 'image': 'assets/HC003.jpeg'},
    {'id': 'Layer Haircut', 'price': 'Rp. 62.000', 'image': 'assets/HC004.jpeg'},
    {'id': 'Shaggy Haircut', 'price': 'Rp. 59.000', 'image': 'assets/HC005.jpeg'},
    {'id': 'Soft Shaggy Haircut', 'price': 'Rp. 50.000', 'image': 'assets/HC006.jpeg'},
    {'id': 'Fresh Framing Layer Haircut', 'price': 'Rp. 76.000', 'image': 'assets/HC007.jpeg'},
    {'id': 'Butterfly Haircut', 'price': 'Rp. 82.000', 'image': 'assets/HC008.jpeg'},
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
        title: Text('Hair Cut & Styling', style: TextStyle(color: Colors.black)),
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
          itemCount: haircut.length,
          itemBuilder: (context, index) {
            return HairColoringCard(
              id: haircut[index]['id']!,
              price: haircut[index]['price']!,
              imageUrl: haircut[index]['image']!,
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
