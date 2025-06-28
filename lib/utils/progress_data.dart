class ProgressData {
  int currentStep;
  int totalSteps;

  ProgressData({required this.currentStep, required this.totalSteps});

  double get progressValue => currentStep / totalSteps;
}

class ProgressController {
  static final ProgressController _instance = ProgressController._internal();

  factory ProgressController() => _instance;

  ProgressController._internal();

  ProgressData _progress = ProgressData(
    currentStep: 1,
    totalSteps: 6,
  ); // default

  ProgressData get progress => _progress;

  void setProgress({required int currentStep, required int totalSteps}) {
    _progress = ProgressData(currentStep: currentStep, totalSteps: totalSteps);
  }

  void updateCurrentStep(int step) {
    _progress.currentStep = step;
  }

  void updateTotalSteps(int steps) {
    _progress.totalSteps = steps;
  }
}
