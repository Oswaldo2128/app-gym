import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/custom_session_mode_screen.dart';
import 'screens/preset_sessions_screen.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/gym_scaffold.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const AppGym());
}

class AppGym extends StatelessWidget {
  const AppGym({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppGym',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const WelcomeScreen(),
        AppRoutes.customSession: (_) => const CustomSessionModeScreen(),
        AppRoutes.presetSessions: (_) => const PresetSessionsScreen(),
      },
    );
  }
}
