import 'package:flutter/material.dart';

class FoodRecommendationCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String cuisine;
  final String price;
  final String time;
  final String address;
  final List<String> platforms;
  final List<String> popularContent;
  final String likedBy;
  final List<Color> chipColors1 = [
    Colors.red,
    Colors.green,
    Colors.deepPurple,
    Colors.orange,
    Colors.teal,
    Colors.blueAccent,
    Colors.pinkAccent,
  ];

  final List<Color> chipColors2 = [
    // Colors.red,
    // Colors.green,
    Colors.deepPurple,
    Colors.orange,
    Colors.teal,
    Colors.blueAccent,
    Colors.pinkAccent,
  ];

  FoodRecommendationCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.cuisine,
    required this.price,
    required this.time,
    required this.address,
    required this.platforms,
    required this.popularContent,
    required this.likedBy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              height: 185,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                Row(
                  children: [
                    Text(
                      'Cuisine:',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 112, 112, 112),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(cuisine, style: TextStyle(fontSize: 15)),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 20,
                      color: const Color.fromARGB(255, 112, 112, 112),
                    ),
                    const SizedBox(width: 5),
                    Text(price, style: TextStyle(fontSize: 15)),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 20,
                      color: const Color.fromARGB(255, 112, 112, 112),
                    ),
                    const SizedBox(width: 5),
                    Text(time, style: TextStyle(fontSize: 15)),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.pin_drop_outlined,
                      size: 20,
                      color: const Color.fromARGB(255, 112, 112, 112),
                    ),
                    const SizedBox(width: 5),
                    Text(address, style: TextStyle(fontSize: 15)),
                  ],
                ),

                SizedBox(height: 8),

                Text(
                  "Available on:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    platforms.length,
                    (index) => Chip(
                      label: Text(
                        platforms[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: chipColors1[index % chipColors1.length],
                      elevation: 4,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 8),

                // Popular Content
                Text(
                  "Popular Content:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    popularContent.length,
                    (index) => Chip(
                      label: Text(
                        popularContent[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: chipColors2[index % chipColors2.length],
                      elevation: 4,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 5),
                Text(
                  "Liked by: $likedBy",
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
