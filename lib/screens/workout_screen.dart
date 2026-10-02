import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/workout_config.dart';
import '../models/workout_session.dart';
import '../services/sound_service.dart';
import '../theme/app_theme.dart';
import '../widgets/gym_scaffold.dart';
import '../widgets/workout_widgets.dart';
import 'done_screen.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key, required this.config});

  final WorkoutConfig config;

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late final WorkoutSession _session;

  @override
  void initState() {
    super.initState();
    _session = WorkoutSession(widget.config);
    _session.addListener(_onSessionChanged);
    SoundService.instance.playStart();
  }

  void _onSessionChanged() {
    if (!mounted) return;
    if (_session.isCompleted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              DoneScreen(config: widget.config),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
      return;
    }
    setState(() {});
  }

  Future<bool> _confirmLeave() async {
    final leave = await confirmLeaveWorkout(context);
    if (leave) _session.abandon();
    return leave;
  }

  @override
  void dispose() {
    _session.removeListener(_onSessionChanged);
    _session.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = _session;
    final named = widget.config.namedExercises;

    return GymScaffold(
      title: session.phaseLabel.toUpperCase(),
      confirmBeforeLeave: _confirmLeave,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            children: [
              if (!session.isResting && named)
                Text(
                  widget.config
                      .exerciseAt(session.currentExerciseIndex)
                      .name
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oswald(
                    color: AppColors.lime,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                )
              else if (session.isResting)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BigStat(
                      caption: 'Ejercicio',
                      value:
                          '${session.exerciseNumber}/${session.exerciseCount}',
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.graphite,
                    ),
                    BigStat(
                      caption: 'Serie',
                      value: '${session.currentSet}/${session.setsForCurrent}',
                    ),
                  ],
                ),
              const Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 320),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween(begin: 0.94, end: 1.0).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: session.isResting
                    ? TimerRing(
                        key: ValueKey(
                          '${session.phase}-${session.restDurationSeconds}',
                        ),
                        progress: session.restProgress,
                        label: session.phaseLabel,
                        timeText: formatMmSs(session.remainingSeconds),
                      )
                    : _ActivePhase(
                        key: ValueKey(
                          'active-${session.exerciseNumber}-${session.currentSet}',
                        ),
                        exerciseName: named
                            ? widget.config
                                .exerciseAt(session.currentExerciseIndex)
                                .name
                            : null,
                        exerciseNumber: session.exerciseNumber,
                        exerciseCount: session.exerciseCount,
                        set: session.currentSet,
                        setCount: session.setsForCurrent,
                        reps: widget.config
                            .repsAt(session.currentExerciseIndex),
                      ),
              ),
              const Spacer(),
              if (session.isResting) ...[
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: session.togglePause,
                        icon: Icon(
                          session.isPaused ? Icons.play_arrow : Icons.pause,
                        ),
                        label: Text(
                          session.isPaused ? 'Reanudar' : 'Pausar',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: session.skipRest,
                        icon: const Icon(Icons.skip_next),
                        label: const Text('Saltar'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: session.restartRest,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reiniciar temporizador'),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: session.completeSet,
                  child: const Text('ACEPTAR'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Toca Aceptar cuando termines la serie',
                  style: GoogleFonts.barlow(
                    color: AppColors.muted,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivePhase extends StatelessWidget {
  const _ActivePhase({
    super.key,
    required this.exerciseName,
    required this.exerciseNumber,
    required this.exerciseCount,
    required this.set,
    required this.setCount,
    required this.reps,
  });

  final String? exerciseName;
  final int exerciseNumber;
  final int exerciseCount;
  final int set;
  final int setCount;
  final int reps;

  @override
  Widget build(BuildContext context) {
    final title = exerciseName ?? 'Ejercicio $exerciseNumber';

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.oswald(
            color: AppColors.white,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
        if (exerciseName != null) ...[
          const SizedBox(height: 16),
          Text(
            'Ejercicio $exerciseNumber de $exerciseCount',
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(
              color: AppColors.lime,
              fontSize: 16,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ] else ...[
          const SizedBox(height: 10),
          Text(
            'de $exerciseCount',
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(
              color: AppColors.lime,
              fontSize: 16,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const SizedBox(height: 6),
        Text(
          'Serie $set de $setCount · $reps reps',
          textAlign: TextAlign.center,
          style: GoogleFonts.oswald(
            color: AppColors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ],
    );
  }
}
