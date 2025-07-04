import 'package:flutter/material.dart';
import 'package:recofrend/widgets/book_recommendation_card.dart';
import 'package:recofrend/widgets/food_recommendation_card.dart';
import 'package:recofrend/widgets/goout_recommendation_card.dart';
import 'package:recofrend/widgets/ott_recommendation_card.dart';
import 'package:recofrend/data/dummy_recommendations.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedInterestIndex = 0;
  final List<String> interests = ['TV & Movies', 'Books', 'Food', 'Go Out'];
  final ScrollController _scrollController = ScrollController();

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

  Widget _buildCard(String section) {
    final interest = interests[selectedInterestIndex];
    final dataList = dummyRecommendations[interest];

    if (dataList == null || dataList.isEmpty) return SizedBox();

    return SizedBox(
      height: 530,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> data = dataList[index];

          final Widget card;

          switch (interest) {
            case 'TV & Movies':
              card = OttRecommendationCard(
                imagePath: data['imagePath'],
                title: data['title'],
                genre: data['genre'],
                year: data['year'],
                director: data['director'],
                platforms: List<String>.from(data['platforms']),
                popularContent: List<String>.from(data['popularContent']),
                likedBy: data['likedBy'],
              );
              break;
            case 'Books':
              card = BookRecommendationCard(
                imagePath: data['imagePath'],
                title: data['title'],
                author: data['author'],
                year: data['year'],
                genre: data['genre'],
                platforms: List<String>.from(data['platforms']),
                popularContent: List<String>.from(data['popularContent']),
                likedBy: data['likedBy'],
              );
              break;
            case 'Food':
              card = FoodRecommendationCard(
                imagePath: data['imagePath'],
                title: data['title'],
                cuisine: data['cuisine'],
                price: data['price'],
                time: data['time'],
                address: data['address'],
                platforms: List<String>.from(data['platforms']),
                popularContent: List<String>.from(data['popularContent']),
                likedBy: data['likedBy'],
              );
              break;
            case 'Go Out':
              card = GooutRecommendationCard(
                imagePath: data['imagePath'],
                title: data['title'],
                type: data['type'],
                price: data['price'],
                time: data['time'],
                address: data['address'],
                platforms: List<String>.from(data['platforms']),
                popularContent: List<String>.from(data['popularContent']),
                likedBy: data['likedBy'],
              );
              break;
            default:
              card = SizedBox();
          }

          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(width: 290, child: card),
          );
        },
      ),
    );
  }

  final List<String> sections = [
    'Top Recommendations',
    'Trending This Week',
    'Popular Among Your Friends',
    'Top Voice Favorites',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      // controller: _scrollController,
      // thumbVisibility: true,
      // trackVisibility: true,
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
                          _scrollController.jumpTo(0);
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sections.map((section) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      _buildCard(section),
                      const SizedBox(height: 40),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
