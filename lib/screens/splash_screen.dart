import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recofrend/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showThumb = true;
  bool showLogo = false;
  bool showText = false;
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    _startSequence();
  }

  void _startSequence() {
    Timer(Duration(seconds: 1), () {
      setState(() => showThumb = false);
    });

    Timer(Duration(seconds: 2), () {
      setState(() => showLogo = true);
    });

    Timer(Duration(seconds: 2), () {
      setState(() => showText = true);
    });

    Timer(Duration(seconds: 2), () {
      setState(() => showButton = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        width: double.infinity,
        color: Colors.lightBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: showThumb ? 1 : 0,
              duration: Duration(milliseconds: 1000),
              child: Icon(
                Icons.thumb_up_alt_rounded,
                size: 100,
                color: Colors.white,
              ),
            ),

            if (showLogo)
              AnimatedOpacity(
                opacity: showLogo ? 1 : 0,
                duration: Duration(milliseconds: 800),
                child: Container(
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/logo.jpg',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),

            if (showText)
              AnimatedOpacity(
                opacity: showText ? 1 : 0,
                duration: Duration(milliseconds: 800),
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Text(
                      "Recofrend",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Your Recommendation Friend",
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ],
                ),
              ),

            if (showButton)
              AnimatedOpacity(
                opacity: showButton ? 1 : 0,
                duration: Duration(milliseconds: 800),
                child: Container(
                  margin: EdgeInsets.only(top: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.lightBlue,
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 35,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
