import 'package:flutter/material.dart';
import 'package:recofrend/screens/preferences_screen_ott.dart';
import 'package:recofrend/screens/profile_details_screen.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<Map<String, dynamic>> interests = [
    {'icon': Icons.movie, 'label': 'OTT'},
    {'icon': Icons.restaurant, 'label': 'Food'},
    {'icon': Icons.book, 'label': 'Books'},
    {'icon': Icons.location_on, 'label': 'Go out'},
  ];

  Set<String> selected = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 177, 177, 177),
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              // padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
              width: double.infinity,
              child: Center(
                child: Text(
                  "Recofrend",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Center(
              child: Chip(
                labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                avatar: Icon(Icons.access_time, color: Colors.grey, size: 20),
                label: Text(
                  "30 seconds more",
                  style: TextStyle(color: Colors.black87),
                ),
                backgroundColor: Color(0xFFF1F3F6),
                shape: StadiumBorder(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: 0.4,
                  minHeight: 7,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                  borderRadius: BorderRadius.circular(12),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Start", style: TextStyle(fontSize: 14)),
                    Text("Finish", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What are you interested in?",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Select categories you'd like to get recommendations for:",
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Wrap(
                    spacing: 25,
                    runSpacing: 22,
                    children: interests.map((item) {
                      final isSelected = selected.contains(item['label']);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selected.remove(item['label']);
                            } else {
                              selected.add(item['label']);
                            }
                          });
                        },
                        child: Container(
                          width: 160,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? Colors.lightBlueAccent
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                            color: isSelected
                                ? const Color.fromARGB(150, 170, 235, 243)
                                : Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                item['icon'],
                                size: 30,
                                color: Colors.black87,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (val) {
                                      setState(() {
                                        if (val == true) {
                                          selected.add(item['label']);
                                        } else {
                                          selected.remove(item['label']);
                                        }
                                      });
                                    },
                                  ),
                                  Text(
                                    item['label'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileDetailsScreen(),
                      ),
                    ),
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 246, 240, 240),
                    foregroundColor: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                  ),
                  child: Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PreferencesScreenott(),
                      ),
                    ),
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                  ),
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
