import 'exercise_catalog.dart';
import 'workout_config.dart';

class PresetSession {
  const PresetSession({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.config,
  });

  final String id;
  final String title;
  final String subtitle;
  final WorkoutConfig config;

  static const int _restSets = 60;
  static const int _restExercises = 90;

  static final List<PresetSession> all = [
    PresetSession(
      id: 'sesion_1',
      title: 'Sesión 1',
      subtitle: 'Ejercicios de pecho y hombro',
      config: WorkoutConfig(
        category: MuscleCategory.pecho,
        sessionTitle: 'Sesión 1 · Pecho y hombro',
        exercises: const [
          WorkoutExerciseSlot(
            exerciseId: 'press_mancuernas',
            sets: 5,
            reps: 12,
          ),
          WorkoutExerciseSlot(
            exerciseId: 'flexiones',
            sets: 5,
            reps: 8,
          ),
          WorkoutExerciseSlot(
            exerciseId: 'elevaciones_laterales',
            sets: 5,
            reps: 12,
          ),
        ],
        repsPerSet: 12,
        restBetweenSetsSeconds: _restSets,
        restBetweenExercisesSeconds: _restExercises,
      ),
    ),
    PresetSession(
      id: 'sesion_2',
      title: 'Sesión 2',
      subtitle: 'Ejercicios de espalda y brazo',
      config: WorkoutConfig(
        category: MuscleCategory.espalda,
        sessionTitle: 'Sesión 2 · Espalda y brazo',
        exercises: const [
          WorkoutExerciseSlot(
            exerciseId: 'remo_dos_mancuernas',
            sets: 5,
            reps: 12,
          ),
          WorkoutExerciseSlot(
            exerciseId: 'pullover_peso_corporal',
            sets: 5,
            reps: 12,
          ),
          WorkoutExerciseSlot(
            exerciseId: 'curl_martillo',
            sets: 5,
            reps: 12,
          ),
        ],
        repsPerSet: 12,
        restBetweenSetsSeconds: _restSets,
        restBetweenExercisesSeconds: _restExercises,
      ),
    ),
    PresetSession(
      id: 'sesion_3',
      title: 'Sesión 3',
      subtitle: 'Ejercicios de pierna y brazo',
      config: WorkoutConfig(
        category: MuscleCategory.pierna,
        sessionTitle: 'Sesión 3 · Pierna y brazo',
        exercises: const [
          WorkoutExerciseSlot(
            exerciseId: 'sentadilla',
            sets: 5,
            reps: 12,
          ),
          WorkoutExerciseSlot(
            exerciseId: 'desplante',
            sets: 5,
            reps: 12,
          ),
          WorkoutExerciseSlot(
            exerciseId: 'curl_biceps',
            sets: 5,
            reps: 12,
          ),
        ],
        repsPerSet: 12,
        restBetweenSetsSeconds: _restSets,
        restBetweenExercisesSeconds: _restExercises,
      ),
    ),
  ];
}
