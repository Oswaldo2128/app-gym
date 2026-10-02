# MEMORY.md — estado vivo de AppGym

Actualizar este archivo cuando cambien decisiones de producto, arquitectura o pendientes importantes.

Última actualización: 2026-10-02 (docs/ de contexto para IA)

## Onboarding rápido (agente)

1. Leer este archivo  
2. Leer [AGENTS.md](AGENTS.md)  
3. Si falta contexto histórico: [docs/HISTORIA.md](docs/HISTORIA.md)  
4. Si vas a tocar código: [docs/ARQUITECTURA.md](docs/ARQUITECTURA.md)  
5. Índice: [docs/README.md](docs/README.md)

## Resumen

App Flutter de temporizador de entrenamiento. Tema deportivo azul, UI en español.  
Repo: https://github.com/Oswaldo2128/app-gym · rama `main`.

**Estado del producto:** usable end-to-end (personalizada con/sin grupo, 3 presets, workout con dos descansos, menú + inicio, sonidos). Sin persistencia ni backend.

## Decisiones tomadas

| Decisión | Detalle |
|----------|---------|
| Equipo permitido | Solo banco, mancuernas, peso corporal (o combo). `EquipmentType`. |
| Sin demos SVG | Quitadas; workout muestra nombres o “Ejercicio N”. |
| Personalizada | Pregunta grupo muscular; sin grupo → sin dropdowns. |
| Presets | 3 sesiones fijas, 60s / 90s. |
| Reps | Por ejercicio (`WorkoutExerciseSlot.reps`). |
| Navegación | `GymScaffold`: drawer + Inicio siempre. |
| Sonidos | `assets/sounds/` start, rest_done, complete. |
| Defaults setup | 3 ejercicios · 5 series · 12 reps · 60s / 90s · máx 30. |
| Docs IA | `AGENTS.md`, `MEMORY.md`, `docs/*`, `.cursor/rules/appgym.mdc`. |

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
- Rama: `main`  
- Entorno: Windows; a veces hace falta `required_permissions: all` en la shell del agente  
- `gh` puede no estar instalado; usar `git push`

## Pendientes / ideas (backlog)

- [x] Mejorar README del repo  
- [x] Documentación de contexto para IA (`docs/`)  
- [ ] Persistencia local de sesiones personalizadas del usuario  
- [ ] Build/release Android (keystore, icono final)  
- [ ] Historial de entrenamientos  
- [ ] (Opcional) pulir iconos / branding de launcher

## Notas operativas

- Preferir español en UI y respuestas al usuario.  
- Al añadir ejercicios: catálogo + presets si aplica + tests.  
- Rutas del drawer ↔ `AppRoutes` ↔ `main.dart`.  
- Web de prueba: `flutter run -d chrome --web-port=8080`.  
- Tests: `SoundService.enabled = false`.
