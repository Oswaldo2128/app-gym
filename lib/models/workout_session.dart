import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../services/sound_service.dart';
import 'workout_config.dart';

enum WorkoutPhase {
  active,
  restBetweenSets,
  restBetweenExercises,
  completed,
}

class WorkoutSession extends ChangeNotifier {
  WorkoutSession(this.config)
      : currentExerciseIndex = 0,
        currentSet = 1,
        phase = WorkoutPhase.active,
        remainingSeconds = 0,
        restDurationSeconds = 0,
        isPaused = false;

  final WorkoutConfig config;

  int currentExerciseIndex;
  int currentSet;
  WorkoutPhase phase;
  int remainingSeconds;
  int restDurationSeconds;
  bool isPaused;

  Timer? _timer;

  int get exerciseNumber => currentExerciseIndex + 1;
  int get exerciseCount => config.exerciseCount;
  int get setsForCurrent => config.exercises[currentExerciseIndex].sets;
  bool get isResting =>
      phase == WorkoutPhase.restBetweenSets ||
      phase == WorkoutPhase.restBetweenExercises;
  bool get isCompleted => phase == WorkoutPhase.completed;

  double get restProgress {
    if (restDurationSeconds <= 0) return 0;
    return 1 - (remainingSeconds / restDurationSeconds);
  }

  String get phaseLabel {
    switch (phase) {
      case WorkoutPhase.active:
        return 'Entrenando';
      case WorkoutPhase.restBetweenSets:
        return 'Descanso entre series';
      case WorkoutPhase.restBetweenExercises:
        return 'Descanso entre ejercicios';
      case WorkoutPhase.completed:
        return 'Completado';
    }
  }

  void completeSet() {
    if (phase != WorkoutPhase.active) return;

    final isLastSet = currentSet >= setsForCurrent;
    final isLastExercise = currentExerciseIndex >= config.exerciseCount - 1;

    if (!isLastSet) {
      _startRest(
        WorkoutPhase.restBetweenSets,
        config.restBetweenSetsSeconds,
      );
      return;
    }

    if (!isLastExercise) {
      _startRest(
        WorkoutPhase.restBetweenExercises,
        config.restBetweenExercisesSeconds,
      );
      return;
    }

    _stopTimer();
    phase = WorkoutPhase.completed;
    remainingSeconds = 0;
    restDurationSeconds = 0;
    unawaited(SoundService.instance.playComplete());
    notifyListeners();
  }

  void skipRest() {
    if (!isResting) return;
    _advanceAfterRest(playSound: false);
  }

  void restartRest() {
    if (!isResting) return;
    _startRest(phase, restDurationSeconds);
  }

  void togglePause() {
    if (!isResting) return;
    isPaused = !isPaused;
    notifyListeners();
  }

  void abandon() {
    _stopTimer();
  }

  void _startRest(WorkoutPhase restPhase, int seconds) {
    _stopTimer();
    phase = restPhase;
    restDurationSeconds = seconds;
    remainingSeconds = seconds;
    isPaused = false;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isPaused) return;
      if (remainingSeconds <= 1) {
        HapticFeedback.mediumImpact();
        unawaited(SoundService.instance.playRestDone());
        _advanceAfterRest(playSound: false);
        return;
      }
      remainingSeconds -= 1;
      notifyListeners();
    });
  }

  void _advanceAfterRest({required bool playSound}) {
    _stopTimer();
    isPaused = false;
    if (playSound) {
      unawaited(SoundService.instance.playRestDone());
    }

    if (phase == WorkoutPhase.restBetweenSets) {
      currentSet += 1;
      phase = WorkoutPhase.active;
      remainingSeconds = 0;
      restDurationSeconds = 0;
      notifyListeners();
      return;
    }

    if (phase == WorkoutPhase.restBetweenExercises) {
      currentExerciseIndex += 1;
      currentSet = 1;
      phase = WorkoutPhase.active;
      remainingSeconds = 0;
      restDurationSeconds = 0;
      notifyListeners();
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
