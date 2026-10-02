import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/exercise_catalog.dart';
import '../models/workout_config.dart';
import '../theme/app_theme.dart';
import '../widgets/gym_scaffold.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key, required this.config});

  final WorkoutConfig config;

  @override
  Widget build(BuildContext context) {
    final seriesSummary = config.namedExercises
        ? config.exercises
            .map((e) => '${e.exercise.name}: ${e.sets}')
            .join(' · ')
        : [
            for (var i = 0; i < config.exercises.length; i++)
              'Ejercicio ${i + 1}: ${config.exercises[i].sets}',
          ].join(' · ');

    final subtitle = config.sessionTitle != null
        ? '${config.sessionTitle} completada'
        : config.namedExercises
            ? '${config.category.label} completado'
            : 'Sesión completada';

    return GymScaffold(
      title: 'COMPLETADO',
      showBack: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                'LISTO',
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  color: AppColors.lime,
                  fontSize: 64,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4,
                  height: 1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.barlow(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                '${config.exerciseCount} ejercicios · ${config.totalSets()} series · ${config.repsPerSet} reps',
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  color: AppColors.muted,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                seriesSummary,
                textAlign: TextAlign.center,
                style: GoogleFonts.barlow(
                  color: AppColors.muted,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('NUEVO ENTRENAMIENTO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
