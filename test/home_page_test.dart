// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:taskit/main.dart';
import './mock.dart';

void main() {
  setupFirebaseMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('Add Task button, today\'s day widgets should be rendered',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that add task button is rendered.
    expect(find.text('Add Task'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify that Today widget is rendered.
    expect(find.text('Today'), findsOneWidget);

    // Verify that Today's date widget is rendered and displayed in readable format.
    expect(
        find.text(DateFormat.yMMMMd().format(DateTime.now())), findsOneWidget);

    expect(find.text('Tasks'), findsOneWidget);
  });

  testWidgets(
      'Search icon should be rendered and functional, UI changes to search mode',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that search icon is rendered.
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Tap on search icon button
    await tester.tap(find.byIcon(Icons.search));

    // Rebuild the widget after the state has changed
    await tester.pump();

    // Expect to find a input Text Field with 'Search tasks' as a placeholder
    expect(find.text('Search tasks'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Expect to find a dropdown widget with 'Name' is a first option
    expect(find.byType(DropdownButtonHideUnderline), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);

    // Instead of showing Task, Results should be displayed when user changes to Search mode
    expect(find.text('Results'), findsOneWidget);
  });

  testWidgets('DatePicker should be rendered', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that add task button is rendered.
    expect(find.byType(DatePicker), findsOneWidget);
  });
}
