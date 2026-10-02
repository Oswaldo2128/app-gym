import 'package:flutter/material.dart';

enum MuscleCategory {
  pecho,
  espalda,
  pierna,
  hombro,
  brazo,
  core,
}

enum MotionStyle {
  press,
  pull,
  squat,
  hinge,
  raise,
  curl,
  crunch,
  fly,
}

enum EquipmentType {
  bodyweight,
  dumbbells,
  benchDumbbells,
  benchBodyweight,
  dumbbellsBodyweight,
}

extension EquipmentTypeX on EquipmentType {
  String get label {
    switch (this) {
      case EquipmentType.bodyweight:
        return 'Peso corporal';
      case EquipmentType.dumbbells:
        return 'Mancuernas';
      case EquipmentType.benchDumbbells:
        return 'Banco + mancuernas';
      case EquipmentType.benchBodyweight:
        return 'Banco + peso corporal';
      case EquipmentType.dumbbellsBodyweight:
        return 'Mancuernas o peso corporal';
    }
  }
}

extension MuscleCategoryX on MuscleCategory {
  String get label {
    switch (this) {
      case MuscleCategory.pecho:
        return 'Pecho';
      case MuscleCategory.espalda:
        return 'Espalda';
      case MuscleCategory.pierna:
        return 'Pierna';
      case MuscleCategory.hombro:
        return 'Hombro';
      case MuscleCategory.brazo:
        return 'Brazo';
      case MuscleCategory.core:
        return 'Core';
    }
  }

  String get subtitle => 'Banco, mancuernas o peso corporal';

  IconData get icon {
    switch (this) {
      case MuscleCategory.pecho:
        return Icons.fitness_center;
      case MuscleCategory.espalda:
        return Icons.accessibility_new;
      case MuscleCategory.pierna:
        return Icons.directions_run;
      case MuscleCategory.hombro:
        return Icons.sports_gymnastics;
      case MuscleCategory.brazo:
        return Icons.back_hand;
      case MuscleCategory.core:
        return Icons.self_improvement;
    }
  }
}

class GymExercise {
  const GymExercise({
    required this.id,
    required this.name,
    required this.category,
    required this.motion,
    required this.cue,
    required this.equipment,
  });

  final String id;
  final String name;
  final MuscleCategory category;
  final MotionStyle motion;
  final String cue;
  final EquipmentType equipment;
}

