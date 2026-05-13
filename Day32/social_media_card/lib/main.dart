import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SocialMediaCard(),
    );
  }
}

class SocialMediaCard extends StatelessWidget {
  const SocialMediaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      body: Center(
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // HEADER
              Padding(
                padding: const EdgeInsets.all(15),

                child: Row(
                  children: [

                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
                      ),
                    ),

                    SizedBox(width: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [

                        Text(
                          'Arjun',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          '2 hours ago',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // CAPTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),

                child: Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    'Enjoying Flutter UI design practice! '
                    'Learning Stack, Positioned and beautiful layouts.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),

              // IMAGE + LIKE BUTTON
              Stack(
                clipBehavior: Clip.none,
                children: [

                  Container(
                    height: 220,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),

                      image: DecorationImage(
                        fit: BoxFit.cover,

                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1498050108023-c5249f4df085',
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -20,
                    right: 20,

                    child: Container(
                      height: 55,
                      width: 55,

                      decoration: BoxDecoration(
                        color: Colors.pink,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                          ),
                        ],
                      ),

                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}