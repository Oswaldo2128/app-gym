import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

/// Rutas globales de navegación.
abstract final class AppRoutes {
  static const home = '/';
  static const customSession = '/custom-session';
  static const presetSessions = '/preset-sessions';
}

Future<void> goToHome(
  BuildContext context, {
  Future<bool> Function()? confirmBeforeLeave,
}) async {
  if (confirmBeforeLeave != null) {
    final ok = await confirmBeforeLeave();
    if (!ok || !context.mounted) return;
  }
  if (!context.mounted) return;
  Navigator.of(context).popUntil((route) => route.isFirst);
}

Future<bool> confirmLeaveWorkout(BuildContext context) async {
  final leave = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.graphite,
        title: Text(
          '¿Salir de la sesión?',
          style: GoogleFonts.oswald(color: AppColors.white),
        ),
        content: Text(
          'Se perderá el progreso de este entrenamiento.',
          style: GoogleFonts.barlow(color: AppColors.muted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Salir',
              style: GoogleFonts.barlow(color: AppColors.danger),
            ),
          ),
        ],
      );
    },
  );
  return leave == true;
}

class GymDrawer extends StatelessWidget {
  const GymDrawer({
    super.key,
    this.confirmBeforeLeave,
  });

  final Future<bool> Function()? confirmBeforeLeave;

  Future<void> _leaveThen(BuildContext context, VoidCallback action) async {
    if (confirmBeforeLeave != null) {
      final ok = await confirmBeforeLeave!();
      if (!ok || !context.mounted) return;
    }
    if (!context.mounted) return;
    Navigator.of(context).pop();
    action();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.charcoal,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'APPGYM',
                style: GoogleFonts.oswald(
                  color: AppColors.lime,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Text(
                'Menú',
                style: GoogleFonts.barlow(
                  color: AppColors.muted,
                  fontSize: 15,
                ),
              ),
            ),
            const Divider(color: AppColors.graphite, height: 1),
            _DrawerTile(
              icon: Icons.home_outlined,
              label: 'Inicio',
              onTap: () => _leaveThen(context, () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
            ),
            _DrawerTile(
              icon: Icons.tune,
              label: 'Sesión personalizada',
              onTap: () => _leaveThen(context, () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushNamed(AppRoutes.customSession);
              }),
            ),
            _DrawerTile(
              icon: Icons.list_alt,
              label: 'Sesiones definidas',
              onTap: () => _leaveThen(context, () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushNamed(AppRoutes.presetSessions);
              }),
            ),
            const Spacer(),
            const Divider(color: AppColors.graphite, height: 1),
            _DrawerTile(
              icon: Icons.logout,
              label: 'Salir',
              danger: true,
              onTap: () async {
                if (confirmBeforeLeave != null) {
                  final ok = await confirmBeforeLeave!();
                  if (!ok || !context.mounted) return;
                }
                if (context.mounted) Navigator.of(context).pop();
                await SystemNavigator.pop();
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.danger : AppColors.white;
    return ListTile(
      leading: Icon(icon, color: danger ? AppColors.danger : AppColors.lime),
      title: Text(
        label,
        style: GoogleFonts.barlow(
          color: color,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}

class GymScaffold extends StatelessWidget {
  const GymScaffold({
    super.key,
    required this.body,
    this.title,
    this.showBack = true,
    this.confirmBeforeLeave,
    this.bottom,
  });

  final Widget body;
  final String? title;
  final bool showBack;
  final Future<bool> Function()? confirmBeforeLeave;
  final Widget? bottom;

  Future<void> _onBack(BuildContext context) async {
    if (confirmBeforeLeave != null) {
      final ok = await confirmBeforeLeave!();
      if (!ok || !context.mounted) return;
    }
    if (context.mounted) Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return SportBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: GymDrawer(confirmBeforeLeave: confirmBeforeLeave),
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: AppColors.muted),
                tooltip: 'Menú',
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          title: title == null ? null : Text(title!),
          actions: [
            if (showBack && canPop)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.muted),
                tooltip: 'Atrás',
                onPressed: () => _onBack(context),
              ),
            IconButton(
              icon: const Icon(Icons.home_outlined, color: AppColors.lime),
              tooltip: 'Inicio',
              onPressed: () => goToHome(
                context,
                confirmBeforeLeave: confirmBeforeLeave,
              ),
            ),
          ],
        ),
        body: body,
        bottomNavigationBar: bottom == null
            ? null
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: bottom,
                ),
              ),
      ),
    );
  }
}
