import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderReceiptPage extends StatelessWidget {
  final List<Map<String, dynamic>> bookings;

  OrderReceiptPage({required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Struk Pemesanan'),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pemesanan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  var booking = bookings[index];
                  return Card(
                    child: ListTile(
                      title: Text(booking['service_name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal dan Waktu: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(booking['booking_datetime']))}'),
                          Text('Keterangan: ${booking['description'] ?? '-'}'),
                          Text('Total: Rp ${booking['total_amount']}'),
                          Text('Metode Pembayaran: ${_formatPaymentMethod(booking['payment_method'])}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPaymentMethod(String? paymentMethod) {
    if (paymentMethod == 'Tunai') {
      return 'Tunai';
    } else if (paymentMethod == 'Non Tunai (QRIS)') {
      return 'Non Tunai';
    } else {
      return '-';
    }
  }
}
