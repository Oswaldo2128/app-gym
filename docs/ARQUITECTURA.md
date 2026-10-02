# Arquitectura AppGym

## Capas

```
UI (screens + widgets)
        ↓
WorkoutSession (ChangeNotifier, timer, fases)
        ↓
WorkoutConfig + slots (inmutable por sesión)
        ↓
ExerciseCatalog / PresetSession (datos estáticos)
```

No hay persistencia ni red. Todo el estado de un entrenamiento vive en memoria en `WorkoutSession`.

## Modelos clave

### `GymExercise` (`exercise_catalog.dart`)

- `id`, `name`, `category`, `motion`, `cue`, `equipment`
- Categorías: pecho, espalda, pierna, hombro, brazo, core
- Equipo: `bodyweight`, `dumbbells`, `benchDumbbells`, `benchBodyweight`, `dumbbellsBodyweight`

### `WorkoutExerciseSlot` (`workout_config.dart`)

- `exerciseId`, `sets`, `reps` (reps por ejercicio)
- En modo anónimo el `exerciseId` es placeholder (no se muestra)

### `WorkoutConfig`

| Campo | Uso |
|-------|-----|
| `category` | Grupo muscular (o placeholder si anónimo) |
| `exercises` | Lista de slots |
| `repsPerSet` | Resumen / default global (setup aplica a slots) |
| `restBetweenSetsSeconds` | Descanso intra-ejercicio |
| `restBetweenExercisesSeconds` | Descanso al cambiar de ejercicio |
| `sessionTitle` | Título opcional (presets / anónimo) |
| `namedExercises` | `true` = mostrar nombres; `false` = “Ejercicio N” |

### `WorkoutSession` (`workout_session.dart`)

Fases (`WorkoutPhase`):

1. `active` — usuario hace la serie  
2. `restBetweenSets` — timer; luego `currentSet++`  
3. `restBetweenExercises` — timer; luego siguiente ejercicio, set = 1  
4. `completed` — navega a `DoneScreen`

Acciones: `completeSet`, `skipRest`, `restartRest`, `togglePause`, `abandon`.

### `PresetSession` (`preset_sessions.dart`)

Lista estática `PresetSession.all` con 3 configs listas.

## Navegación

Rutas nombradas (`AppRoutes` en `gym_scaffold.dart`):

| Ruta | Pantalla |
|------|----------|
| `/` | `WelcomeScreen` |
| `/custom-session` | `CustomSessionModeScreen` |
| `/preset-sessions` | `PresetSessionsScreen` |

El resto se apila con `Navigator.push` / `PageRouteBuilder` (category, setup, workout, done).

`DoneScreen` usa `pushReplacement` desde workout. “Nuevo entrenamiento” / Inicio: `popUntil` first.

### Shell UI

`GymScaffold`:

- `drawer: GymDrawer`
- actions: atrás (si aplica) + home
- `confirmBeforeLeave` en workout

## Pantallas

| Archivo | Rol |
|---------|-----|
| `welcome_screen.dart` | Dos CTAs principales |
| `custom_session_mode_screen.dart` | ¿Grupo muscular? |
| `category_screen.dart` | Grid de grupos |
| `setup_screen.dart` | Config (named o anonymous) |
| `preset_sessions_screen.dart` | Lista de 3 presets |
| `workout_screen.dart` | Fase activa + timer |
| `done_screen.dart` | Resumen |

## Widgets / servicios

- `ValueStepper` — enteros con ± y campo de texto  
- `TimerRing`, `BigStat`, `SectionLabel`  
- `SoundService` — `start.wav`, `rest_done.wav`, `complete.wav`; `enabled = false` en tests  
- Tema: `AppTheme.dark()`, acento `AppColors.lime` (= azul `#3BA4FF`)

## Tests

- `test/workout_session_test.dart` — avance de fases y restart de descanso  
- `test/widget_test.dart` — welcome → personalizada / presets / sin grupo  

## Dónde tocar para tareas comunes

| Quiero… | Archivo(s) |
|---------|------------|
| Añadir ejercicio al catálogo | `exercise_catalog.dart` |
| Cambiar un preset | `preset_sessions.dart` |
| Cambiar lógica de descanso/series | `workout_session.dart` |
| Cambiar copy de setup | `setup_screen.dart` |
| Menú / Inicio | `gym_scaffold.dart` |
| Tema / colores | `app_theme.dart` |
