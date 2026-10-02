# Historia del desarrollo (contexto para retomar)

Cronología condensada de lo construido hasta 2026-10-02. No es un changelog git exhaustivo; es memoria de producto.

## Origen

Se pidió una app Flutter (prioridad Android) en español, estilo deportivo, con:

- Cantidad configurable de ejercicios
- Series y repeticiones
- **Dos descansos distintos**: entre series vs entre ejercicios
- Flujo por tap: el usuario marca la serie terminada y arranca el descanso

SDK Flutter instalado localmente en Windows (`C:\Users\oswal\flutter`) porque no estaba en el PATH.

## Evolución por etapas

### 1. Núcleo del temporizador

- Modelos `WorkoutConfig` + `WorkoutSession` con fases: `active`, `restBetweenSets`, `restBetweenExercises`, `completed`
- Pantalla de configuración (ejercicios, series, reps, descansos)
- Pantalla de workout con Aceptar / pausar / saltar / reiniciar temporizador
- Pantalla de completado + haptics/sonidos al fin de descanso
- Límites: series y ejercicios hasta **30**
- Defaults: **3** ejercicios, **5** series, **12** reps, **60 s** / **90 s**

### 2. UX de entrada

- Pantalla de bienvenida (antes un solo “Comenzar”)
- Categorías musculares (pecho, espalda, pierna, hombro, brazo, core)
- Selección de ejercicio por slot desde catálogo
- Intentos de demos visuales: animaciones → fotos de internet (fallaron) → **SVGs locales** → **eliminados** a petición del usuario (“solo nombres”)

### 3. Restricción de equipo

Solo ejercicios con **banco**, **mancuernas**, **peso corporal** o combinación.  
`EquipmentType` + etiquetas en UI. Catálogo curado; se añadieron movimientos como pullover, step-up, sentadilla/desplante corporal, etc.

### 4. Sesiones definidas vs personalizada

Bienvenida con **dos botones**:

- Sesión personalizada  
- Sesiones definidas (3 presets fijos; ver `MEMORY.md`)

Presets van directo a workout. Reps pueden variar por ejercicio (ej. flexiones 5×8).

### 5. Personalizada con/sin grupo muscular

Antes del setup:

- **Sí, elegir grupo** → categoría + dropdowns de ejercicio  
- **No, sin grupo** → sin selects; en workout/done solo “Ejercicio N” y series  

Flag: `WorkoutConfig.namedExercises`.

### 6. Navegación global

`GymScaffold` en todas las pantallas:

- Drawer: Inicio, personalizada, definidas, Salir  
- Botón Inicio siempre  
- En workout, salir/inicio pide confirmación (se pierde progreso)

### 7. Tema y controles

- Tema oscuro con acento **azul** (`AppColors.lime` es el nombre histórico del acento; el color es azul eléctrico)
- Inputs numéricos con steppers (±), no sliders
- Fuentes Oswald + Barlow

### 8. Repo y docs para IA

- GitHub: https://github.com/Oswaldo2128/app-gym (`main`)
- Añadidos `AGENTS.md`, `MEMORY.md`, regla `.cursor/rules/appgym.mdc`
- README de producto (ya no es el template de Flutter)
- Esta carpeta `docs/` para retomar contexto

## Decisiones explícitas del usuario (respetar)

| Pedido | Estado |
|--------|--------|
| Descansos distintos serie vs ejercicio | Hecho |
| Flujo por Aceptar (no auto-avanzar series) | Hecho |
| Solo banco / mancuernas / peso corporal | Hecho |
| Quitar SVG, solo nombres | Hecho |
| Presets 1–3 con ejercicios concretos | Hecho |
| Personalizada: preguntar grupo muscular | Hecho |
| Menú lateral + ir a inicio siempre | Hecho |
| Documentar para IA | En curso (este árbol `docs/`) |

## Cosas que se probaron y se descartaron

- Imágenes remotas Wikimedia (fallos de carga/red)
- Paquete `flutter_svg` + assets SVG por ejercicio (eliminados del producto)
- Un solo botón “Comenzar” sin bifurcación personalizada/presets
