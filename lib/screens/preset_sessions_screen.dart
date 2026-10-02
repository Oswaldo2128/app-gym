import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/preset_sessions.dart';
import '../theme/app_theme.dart';
import '../widgets/gym_scaffold.dart';
import 'workout_screen.dart';

class PresetSessionsScreen extends StatelessWidget {
  const PresetSessionsScreen({super.key});

  void _start(BuildContext context, PresetSession preset) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            WorkoutScreen(config: preset.config),
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
    return GymScaffold(
      title: 'SESIONES DEFINIDAS',
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          itemCount: PresetSession.all.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final preset = PresetSession.all[index];
            return _PresetCard(
              preset: preset,
              onStart: () => _start(context, preset),
            );
          },
        ),
      ),
    );
  }
}

class _PresetCard extends StatelessWidget {
  const _PresetCard({required this.preset, required this.onStart});

  final PresetSession preset;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final config = preset.config;
    return Material(
      color: AppColors.graphite,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onStart,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                preset.title.toUpperCase(),
                style: GoogleFonts.oswald(
                  color: AppColors.lime,
                  fontSize: 18,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                preset.subtitle,
                style: GoogleFonts.oswald(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              for (var i = 0; i < config.exercises.length; i++) ...[
                if (i > 0) const SizedBox(height: 8),
                Text(
                  'Ejercicio ${i + 1} · ${config.exercises[i].exercise.name} '
                  '${config.exercises[i].sets}x${config.exercises[i].reps}',
                  style: GoogleFonts.barlow(
                    color: AppColors.muted,
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                'Descanso series 1 min · entre ejercicios 1 min 30 s',
                style: GoogleFonts.barlow(
                  color: AppColors.lime.withValues(alpha: 0.85),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'INICIAR →',
                  style: GoogleFonts.oswald(
                    color: AppColors.lime,
                    fontSize: 15,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
