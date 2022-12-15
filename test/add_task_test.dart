import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:taskit/main.dart';
import 'package:taskit/widgets/addTask.dart';
import 'package:taskit/widgets/homePage.dart';
import './mock.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setupFirebaseMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('Test Add Task button functionality', () {
    testWidgets('Add Task button should be rendered',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: const MyApp(),
        navigatorObservers: [mockObserver],
      ));

      // Verify that add task button is rendered.
      expect(find.text('Add Task'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets(
        'Add Task button should navigate to AddTask Page where form is found',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: const MyApp(),
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.text('Add Task'));
      await tester.pumpAndSettle();

      // Verify that Add Task button navigates to Add Task Page
      expect(find.byType(AddTaskPage), findsOneWidget);

      expect(find.text('Task name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Enter your task name'),
          findsOneWidget);

      expect(find.text('Note'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Enter your note'),
          findsOneWidget);

      expect(find.text('Tag'), findsOneWidget);
      expect(
          find.widgetWithText(TextFormField, 'Enter your tag'), findsOneWidget);

      expect(find.text('Date'), findsOneWidget);
      expect(
          find.widgetWithText(
              TextFormField, DateFormat.yMd().format(DateTime.now())),
          findsOneWidget);
      expect(find.byIcon(Icons.calendar_today_outlined), findsOneWidget);

      expect(find.text('Start time'), findsOneWidget);
      expect(find.text('End time'), findsOneWidget);
      expect(find.byIcon(Icons.schedule_outlined), findsAtLeastNWidgets(2));

      expect(find.widgetWithText(ElevatedButton, 'Add Task'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Discard'), findsOneWidget);
    });
  });

  group('Test Add Task functionality', () {
    testWidgets('Discard button should be rendered and functional',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: const MyApp(),
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.text('Add Task'));
      await tester.pumpAndSettle();

      // Verify that Add Task button navigates to Add Task Page
      expect(find.byType(AddTaskPage), findsOneWidget);

      // Verify that Discard button is rendered
      expect(find.widgetWithText(ElevatedButton, 'Discard'), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Discard'));
      await tester.pump();

      // Verify that Discard button navigates to homepage on click
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets(
        'Test add task functionality, new task should be displayed in the homepage after successfully submitted',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: const MyApp(),
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.text('Add Task'));
      await tester.pumpAndSettle();

      // Verify that Add Task button navigates to Add Task Page
      expect(find.byType(AddTaskPage), findsOneWidget);

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Enter your task name'),
          'Test enter task name');

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Enter your note'),
          'Test enter task note');

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Enter your tag'),
          'Test enter task tag');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Add Task'));
      await tester.pump();

      // Verify new task has been added and displayed in home page
      expect(find.text('Test enter task name'), findsOneWidget);
      expect(find.text('Test enter task note'), findsOneWidget);
      expect(find.text('Test enter task tag'), findsOneWidget);
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
