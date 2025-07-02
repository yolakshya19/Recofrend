import 'package:flutter/material.dart';
import 'package:recofrend/widgets/ott_recommendation_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedInterestIndex = 0;
  final List<String> interests = ['TV & Movies', 'Books', 'Food', 'Go Out'];

  Widget _buildInterestButton(String label, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Text(
        label,
        style: TextStyle(
          letterSpacing: 0.5,
          fontSize: 15.5,
          fontWeight: FontWeight.w700,
          color: isSelected ? Colors.black : Colors.grey[600],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      thickness: 8,
      radius: Radius.circular(15),
      interactive: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Find and share great recommendations',
                style: TextStyle(
                  fontSize: 17,
                  color: const Color.fromARGB(172, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(interests.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedInterestIndex = index;
                        });
                      },
                      child: _buildInterestButton(
                        interests[index],
                        isSelected: selectedInterestIndex == index,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Top Recommendations',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: RecommendationCard(
                  imagePath: 'assets/net.jpg',
                  title: 'Inception',
                  genre: 'Sci-Fi',
                  year: '2010',
                  director: 'Christopher Nolan',
                  platforms: ['Netflix', 'Amazon'],
                  popularContent: ['Instagram', 'Youtube'],
                  likedBy: 'Rahul',
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Trending This Week',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: RecommendationCard(
                  imagePath: 'assets/net.jpg',
                  title: 'Inception',
                  genre: 'Sci-Fi',
                  year: '2010',
                  director: 'Christopher Nolan',
                  platforms: ['Netflix', 'Amazon'],
                  popularContent: ['Instagram', 'Youtube'],
                  likedBy: 'Rahul',
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Popular Among Your Friends',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: RecommendationCard(
                  imagePath: 'assets/net.jpg',
                  title: 'Inception',
                  genre: 'Sci-Fi',
                  year: '2010',
                  director: 'Christopher Nolan',
                  platforms: ['Netflix', 'Amazon'],
                  popularContent: ['Instagram', 'Youtube'],
                  likedBy: 'Rahul',
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Top Voice Favorites',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: RecommendationCard(
                  imagePath: 'assets/net.jpg',
                  title: 'Inception',
                  genre: 'Sci-Fi',
                  year: '2010',
                  director: 'Christopher Nolan',
                  platforms: ['Netflix', 'Amazon'],
                  popularContent: ['Instagram', 'Youtube'],
                  likedBy: 'Rahul',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
