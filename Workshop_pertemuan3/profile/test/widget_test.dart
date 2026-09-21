// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:profile/main.dart';

void main() {
  testWidgets('profile page shows editable name', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Profil Saya'), findsOneWidget);
    expect(find.text('Aulia Rahma'), findsNothing);
    expect(find.byType(TextField), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.edit_outlined));
    await tester.pump();

    expect(find.text('Simpan perubahan'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });
}
