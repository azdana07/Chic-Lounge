import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class QRPaymentPage extends StatefulWidget {
  final String totalAmount;

  QRPaymentPage({required this.totalAmount});

  @override
  _QRPaymentPageState createState() => _QRPaymentPageState();
}

class _QRPaymentPageState extends State<QRPaymentPage> {
  late Future<Uint8List> _qrCodeFuture;

  @override
  void initState() {
    super.initState();
    _qrCodeFuture = fetchQrImage();
  }

  Future<Uint8List> fetchQrImage() async {
    String apiUrl = 'https://api.qrserver.com/v1/create-qr-code/';
    String qrData = 'Amount:${widget.totalAmount}'; // Data QR code berisi totalAmount

    Map<String, String> queryParams = {
      'size': '200x200',
      'data': qrData,
    };

    Uri uri = Uri.parse(apiUrl);
    uri = uri.replace(queryParameters: queryParams);

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return Uint8List.fromList(response.bodyBytes); // Konversi List<int> ke Uint8List
    } else {
      throw Exception('Failed to load QR code');
    }
  }

  @override
  Widget build(BuildContext context) {
    final expiryDate = DateTime.now().add(Duration(minutes: 15)); // 15 menit kedaluwarsa

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran Non Tunai (QRIS)'),
        backgroundColor: Colors.brown,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Pembayaran QRIS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Salon Chic Lounge',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            FutureBuilder<Uint8List>(
              future: _qrCodeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Failed to load QR code: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: Image.memory(
                        snapshot.data!,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'QR code tidak valid',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Text('Total Pembayaran: Rp ${widget.totalAmount}'),
            SizedBox(height: 10),
            Text('Berlaku hingga: ${DateFormat('dd MMM yyyy, HH:mm').format(expiryDate)}'),
            SizedBox(height: 20),
            Text('Menerima Pembayaran melalui aplikasi di bawah ini:'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/linkaja.png', width: 50, height: 50),
                SizedBox(width: 10),
                Image.asset('assets/ovo.png', width: 50, height: 50),
                SizedBox(width: 10),
                Image.asset('assets/dana.jpeg', width: 50, height: 50),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
              child: Text('Oke'),
            ),
          ],
        ),
      ),
    );
  }
}