/// Mejores ejercicios con banco, mancuernas y/o peso corporal.
class ExerciseCatalog {
  static const List<GymExercise> all = [
    // Pecho
    GymExercise(
      id: 'press_mancuernas',
      name: 'Press de banca con mancuernas',
      category: MuscleCategory.pecho,
      motion: MotionStyle.press,
      cue: 'Baja controlado al pecho y empuja fuerte',
      equipment: EquipmentType.benchDumbbells,
    ),
    GymExercise(
      id: 'press_inclinado_mancuernas',
      name: 'Press inclinado con mancuernas',
      category: MuscleCategory.pecho,
      motion: MotionStyle.press,
      cue: 'Banco a 30-45°. Enfoca pecho alto',
      equipment: EquipmentType.benchDumbbells,
    ),
    GymExercise(
      id: 'aperturas',
      name: 'Aperturas con mancuernas',
      category: MuscleCategory.pecho,
      motion: MotionStyle.fly,
      cue: 'Abre en arco amplio y junta arriba',
      equipment: EquipmentType.benchDumbbells,
    ),
    GymExercise(
      id: 'flexiones',
      name: 'Flexión de peso corporal',
      category: MuscleCategory.pecho,
      motion: MotionStyle.press,
      cue: 'Cuerpo recto, pecho cerca del piso',
      equipment: EquipmentType.bodyweight,
    ),
    GymExercise(
      id: 'fondos_banco',
      name: 'Fondos en banco',
      category: MuscleCategory.pecho,
      motion: MotionStyle.press,
      cue: 'Manos en el banco, baja y empuja',
      equipment: EquipmentType.benchBodyweight,
    ),
    // Espalda
    GymExercise(
      id: 'remo_mancuerna',
      name: 'Remo a una mano',
      category: MuscleCategory.espalda,
      motion: MotionStyle.pull,
      cue: 'Rodilla y mano en banco, tira a la cadera',
      equipment: EquipmentType.benchDumbbells,
    ),
    GymExercise(
      id: 'remo_dos_mancuernas',
      name: 'Remo con mancuernas',
      category: MuscleCategory.espalda,
      motion: MotionStyle.pull,
      cue: 'Inclínate, codos cerca y aprieta espalda',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'pullover_mancuerna',
      name: 'Pullover con mancuerna',
      category: MuscleCategory.espalda,
      motion: MotionStyle.pull,
      cue: 'En banco, lleva la mancuerna atrás y adelante',
      equipment: EquipmentType.benchDumbbells,
    ),
    GymExercise(
      id: 'pullover_peso_corporal',
      name: 'Pullover de peso corporal',
      category: MuscleCategory.espalda,
      motion: MotionStyle.pull,
      cue: 'Brazos extendidos atrás y adelante con control',
      equipment: EquipmentType.bodyweight,
    ),
    GymExercise(
      id: 'peso_muerto_mancuernas',
      name: 'Peso muerto con mancuernas',
      category: MuscleCategory.espalda,
      motion: MotionStyle.hinge,
      cue: 'Cadera atrás, espalda neutra',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'superman',
      name: 'Superman',
      category: MuscleCategory.espalda,
      motion: MotionStyle.raise,
      cue: 'Levanta pecho y piernas a la vez',
      equipment: EquipmentType.bodyweight,
    ),
    // Pierna
    GymExercise(
      id: 'sentadilla',
      name: 'Sentadilla de peso corporal',
      category: MuscleCategory.pierna,
      motion: MotionStyle.squat,
      cue: 'Baja profunda, pecho alto',
      equipment: EquipmentType.bodyweight,
    ),
    GymExercise(
      id: 'desplante',
      name: 'Desplante de peso corporal',
      category: MuscleCategory.pierna,
      motion: MotionStyle.squat,
      cue: 'Paso largo, rodilla estable',
      equipment: EquipmentType.bodyweight,
    ),
    GymExercise(
      id: 'sentadilla_goblet',
      name: 'Sentadilla goblet',
      category: MuscleCategory.pierna,
      motion: MotionStyle.squat,
      cue: 'Mancuerna al pecho, baja profunda',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'zancadas',
      name: 'Zancadas con mancuernas',
      category: MuscleCategory.pierna,
      motion: MotionStyle.squat,
      cue: 'Paso largo, rodilla estable',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'sentadilla_bulgara',
      name: 'Sentadilla búlgara',
      category: MuscleCategory.pierna,
      motion: MotionStyle.squat,
      cue: 'Pie trasero en banco, baja controlado',
      equipment: EquipmentType.benchDumbbells,
    ),
    GymExercise(
      id: 'peso_muerto_rumano',
      name: 'Peso muerto rumano',
      category: MuscleCategory.pierna,
      motion: MotionStyle.hinge,
      cue: 'Empuja cadera atrás, siente femorales',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'puente_gluteos',
      name: 'Puente / hip thrust',
      category: MuscleCategory.pierna,
      motion: MotionStyle.hinge,
      cue: 'Empuja cadera arriba; opcional mancuerna',
      equipment: EquipmentType.dumbbellsBodyweight,
    ),
    GymExercise(
      id: 'step_up_banco',
      name: 'Step-up al banco',
      category: MuscleCategory.pierna,
      motion: MotionStyle.squat,
      cue: 'Sube al banco con una pierna y controla',
      equipment: EquipmentType.benchDumbbells,
    ),
    // Hombro
    GymExercise(
      id: 'press_hombro_mancuernas',
      name: 'Press de hombro',
      category: MuscleCategory.hombro,
      motion: MotionStyle.press,
      cue: 'Sentado o de pie, empuja vertical',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'elevaciones_laterales',
      name: 'Laterales de hombro con mancuernas',
      category: MuscleCategory.hombro,
      motion: MotionStyle.raise,
      cue: 'Sube a la altura de hombros',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'elevaciones_frontales',
      name: 'Elevaciones frontales',
      category: MuscleCategory.hombro,
      motion: MotionStyle.raise,
      cue: 'Controla la bajada',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'pajaros',
      name: 'Pájaros (deltoides posterior)',
      category: MuscleCategory.hombro,
      motion: MotionStyle.fly,
      cue: 'Inclínate y abre los brazos',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'press_arnold',
      name: 'Press Arnold',
      category: MuscleCategory.hombro,
      motion: MotionStyle.press,
      cue: 'Rota las mancuernas al subir',
      equipment: EquipmentType.dumbbells,
    ),
    // Brazo
    GymExercise(
      id: 'curl_biceps',
      name: 'Curl bíceps con mancuernas',
      category: MuscleCategory.brazo,
      motion: MotionStyle.curl,
      cue: 'Codos fijos, sin balancear',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'curl_martillo',
      name: 'Curl martillo con mancuernas',
      category: MuscleCategory.brazo,
      motion: MotionStyle.curl,
      cue: 'Agarre neutro y control',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'fondos_triceps',
      name: 'Fondos de tríceps en banco',
      category: MuscleCategory.brazo,
      motion: MotionStyle.press,
      cue: 'Baja hasta 90° y empuja',
      equipment: EquipmentType.benchBodyweight,
    ),
    GymExercise(
      id: 'extension_triceps',
      name: 'Extensión de tríceps overhead',
      category: MuscleCategory.brazo,
      motion: MotionStyle.press,
      cue: 'Mancuerna arriba, solo mueve antebrazos',
      equipment: EquipmentType.dumbbells,
    ),
    GymExercise(
      id: 'patada_triceps',
      name: 'Patada de tríceps',
      category: MuscleCategory.brazo,
      motion: MotionStyle.press,
      cue: 'Extiende el brazo atrás sin balancear',
      equipment: EquipmentType.dumbbells,
    ),
    // Core
    GymExercise(
      id: 'crunch',
      name: 'Crunch',
      category: MuscleCategory.core,
      motion: MotionStyle.crunch,
      cue: 'Enrolla el torso, no el cuello',
      equipment: EquipmentType.bodyweight,
    ),
    GymExercise(
      id: 'plancha',
      name: 'Plancha',
      category: MuscleCategory.core,
      motion: MotionStyle.crunch,
      cue: 'Cuerpo en línea, abdomen activo',
      equipment: EquipmentType.bodyweight,
    ),
    GymExercise(
      id: 'elevacion_piernas',
      name: 'Elevación de piernas',
      category: MuscleCategory.core,
      motion: MotionStyle.raise,
      cue: 'Sube con control sin balancear',
      equipment: EquipmentType.bodyweight,
    ),
    GymExercise(
      id: 'russian_twist',
      name: 'Russian twist',
      category: MuscleCategory.core,
      motion: MotionStyle.crunch,
      cue: 'Gira el torso; puedes usar mancuerna',
      equipment: EquipmentType.dumbbellsBodyweight,
    ),
    GymExercise(
      id: 'dead_bug',
      name: 'Dead bug',
      category: MuscleCategory.core,
      motion: MotionStyle.crunch,
      cue: 'Espalda pegada al piso, extiende opuesto',
      equipment: EquipmentType.bodyweight,
    ),
  ];

  static List<GymExercise> byCategory(MuscleCategory category) {
    return all.where((e) => e.category == category).toList();
  }

  static GymExercise byId(String id) {
    return all.firstWhere(
      (e) => e.id == id,
      orElse: () => all.first,
    );
  }
}
