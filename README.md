# AppGym

Temporizador de entrenamiento en Flutter: series, repeticiones y descansos en un solo flujo. Interfaz en español, pensada para Android (también corre en web).

**Repo:** [github.com/Oswaldo2128/app-gym](https://github.com/Oswaldo2128/app-gym)

## Qué hace

- Eliges una **sesión personalizada** o una de las **3 sesiones definidas**.
- En cada serie tocas **Aceptar** cuando terminas; arranca el descanso.
- Hay dos tipos de descanso: **entre series** y **entre ejercicios**.
- Menú lateral e **Inicio** disponibles en cualquier pantalla.

Equipamiento contemplado en el catálogo: **banco**, **mancuernas** y/o **peso corporal**.

## Sesiones definidas

| Sesión | Enfoque | Ejercicios |
|--------|---------|------------|
| 1 | Pecho y hombro | Press banca 5×12 · Flexión 5×8 · Laterales 5×12 |
| 2 | Espalda y brazo | Remo 5×12 · Pullover corporal 5×12 · Curl martillo 5×12 |
| 3 | Pierna y brazo | Sentadilla 5×12 · Desplante 5×12 · Curl bíceps 5×12 |

Descansos por defecto en presets: **60 s** entre series · **90 s** entre ejercicios.

## Sesión personalizada

1. ¿Quieres elegir **grupo muscular**?
2. **Sí** → pecho, espalda, pierna, hombro, brazo o core → eliges ejercicios del catálogo y series.
3. **No** → solo defines cantidad de ejercicios, series, reps y descansos; en la sesión verás “Ejercicio 1”, “Serie X”, etc.

Valores típicos al configurar: hasta **30** ejercicios, **30** series por ejercicio, reps y descansos ajustables.

## Requisitos

- [Flutter](https://docs.flutter.dev/get-started/install) (SDK compatible con `sdk: ^3.13.5` en `pubspec.yaml`)
- Chrome (para web) o un dispositivo/emulador Android

## Cómo correr

```bash
git clone https://github.com/Oswaldo2128/app-gym.git
cd app-gym
flutter pub get
flutter run -d chrome --web-port=8080   # web
# o
flutter run -d android                  # Android
```

### Calidad

```bash
flutter analyze
flutter test
```

## Estructura del proyecto

```
lib/
  main.dart              # app + rutas
  models/                # catálogo, config, sesión, presets
  screens/               # welcome, setup, workout, done, etc.
  widgets/               # GymScaffold, steppers, timer
  services/              # sonidos
  theme/                 # colores y tipografía
assets/sounds/           # start, rest_done, complete
test/
```

## Stack

| Pieza | Uso |
|-------|-----|
| Flutter / Dart | App |
| `google_fonts` | Oswald + Barlow |
| `audioplayers` | Sonidos de inicio, fin de descanso y completado |

Sin backend ni autenticación: todo corre en el cliente.

## Desarrollo con IA

Para retomar contexto (humano o agente):

| Doc | Contenido |
|-----|-----------|
| [`MEMORY.md`](MEMORY.md) | Estado actual, decisiones, backlog |
| [`AGENTS.md`](AGENTS.md) | Reglas de trabajo del agente |
| [`docs/`](docs/README.md) | Historia + arquitectura |

Orden sugerido: **MEMORY → AGENTS → docs/HISTORIA → docs/ARQUITECTURA**.

## Licencia

Uso privado del autor del repositorio salvo que se indique lo contrario.
