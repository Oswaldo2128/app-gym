# MEMORY.md — estado vivo de AppGym

Actualizar este archivo cuando cambien decisiones de producto, arquitectura o pendientes importantes.

Última actualización: 2026-10-02 (README mejorado)

## Resumen

App Flutter de temporizador de entrenamiento. Tema deportivo azul, UI en español. Publicado en GitHub: `Oswaldo2128/app-gym` (rama `main`).

## Decisiones tomadas

| Decisión | Detalle |
|----------|---------|
| Equipo permitido | Solo banco, mancuernas, peso corporal (o combo). Etiquetado con `EquipmentType`. |
| Sin demos SVG | Se quitaron ilustraciones SVG; en workout se muestran nombres (o solo “Ejercicio N”). |
| Personalizada | Primero pregunta si hay grupo muscular; sin grupo → sin dropdowns de ejercicio. |
| Presets | 3 sesiones fijas (pecho/hombro, espalda/brazo, pierna/brazo), 60s / 90s descanso. |
| Reps | Por ejercicio en `WorkoutExerciseSlot.reps` (ej. flexiones 5×8 en sesión 1). |
| Navegación | `GymScaffold`: drawer + botón Inicio en todas las pantallas. |
| Sonidos | start / rest_done / complete en `assets/sounds/`. |
| Defaults setup | ~3 ejercicios, 5 series, 12 reps, 60s entre series, 90s entre ejercicios. Series/ejercicios hasta 30. |

## Presets actuales

1. **Sesión 1** pecho/hombro: press banca 5×12, flexión 5×8, laterales 5×12  
2. **Sesión 2** espalda/brazo: remo mancuernas 5×12, pullover corporal 5×12, curl martillo 5×12  
3. **Sesión 3** pierna/brazo: sentadilla corporal 5×12, desplante 5×12, curl bíceps 5×12  

## Mapa mental de pantallas

```
Welcome
├── CustomSessionMode
│   ├── Sí → Category → Setup(named) → Workout → Done
│   └── No → Setup(anonymous) → Workout → Done
└── PresetSessions → Workout → Done
```

## Remote / git

- `origin` → https://github.com/Oswaldo2128/app-gym.git  
- Rama principal: `main`

## Pendientes / ideas (backlog)

- [x] Mejorar README del repo (dejar de ser el template de Flutter)
- [ ] Persistencia local de sesiones personalizadas del usuario
- [ ] Build/release Android (keystore, icono final)
- [ ] Posible historial de entrenamientos

## Notas para la IA

- Preferir español en mensajes al usuario y en copy de la app.  
- Al añadir ejercicios: actualizar catálogo + presets si aplica + tests.  
- Al cambiar navegación: mantener `AppRoutes` en sync con `main.dart` y el drawer.  
- Web en Chrome suele usar `--web-port=8080`.  
- `gh` CLI puede no estar instalado en la máquina del usuario; `git push` sí funciona.
