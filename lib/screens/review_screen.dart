import 'package:flutter/material.dart';
import 'package:recofrend/screens/home/home_screen.dart';

class ReviewScreen extends StatefulWidget {
  final List<Map<String, dynamic>> selectedInterests;
  final Map<String, List<String>> selectedPreferences;

  const ReviewScreen({
    super.key,
    required this.selectedInterests,
    required this.selectedPreferences,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final List<Color> pastelColors = [
    Colors.purple.shade200,
    Colors.orange.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
    Colors.red.shade200,
    Colors.teal.shade200,
    Colors.yellow.shade200,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Chip(
                      labelPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      avatar: Icon(
                        Icons.access_time,
                        color: Colors.grey,
                        size: 20,
                      ),
                      label: Text(
                        "You're all set!",
                        style: TextStyle(color: Colors.black87),
                      ),
                      backgroundColor: Color(0xFFF1F3F6),
                      shape: StadiumBorder(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LinearProgressIndicator(
                          value: 1,
                          minHeight: 7,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlue,
                          ),
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

                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 5,
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/tick.png', height: 50, width: 50),
                        const SizedBox(height: 15),
                        Text(
                          'Ready to discover!',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 200, 95, 218),
                                  const Color.fromARGB(255, 78, 169, 244),
                                ],
                              ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "We've personalized your experience based on your amazing choices.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(184, 213, 217, 255),
                        border: Border.all(
                          color: const Color.fromARGB(164, 67, 64, 251),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            spreadRadius: 3,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.edit_rounded,
                                color: Color.fromARGB(255, 184, 138, 250),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Your categories',
                                style: TextStyle(
                                  // color: Color.fromARGB(255, 113, 12, 254),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader =
                                        LinearGradient(
                                          colors: [
                                            const Color.fromARGB(
                                              255,
                                              200,
                                              95,
                                              218,
                                            ),
                                            const Color.fromARGB(
                                              255,
                                              78,
                                              169,
                                              244,
                                            ),
                                          ],
                                        ).createShader(
                                          Rect.fromLTWH(100, 0, 200, 70),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: widget.selectedInterests
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    int index = entry.key;
                                    var item = entry.value;
                                    Color chipColor =
                                        pastelColors[index %
                                            pastelColors.length];

                                    return Chip(
                                      avatar: Icon(
                                        item['icon'],
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      label: Text(
                                        item['label'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      backgroundColor: chipColor.withOpacity(
                                        0.8,
                                      ),
                                      shape: StadiumBorder(
                                        side: BorderSide(color: chipColor),
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                Icons.star_border,
                                color: Color.fromARGB(255, 184, 138, 250),
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Your Interests',
                                style: TextStyle(
                                  foreground: Paint()
                                    ..shader =
                                        LinearGradient(
                                          colors: [
                                            const Color.fromARGB(
                                              255,
                                              200,
                                              95,
                                              218,
                                            ),
                                            const Color.fromARGB(
                                              255,
                                              78,
                                              169,
                                              244,
                                            ),
                                          ],
                                        ).createShader(
                                          Rect.fromLTWH(100, 0, 200, 70),
                                        ),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          ...widget.selectedInterests.asMap().entries.map((
                            entry,
                          ) {
                            int index = entry.key;
                            var item = entry.value;
                            String interest = item['label'];
                            IconData iconData = item['icon'];
                            List<String> prefs =
                                widget.selectedPreferences[interest] ?? [];
                            Color chipColor =
                                pastelColors[index % pastelColors.length];

                            return Container(
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(iconData, color: chipColor),
                                      SizedBox(width: 8),
                                      Text(
                                        interest,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: prefs.map((pref) {
                                      return Chip(
                                        label: Text(pref),
                                        backgroundColor: chipColor.withOpacity(
                                          0.5,
                                        ),
                                        shape: StadiumBorder(
                                          side: BorderSide(color: chipColor),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                          Text(
                            'You can always update your preferences later in your profile settings.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 113, 12, 254),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Back'),
                        ),
                        Container(
                          height: 70,
                          width: 170,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 200, 95, 218),
                                const Color.fromARGB(255, 78, 169, 244),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 164, 162, 162),
                                blurRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
