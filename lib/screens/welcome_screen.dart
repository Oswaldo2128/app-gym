import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import '../widgets/gym_scaffold.dart';
import 'custom_session_mode_screen.dart';
import 'preset_sessions_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(Widget screen) {
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
      showBack: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 8, 28, 28),
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    'APPGYM',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                      color: AppColors.lime,
                      fontSize: 64,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 6,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Entrena con ritmo',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                      color: AppColors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Crea tu sesión o elige una ya definida.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.barlow(
                      color: AppColors.muted,
                      fontSize: 17,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(flex: 3),
                  ElevatedButton(
                    onPressed: () => _goTo(const CustomSessionModeScreen()),
                    child: const Text('SESIÓN PERSONALIZADA'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => _goTo(const PresetSessionsScreen()),
                    child: const Text('SESIONES DEFINIDAS'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
