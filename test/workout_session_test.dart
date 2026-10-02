import 'package:flutter_test/flutter_test.dart';

import 'package:app_gym/models/exercise_catalog.dart';
import 'package:app_gym/models/workout_config.dart';
import 'package:app_gym/models/workout_session.dart';
import 'package:app_gym/services/sound_service.dart';

void main() {
  setUp(() {
    SoundService.enabled = false;
  });

  test('advances sets then exercises with distinct rest phases', () {
    final config = WorkoutConfig(
      category: MuscleCategory.pecho,
      exercises: const [
        WorkoutExerciseSlot(exerciseId: 'press_mancuernas', sets: 2),
        WorkoutExerciseSlot(exerciseId: 'aperturas', sets: 1),
      ],
      repsPerSet: 12,
      restBetweenSetsSeconds: 30,
      restBetweenExercisesSeconds: 90,
    );
    final session = WorkoutSession(config);

    expect(session.phase, WorkoutPhase.active);
    expect(session.exerciseNumber, 1);
    expect(session.currentSet, 1);

    session.completeSet();
    expect(session.phase, WorkoutPhase.restBetweenSets);
    expect(session.remainingSeconds, 30);

    session.skipRest();
    expect(session.phase, WorkoutPhase.active);
    expect(session.currentSet, 2);

    session.completeSet();
    expect(session.phase, WorkoutPhase.restBetweenExercises);
    expect(session.remainingSeconds, 90);

    session.remainingSeconds = 40;
    session.restartRest();
    expect(session.phase, WorkoutPhase.restBetweenExercises);
    expect(session.remainingSeconds, 90);
    expect(session.isPaused, isFalse);

    session.skipRest();
    expect(session.phase, WorkoutPhase.active);
    expect(session.exerciseNumber, 2);
    expect(session.currentSet, 1);
    expect(session.setsForCurrent, 1);
    expect(config.exerciseAt(1).name, 'Aperturas con mancuernas');
    expect(config.repsAt(1), 12);

    session.completeSet();
    expect(session.phase, WorkoutPhase.completed);

    session.dispose();
  });
}
