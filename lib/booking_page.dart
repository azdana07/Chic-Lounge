import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? _selectedCategory;
  String? _selectedService;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final _descriptionController = TextEditingController();
  final _orderTotalController = TextEditingController();
  String? _selectedPayment;

  final Map<String, List<Map<String, dynamic>>> _services = {
    'Haircut & Styling': [
      {'name': 'Wolf Haircut', 'price': 95000},
      {'name': 'Bob Haircut', 'price': 88000},
      {'name': 'Classic Haircut', 'price': 74000},
      {'name': 'Layer Haircut', 'price': 62000},
      {'name': 'Shaggy Haircut', 'price': 59000},
      {'name': 'Soft Shaggy Haircut', 'price': 50000},
      {'name': 'Fresh Framing Layer', 'price': 76000},
      {'name': 'Butterfly Haircut', 'price': 82000},
    ],
    'Hair Coloring': [
      {'name': 'Blonde', 'price': 150000},
      {'name': 'Balayage', 'price': 210000},
      {'name': 'Black', 'price': 113000},
      {'name': 'Cherry red', 'price': 188000},
      {'name': 'Ginger', 'price': 150000},
      {'name': 'Caramel', 'price': 172000},
      {'name': 'Auburn', 'price': 172000},
      {'name': 'Strawberry Blonde', 'price': 172000},
    ],
    'Smoothing & Rebonding': [
      {'name': 'Smoothing', 'price': 300000},
      {'name': 'Rebonding', 'price': 200000},
    ],
    'Hair Spa': [
      {'name': 'Hair Spa', 'price': 248000},
    ],
    'Perming': [
      {'name': 'P001', 'price': 448000},
      {'name': 'P002', 'price': 276000},
    ],
  };

  final List<String> _payments = [
    'Tunai',
    'Non Tunai (QRIS)',
  ];

  List<Map<String, dynamic>> bookings = [];

  double calculateTotalAmount() {
    double total = 0;
    for (var booking in bookings) {
      if (booking['total_amount'] != null && booking['total_amount'].isNotEmpty) {
        total += double.parse(booking['total_amount']);
      }
    }
    return total;
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  void _addBooking() {
    setState(() {
      var booking = {
        'service_name': _selectedService,
        'booking_datetime': DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ),
        'description': _descriptionController.text,
        'total_amount': _orderTotalController.text,
        'payment_method': _selectedPayment,
      };

      bookings.add(booking);
    });

    _clearFields();
  }

  void _clearFields() {
    _selectedCategory = null;
    _selectedService = null;
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    _descriptionController.clear();
    _orderTotalController.clear();
    _selectedPayment = null;
  }

  Future<String> generateQris(String amount, String orderId) async {
    // Replace this with actual QRIS generation logic
    return 'https://api.qrserver.com/v1/create-qr-code/?data=$amount-$orderId';
  }

  Future<void> sendBookingDataToAPI() async {
    try {
      // Example API endpoint (replace with your actual API endpoint)
      String apiUrl = 'https://eu-central-1.hapio.net/v1/bookings?page=1';

      for (var booking in bookings) {
        Map<String, dynamic> postData = {
          'service_name': booking['service_name'],
          'booking_datetime': DateFormat('yyyy-MM-dd HH:mm').format(booking['booking_datetime']),
          'description': booking['description'] ?? '',
          'total_amount': booking['total_amount'],
          'payment_method': booking['payment_method'],
        };

        var response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(postData),
        );

        if (response.statusCode == 200) {
          // Success
          print('Booking data sent successfully');
        } else {
          // Handle error
          print('Failed to send booking data. Error: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      // Handle network and other errors
      print('Error sending booking data: $e');
    }
  }

void _handlePayment() async {
  if (_selectedPayment == 'Non Tunai (QRIS)') {
    try {
      String qrString = await generateQris(
        calculateTotalAmount().toStringAsFixed(2),
        'ORDER-${DateTime.now().millisecondsSinceEpoch}',
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRPaymentPage(
            totalAmount: calculateTotalAmount().toStringAsFixed(2),
            qrString: qrString,
          ),
        ),
      ).then((_) {
        // Setelah pembayaran berhasil, tandai pesanan yang sudah dibayar
        bookings.forEach((booking) {
          booking['paid'] = true;
        });
        _clearFields();
        _viewOrderReceipt(); // Tambahkan ini untuk langsung menampilkan struk setelah pembayaran
      });
    } catch (e) {
      print('Error generating QR: $e');
    }
  } else {
    // Handle other payment methods (Tunai)
    sendBookingDataToAPI(); // Panggil fungsi untuk mengirim data ke API
    _clearBookings(); // Setelah membersihkan bookings, navigasi ke halaman struk
    _viewOrderReceipt(); // Tambahkan ini untuk langsung menampilkan struk setelah pembayaran
  }
}

void _viewOrderReceipt() {
  if (bookings.isNotEmpty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderReceiptPage(
          bookings: bookings,
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tambahkan minimal satu pesanan untuk melihat struk')),
    );
  }
}


  // Navigasi bottom navigation bar
  int _selectedIndex = 2; // Index untuk halaman BookingPage

  void _onItemTapped(int index) {
    if (index == 2) {
      return; // Jika memilih halaman yang sudah aktif (BookingPage), tidak melakukan navigasi ulang
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
      case 3:
        // Navigasi ke halaman Profile
        Navigator.pushReplacementNamed(context, '/profile');
                break;
    }
  }

  int getServicePrice(String serviceName) {
    int price = 0;
    _services.forEach((category, services) {
      services.forEach((service) {
        if (service['name'] == serviceName) {
          price = service['price'];
        }
      });
    });
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Booking'),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(Icons.receipt),
            onPressed: _viewOrderReceipt,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pemesanan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Pilih Kategori Layanan'),
                value: _selectedCategory,
                items: _services.keys.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                    _selectedService = null;
                    _orderTotalController.clear(); // Clear the total amount when category changes
                  });
                },
              ),
              SizedBox(height: 20),
              if (_selectedCategory != null) ...[
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Pilih Layanan'),
                  value: _selectedService,
                  items: _services[_selectedCategory]!.map((Map<String, dynamic> service) {
                    return DropdownMenuItem<String>(
                      value: service['name'],
                      child: Text(service['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedService = value;
                      int price = getServicePrice(value!); // Get price of selected service
                      _orderTotalController.text = price.toString(); // Set the total amount
                    });
                  },
                ),
                SizedBox(height: 20),
              ],
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Hari/Tanggal',
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(_selectedDate),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Pukul',
                ),
                readOnly: true,
                onTap: () => _selectTime(context),
                controller: TextEditingController(
                  text: _selectedTime.format(context),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Keterangan (opsional)'),
                controller: _descriptionController,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Harga Pemesanan'),
                controller: _orderTotalController,
                keyboardType: TextInputType.number,
                readOnly: true, // Prevent editing by user
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_selectedCategory != null &&
                      _selectedService != null &&
                      _orderTotalController.text.isNotEmpty) {
                    _addBooking();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Harap lengkapi semua informasi')),
                    );
                  }
                },
                child: Text('Tambah Pesanan'),
              ),
              if (bookings.isNotEmpty) ...[
                SizedBox(height: 20),
                Text(
                  'Total Pembayaran',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var booking in bookings) ...[
                      Card(
                        child: ListTile(
                          title: Text(booking['service_name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tanggal dan Waktu: ${DateFormat('yyyy-MM-dd HH:mm').format(booking['booking_datetime'])}'),
                              Text('Keterangan: ${booking['description'] ?? '-'}'),
                              Text('Total: Rp ${booking['total_amount']}'),
                              Text('Metode Pembayaran: ${booking['payment_method'] ?? '-'}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 20),
                    Text(
                      'Total Pembayaran Keseluruhan:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp ${calculateTotalAmount().toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Pilih Metode Pembayaran'),
                      value: _selectedPayment,
                      items: _payments.map((String payment) {
                        return DropdownMenuItem<String>(
                          value: payment,
                          child: Text(payment),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPayment = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedPayment != null) {
                          _handlePayment();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Pilih metode pembayaran terlebih dahulu')),
                          );
                        }
                      },
                      child: Text('Bayar'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (bookings.isNotEmpty) {
                          _viewOrderReceipt();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Tambahkan minimal satu pesanan untuk melihat struk')),
                          );
                        }
                      },
                      child: Text('Lihat Struk'),
                    ),
                  ],
                ),
              ],
            ],
          ),
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

class _clearBookings {
}

class QRPaymentPage extends StatelessWidget {
  final String totalAmount;
  final String qrString;

  const QRPaymentPage({
    required this.totalAmount,
    required this.qrString,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran QRIS'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Pembayaran:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Rp $totalAmount',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Image.network(qrString),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderReceiptPage extends StatelessWidget {
  final List<Map<String, dynamic>> bookings;

  const OrderReceiptPage({
    required this.bookings,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Struk Pesanan'),
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Pesanan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              for (var booking in bookings) ...[
                Card(
                  child: ListTile(
                    title: Text(booking['service_name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tanggal dan Waktu: ${DateFormat('yyyy-MM-dd HH:mm').format(booking['booking_datetime'])}'),
                        Text('Keterangan: ${booking['description'] ?? '-'}'),
                        Text('Total: Rp ${booking['total_amount']}'),
                        Text('Metode Pembayaran: ${booking['payment_method'] ?? '-'}'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
