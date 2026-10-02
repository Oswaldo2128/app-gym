import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/exercise_catalog.dart';
import '../models/workout_config.dart';
import '../theme/app_theme.dart';
import '../widgets/gym_scaffold.dart';
import '../widgets/workout_widgets.dart';
import 'workout_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({
    super.key,
    this.category,
    this.namedExercises = true,
  }) : assert(
          !namedExercises || category != null,
          'category is required when namedExercises is true',
        );

  final MuscleCategory? category;
  final bool namedExercises;

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  late List<WorkoutExerciseSlot> _exercises;
  late int _repsPerSet;
  late int _restBetweenSets;
  late int _restBetweenExercises;
  late List<GymExercise> _catalog;

  bool get _named => widget.namedExercises;

  @override
  void initState() {
    super.initState();
    if (_named) {
      _catalog = ExerciseCatalog.byCategory(widget.category!);
      final defaults = WorkoutConfig.defaultsFor(widget.category!);
      _exercises = List<WorkoutExerciseSlot>.from(defaults.exercises);
      _repsPerSet = defaults.repsPerSet;
      _restBetweenSets = defaults.restBetweenSetsSeconds;
      _restBetweenExercises = defaults.restBetweenExercisesSeconds;
    } else {
      _catalog = const [];
      final defaults = WorkoutConfig.defaultsAnonymous();
      _exercises = List<WorkoutExerciseSlot>.from(defaults.exercises);
      _repsPerSet = defaults.repsPerSet;
      _restBetweenSets = defaults.restBetweenSetsSeconds;
      _restBetweenExercises = defaults.restBetweenExercisesSeconds;
    }
  }

  void _setExerciseCount(int count) {
    setState(() {
      if (count > _exercises.length) {
        _exercises.addAll(
          List.generate(
            count - _exercises.length,
            (i) {
              final id = _named
                  ? _catalog[(_exercises.length + i) % _catalog.length].id
                  : 'flexiones';
              return WorkoutExerciseSlot(
                exerciseId: id,
                sets: 5,
                reps: _repsPerSet,
              );
            },
          ),
        );
      } else if (count < _exercises.length) {
        _exercises = _exercises.sublist(0, count);
      }
    });
  }

  void _start() {
    final config = WorkoutConfig(
      category: widget.category ?? MuscleCategory.pecho,
      namedExercises: _named,
      sessionTitle: _named ? null : 'Sesión personalizada',
      exercises: [
        for (final slot in _exercises) slot.copyWith(reps: _repsPerSet),
      ],
      repsPerSet: _repsPerSet,
      restBetweenSetsSeconds: _restBetweenSets,
      restBetweenExercisesSeconds: _restBetweenExercises,
    );

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            WorkoutScreen(config: config),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween(begin: 0.96, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = _named
        ? widget.category!.label.toUpperCase()
        : 'SIN GRUPO';

    return GymScaffold(
      title: title,
      bottom: ElevatedButton(
        onPressed: _start,
        child: const Text('INICIAR ENTRENAMIENTO'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Text(
                _named
                    ? 'Elige qué harás en cada ejercicio y cuántas series.'
                    : 'Define cuántos ejercicios y series. En la sesión verás solo el número.',
                style: GoogleFonts.barlow(
                  color: AppColors.muted,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                children: [
                    const SectionLabel('Sesión'),
                    const SizedBox(height: 12),
                    ValueStepper(
                      label: 'Cantidad de ejercicios',
                      value: _exercises.length,
                      min: 1,
                      max: 30,
                      onChanged: _setExerciseCount,
                    ),
                    const SizedBox(height: 20),
                    const SectionLabel('Ejercicios'),
                    const SizedBox(height: 12),
                    ...List.generate(_exercises.length, (index) {
                      final slot = _exercises[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Ejercicio ${index + 1}',
                              style: GoogleFonts.oswald(
                                color: AppColors.lime,
                                fontSize: 14,
                                letterSpacing: 1.2,
                              ),
                            ),
                            if (_named) ...[
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                initialValue: slot.exerciseId,
                                isExpanded: true,
                                dropdownColor: AppColors.graphite,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.graphite,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                ),
                                style: GoogleFonts.barlow(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                selectedItemBuilder: (context) {
                                  return [
                                    for (final exercise in _catalog)
                                      Text(
                                        exercise.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ];
                                },
                                items: [
                                  for (final exercise in _catalog)
                                    DropdownMenuItem(
                                      value: exercise.id,
                                      child: Text(
                                        '${exercise.name} · ${exercise.equipment.label}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() {
                                    _exercises[index] =
                                        slot.copyWith(exerciseId: value);
                                  });
                                },
                              ),
                              const SizedBox(height: 6),
                              Text(
                                slot.exercise.equipment.label,
                                style: GoogleFonts.barlow(
                                  color: AppColors.muted,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            ValueStepper(
                              label: 'Series',
                              value: slot.sets,
                              min: 1,
                              max: 30,
                              onChanged: (v) {
                                setState(() {
                                  _exercises[index] = slot.copyWith(sets: v);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    const SectionLabel('Repeticiones'),
                    const SizedBox(height: 12),
                    ValueStepper(
                      label: 'Por serie',
                      value: _repsPerSet,
                      min: 1,
                      max: 50,
                      onChanged: (v) => setState(() => _repsPerSet = v),
                    ),
                    const SizedBox(height: 12),
                    const SectionLabel('Descansos'),
                    const SizedBox(height: 12),
                    ValueStepper(
                      label: 'Entre series',
                      value: _restBetweenSets,
                      min: 15,
                      max: 180,
                      suffix: ' s',
                      onChanged: (v) => setState(() => _restBetweenSets = v),
                    ),
                    const SizedBox(height: 8),
                    ValueStepper(
                      label: 'Entre ejercicios',
                      value: _restBetweenExercises,
                      min: 30,
                      max: 300,
                      suffix: ' s',
                      onChanged: (v) {
                        setState(() => _restBetweenExercises = v);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
