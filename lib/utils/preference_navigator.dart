import 'package:flutter/material.dart';
import 'package:recofrend/utils/progress_data.dart';
import 'package:recofrend/screens/preferences_screen_ott.dart';
import 'package:recofrend/screens/preferences_screen_food.dart';
import 'package:recofrend/screens/preferences_screen_books.dart';
import 'package:recofrend/screens/preferences_screen_go_out.dart';
import 'package:recofrend/screens/review_screen.dart'; // After all preferences

class PreferenceNavigator extends StatefulWidget {
  final int currentStep;

  final List<Map<String, dynamic>> selectedInterests;

  PreferenceNavigator({
    required this.selectedInterests,
    required this.currentStep,
  });

  @override
  State<PreferenceNavigator> createState() => _PreferenceNavigatorState();
}

class _PreferenceNavigatorState extends State<PreferenceNavigator> {
  final Map<String, List<String>> collectedPreferences = {};

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    final progress = ProgressController();

    progress.setProgress(
      currentStep: widget.currentStep,
      totalSteps: 2 + widget.selectedInterests.length + 1,
    );

    // Ensures currentStep starts properly
    progress.updateCurrentStep(widget.currentStep);
  }

  void _goToNextScreen(String interest, List<String> selectedPrefs) {
    collectedPreferences[interest] = selectedPrefs;

    if (_currentIndex < widget.selectedInterests.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      ProgressController().updateCurrentStep(
        ProgressController().progress.totalSteps - 1,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ReviewScreen(
            selectedInterests: widget.selectedInterests,
            selectedPreferences: collectedPreferences,
          ),
        ),
      );
    }
  }

  Widget _getCurrentPreferenceScreen(String interest) {
    final stepForThisScreen = widget.currentStep + _currentIndex;

    switch (interest) {
      case 'OTT':
        return PreferencesScreenott(
          onNext: _goToNextScreen,
          currentStep: stepForThisScreen,
        );
      case 'Food':
        return PreferencesScreenfood(
          onNext: _goToNextScreen,
          currentStep: stepForThisScreen,
        );
      case 'Books':
        return PreferencesScreenbooks(
          onNext: _goToNextScreen,
          currentStep: stepForThisScreen,
        );
      case 'Go out':
        return PreferencesScreengoout(
          onNext: _goToNextScreen,
          currentStep: stepForThisScreen,
        );
      default:
        return const Center(child: Text("Unknown preference"));
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentInterest = widget.selectedInterests[_currentIndex]['label'];
    return _getCurrentPreferenceScreen(currentInterest);
  }
}
