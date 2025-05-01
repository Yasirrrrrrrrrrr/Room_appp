import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> photos = [
    'images/room1.jpeg',
    'images/room2.jpg',
    'images/room3.jpeg',
    'images/room4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rooms Listing',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MainPage(photos: photos),
    );
  }
}

class MainPage extends StatelessWidget {
  final List<String> photos;

  const MainPage({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Rooms')),
      body: ListView.builder(
        itemCount: photos.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final photo = photos[index];
          final roomName = 'Room ${index + 1}';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 400),
                  pageBuilder: (_, __, ___) => DetailPage(
                    photo: photo,
                    roomName: roomName,
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Hero(
                      tag: photo,
                      child: ClipOval(
                        child: Image.asset(
                          photo,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      roomName,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String photo;
  final String roomName;

  const DetailPage({Key? key, required this.photo, required this.roomName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        appBar: AppBar(title: Text(roomName)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Hero(
                tag: photo,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    photo,
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              roomName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Tap image to go back', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
