import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CarDetailPage extends StatefulWidget {
  final Map<String, dynamic> car;

  const CarDetailPage({super.key, required this.car});

  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  bool isFavorite = false; 

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car['name']!),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Mobil dengan Icon Favorite di atasnya
              Stack(
                children: [
                  Image.asset(
                    widget.car['image']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height:  screenWidth < 600 ? 200 : 300,
                  ),
                  Positioned(
                   bottom: 8.0,
                   right: 8.0,
                    child: IconButton(
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite // Ikon penuh jika sudah di-favorite
                            : Icons.favorite_border, // Ikon kosong jika belum di-favorite
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 32.0,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite; // Toggle status favorite
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Nama Mobil
              Text(
                widget.car['name']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),

               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    children: [
                      Icon(FontAwesomeIcons.calendarCheck, size: 24),
                      SizedBox(height: 8),
                      Text('Open Everyday'),
                    ],
                  ),
                  const Column(
                    children: [
                      Icon(FontAwesomeIcons.clock, size: 24),
                      SizedBox(height: 8),
                      Text('09:00 - 20:00'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(FontAwesomeIcons.dollarSign, size: 24),
                      SizedBox(height: 8),
                       // Harga Mobil (misalnya harga dari data 'price')
                  Text(
                    '${widget.car['price']}', // Pastikan menggunakan widget.car['price']
                    ),
                  ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Deskripsi Mobil
              Text(
                '${widget.car['name']} adalah salah satu mobil terbaik dengan tipe ${widget.car['location']}. Mobil ini menawarkan performa tinggi, kenyamanan, dan desain yang elegan, cocok untuk berbagai kebutuhan.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 16.0),

              // Gambar tambahan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/images/Mercedes-Benz article.jpg",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/images/Mercedes-Benz article-1.jpg",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/images/Mercedes-Benz article-2.jpeg",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
