import 'package:flutter/material.dart';
import 'package:recofrend/screens/interests_screen.dart';
import 'package:recofrend/screens/preferences_screenBOOKS.dart';

class PreferencesScreengoout extends StatefulWidget {
  const PreferencesScreengoout({super.key});

  @override
  State<PreferencesScreengoout> createState() => _PreferencesScreengooutState();
}

class _PreferencesScreengooutState extends State<PreferencesScreengoout> {
  final List<String> interests = [
    'Cafes',
    'Restaurants',
    'Parks',
    'Museums',
    'Theaters',
    'Shopping',
    'Hiking',
    'Beaches',
    'Nightlife',
    'Concerts',
    'Sightseeing',
    'Art Galleries',
    'Wineries',
    'Sports Events',
    'Local Attractions',
  ];

  Set<String> selected = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Center(
                child: Chip(
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  avatar: Icon(Icons.access_time, color: Colors.grey, size: 20),
                  label: Text(
                    "Almost done!",
                    style: TextStyle(color: Colors.black87),
                  ),
                  backgroundColor: Color(0xFFF1F3F6),
                  shape: StadiumBorder(),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: 0.5,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select your favorite Go out interests",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            text:
                                "Select at least 3 interests to help us personalize your recommendations:  ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "0/3 recommendations",
                                style: TextStyle(
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 10,
                      children: interests.map((item) {
                        final isSelected = selected.contains(item);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selected.remove(item);
                              } else {
                                selected.add(item);
                              }
                            });
                          },
                          child: Container(
                            height: 120,
                            width: 125,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/goout.jpg'),
                              ),
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
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(154, 253, 254, 177),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromARGB(255, 237, 224, 167),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Image(
                                image: AssetImage('assets/warning.png'),
                                width: 23,
                                height: 23,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'Please select atleast 3 interests to continue!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 255, 170, 0),
                                  ),
                                ),
                              ),
                            ],
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
                                builder: (context) => const InterestsScreen(),
                              ),
                            ),
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              246,
                              240,
                              240,
                            ),
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
                                builder: (context) =>
                                    const PreferencesScreenbooks(),
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
            ),
          ),
        ],
      ),
    );
  }
}
