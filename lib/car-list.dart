import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:showroom/car-detail.dart';

class CarListPage extends StatelessWidget {
  const CarListPage({Key? key}) : super(key: key);

  Future<List<dynamic>> loadCarsData() async {
    String jsonString = await rootBundle.loadString('assets/car.json');
    final jsonData = json.decode(jsonString);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mercedes-Benz Cars'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: loadCarsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading cars'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cars found'));
          }

          final cars = snapshot.data!;
          List<dynamic> filteredCars = cars;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (query) {
                    filteredCars = cars.where((car) {
                      final carName = car['name'].toLowerCase();
                      final carLocation = car['location'].toLowerCase();
                      return carName.contains(query.toLowerCase()) ||
                          carLocation.contains(query.toLowerCase());
                    }).toList();
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search cars by name or type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 1 : 3,
                    childAspectRatio: isMobile ? 2 : 1,
                  ),
                  itemCount: filteredCars.length,
                  itemBuilder: (context, index) {
                    final car = filteredCars[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailPage(car: car),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.asset(
                                car['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    car['name'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(car['location']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
