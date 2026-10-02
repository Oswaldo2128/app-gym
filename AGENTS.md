# AGENTS.md — AppGym

Guía para agentes de IA que trabajan en este repositorio.

## Qué es

AppGym es una app **Flutter** (Android-first, también web) en **español** para entrenar con series, reps y descansos. El usuario elige sesión personalizada o sesiones predefinidas y avanza tocando **Aceptar** al terminar cada serie.

Repo: https://github.com/Oswaldo2128/app-gym

## Stack

- Flutter / Dart (`pubspec.yaml`)
- UI: `google_fonts` (Oswald + Barlow), tema azul en `lib/theme/app_theme.dart`
- Audio: `audioplayers` + `assets/sounds/`
- Sin backend / sin auth

SDK local típico en Windows: `C:\Users\oswal\flutter\bin\flutter.bat`

## Estructura

```
lib/
  main.dart                 # rutas: /, /custom-session, /preset-sessions
  models/                   # catálogo, config, sesión, presets
  screens/                  # welcome → flujos → workout → done
  widgets/gym_scaffold.dart # AppBar + drawer + botón Inicio
  widgets/workout_widgets.dart
  services/sound_service.dart
  theme/app_theme.dart
test/
assets/sounds/
```

## Flujos de producto (no romper)

1. **Bienvenida**: Sesión personalizada | Sesiones definidas  
2. **Personalizada** → ¿grupo muscular?  
   - **Sí** → categoría → setup **con** dropdowns de ejercicio  
   - **No** → setup **sin** selects; en workout solo “Ejercicio N / Serie X”  
3. **Presets** → 3 sesiones fijas → workout directo  
4. Durante workout: Aceptar → descanso entre series (default 60s) o entre ejercicios (90s)  
5. Chrome/shell: menú lateral (Inicio, personalizada, definidas, Salir) + icono Inicio siempre  

`WorkoutConfig.namedExercises` controla si se muestran nombres de ejercicio.

## Convenciones de código

- UI y copy en **español**
- Preferir cambios mínimos y enfocados; no refactors amplios sin pedirlo
- No reintroducir SVG/demos visuales de ejercicio salvo que el usuario lo pida
- Scaffold compartido: usar `GymScaffold` (no AppBars sueltos)
- Extensiones de enums (`MuscleCategoryX`, etc.) viven en `exercise_catalog.dart`; importar ese archivo si se usan `.label`
- Tests: desactivar sonidos con `SoundService.enabled = false`
- No commitear secretos; no tocar `git config`

## Comandos útiles

```bash
flutter analyze
flutter test
flutter run -d chrome --web-port=8080
```

## Cómo trabajar con IA aquí

1. Leer `MEMORY.md` al empezar (estado, decisiones, pendientes).  
2. Seguir este `AGENTS.md` para no romper flujos.  
3. Tras cambios relevantes, **actualizar `MEMORY.md`** (qué cambió, por qué).  
4. Antes de push: `flutter analyze` + `flutter test`.  
5. Commit/push solo si el usuario lo pide.

## Archivos sensibles al producto

| Área | Archivos |
|------|----------|
| Catálogo / equipo | `lib/models/exercise_catalog.dart` |
| Presets | `lib/models/preset_sessions.dart` |
| Lógica de sesión | `lib/models/workout_session.dart`, `workout_config.dart` |
| Navegación / menú | `lib/widgets/gym_scaffold.dart`, `lib/main.dart` |
| Setup personalizado | `lib/screens/setup_screen.dart`, `custom_session_mode_screen.dart` |
