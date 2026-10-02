import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import '../widgets/gym_scaffold.dart';
import 'category_screen.dart';
import 'setup_screen.dart';

class CustomSessionModeScreen extends StatelessWidget {
  const CustomSessionModeScreen({super.key});

  void _goTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.04, 0),
                end: Offset.zero,
              ).animate(animation),
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
      title: 'SESIÓN PERSONALIZADA',
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '¿Quieres elegir grupo muscular?',
                style: GoogleFonts.oswald(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Con grupo eliges el ejercicio de un catálogo. '
                'Sin grupo solo defines ejercicios y series por número.',
                style: GoogleFonts.barlow(
                  color: AppColors.muted,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _goTo(context, const CategoryScreen()),
                child: const Text('SÍ, ELEGIR GRUPO'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => _goTo(
                  context,
                  const SetupScreen(namedExercises: false),
                ),
                child: const Text('NO, SIN GRUPO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
