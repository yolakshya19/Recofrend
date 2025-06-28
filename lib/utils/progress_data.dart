class ProgressData {
  int currentStep;
  int totalSteps;

  ProgressData({required this.currentStep, required this.totalSteps});

  double get progressValue {
    if (totalSteps == 0) return 0;
    return currentStep / totalSteps;
  }
}

class ProgressController {
  static final ProgressController _instance = ProgressController._internal();

  factory ProgressController() => _instance;

  ProgressController._internal();

  ProgressData _progress = ProgressData(
    currentStep: 1,
    totalSteps: 6, // default fallback
  );

  ProgressData get progress => _progress;

  void setProgress({required int currentStep, required int totalSteps}) {
    _progress = ProgressData(
      currentStep: currentStep.clamp(1, totalSteps),
      totalSteps: totalSteps,
    );
  }

  void updateCurrentStep(int step) {
    // Only update if it's an advancement and not beyond totalSteps
    if (step > _progress.currentStep && step <= _progress.totalSteps) {
      _progress.currentStep = step;
    }
  }

  void updateTotalSteps(int steps) {
    _progress.totalSteps = steps;
  }
}
