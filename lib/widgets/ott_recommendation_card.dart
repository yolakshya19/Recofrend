import 'package:flutter/material.dart';

class OttRecommendationCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String genre;
  final String year;
  final String director;
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

  OttRecommendationCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.genre,
    required this.year,
    required this.director,
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
                      'Genre:',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 112, 112, 112),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(genre, style: TextStyle(fontSize: 15)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Year:',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 112, 112, 112),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(year, style: TextStyle(fontSize: 15)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Director:',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 112, 112, 112),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(director, style: TextStyle(fontSize: 15)),
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
