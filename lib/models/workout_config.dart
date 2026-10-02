import 'exercise_catalog.dart';

class WorkoutExerciseSlot {
  const WorkoutExerciseSlot({
    required this.exerciseId,
    required this.sets,
    this.reps = 12,
  });

  final String exerciseId;
  final int sets;
  final int reps;

  GymExercise get exercise => ExerciseCatalog.byId(exerciseId);

  WorkoutExerciseSlot copyWith({String? exerciseId, int? sets, int? reps}) {
    return WorkoutExerciseSlot(
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
    );
  }
}

class WorkoutConfig {
  const WorkoutConfig({
    required this.category,
    required this.exercises,
    required this.repsPerSet,
    required this.restBetweenSetsSeconds,
    required this.restBetweenExercisesSeconds,
    this.sessionTitle,
    this.namedExercises = true,
  });

  final MuscleCategory category;
  final List<WorkoutExerciseSlot> exercises;
  final int repsPerSet;
  final int restBetweenSetsSeconds;
  final int restBetweenExercisesSeconds;
  final String? sessionTitle;
  final bool namedExercises;

  int get exerciseCount => exercises.length;

  int totalSets() => exercises.fold(0, (sum, item) => item.sets + sum);

  List<int> get setsPerExercise =>
      exercises.map((e) => e.sets).toList(growable: false);

  GymExercise exerciseAt(int index) => exercises[index].exercise;

  int repsAt(int index) => exercises[index].reps;

  static WorkoutConfig defaultsFor(MuscleCategory category) {
    final catalog = ExerciseCatalog.byCategory(category);
    final picked = catalog.take(3).toList();
    while (picked.length < 3) {
      picked.add(catalog.first);
    }
    return WorkoutConfig(
      category: category,
      namedExercises: true,
      exercises: [
        for (final item in picked)
          WorkoutExerciseSlot(exerciseId: item.id, sets: 5, reps: 12),
      ],
      repsPerSet: 12,
      restBetweenSetsSeconds: 60,
      restBetweenExercisesSeconds: 90,
    );
  }

  static WorkoutConfig defaultsAnonymous() {
    return WorkoutConfig(
      category: MuscleCategory.pecho,
      namedExercises: false,
      sessionTitle: 'Sesión personalizada',
      exercises: const [
        WorkoutExerciseSlot(exerciseId: 'flexiones', sets: 5, reps: 12),
        WorkoutExerciseSlot(exerciseId: 'flexiones', sets: 5, reps: 12),
        WorkoutExerciseSlot(exerciseId: 'flexiones', sets: 5, reps: 12),
      ],
      repsPerSet: 12,
      restBetweenSetsSeconds: 60,
      restBetweenExercisesSeconds: 90,
    );
  }
}
