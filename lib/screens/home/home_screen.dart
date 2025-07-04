import 'package:flutter/material.dart';
import 'package:recofrend/screens/home/app_bars.dart';
import 'package:recofrend/screens/home/feed_tab.dart';
import 'package:recofrend/screens/home/home_tab.dart';
import 'package:recofrend/screens/home/profile_tab.dart';
import 'package:recofrend/screens/home/review_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeTab(),
    FeedTab(),
    ReviewTab(),
    ProfileTab(),
  ];

  PreferredSizeWidget _appBars(int index) {
    switch (index) {
      case 0:
        return homeAppBar(() {
          setState(() {
            _selectedIndex = 3;
          });
        });
      case 1:
        return feedAppBar();
      case 2:
        return discoverAppBar(() {
          setState(() {
            _selectedIndex = 3;
          });
        });
      case 3:
        return profileAppBar();
      default:
        return homeAppBar(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 238, 238),
      appBar: _appBars(_selectedIndex),
      drawer: Drawer(),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        iconSize: 30,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Discover',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.lightBlue,
              shape: const CircleBorder(),
              child: Icon(Icons.add, size: 30, color: Colors.white),
            )
          : null,
    );
  }
}
