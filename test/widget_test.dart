import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_gym/main.dart';

void main() {
  testWidgets('Welcome to named custom session', (WidgetTester tester) async {
    await tester.pumpWidget(const AppGym());
    await tester.pumpAndSettle();

    expect(find.text('APPGYM'), findsOneWidget);
    expect(find.text('SESIÓN PERSONALIZADA'), findsOneWidget);
    expect(find.text('SESIONES DEFINIDAS'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'SESIÓN PERSONALIZADA'));
    await tester.pumpAndSettle();

    expect(find.text('¿Quieres elegir grupo muscular?'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'SÍ, ELEGIR GRUPO'));
    await tester.pumpAndSettle();

    expect(find.text('¿QUÉ ENTRENAS?'), findsOneWidget);
    expect(find.text('PECHO'), findsOneWidget);

    await tester.tap(find.text('PECHO'));
    await tester.pumpAndSettle();

    expect(find.text('INICIAR ENTRENAMIENTO'), findsOneWidget);
    expect(find.text('Cantidad de ejercicios'), findsOneWidget);
    expect(find.text('Press de banca con mancuernas'), findsWidgets);
  });

  testWidgets('Anonymous custom session has no exercise selects',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AppGym());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'SESIÓN PERSONALIZADA'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(OutlinedButton, 'NO, SIN GRUPO'));
    await tester.pumpAndSettle();

    expect(find.text('SIN GRUPO'), findsOneWidget);
    expect(find.text('Ejercicio 1'), findsOneWidget);
    expect(find.text('Series'), findsWidgets);
    expect(find.byType(DropdownButtonFormField<String>), findsNothing);
    expect(find.text('INICIAR ENTRENAMIENTO'), findsOneWidget);
  });

  testWidgets('Welcome to preset sessions', (WidgetTester tester) async {
    await tester.pumpWidget(const AppGym());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(OutlinedButton, 'SESIONES DEFINIDAS'));
    await tester.pumpAndSettle();

    expect(find.text('SESIONES DEFINIDAS'), findsWidgets);
    expect(find.text('SESIÓN 1'), findsOneWidget);
    expect(find.text('Ejercicios de pecho y hombro'), findsOneWidget);
    expect(find.text('SESIÓN 2'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('SESIÓN 3'),
      100,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('SESIÓN 3'), findsOneWidget);
    expect(find.text('Ejercicios de pierna y brazo'), findsOneWidget);
  });
}
