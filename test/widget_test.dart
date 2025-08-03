import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shartflix/main.dart';

void main() {
  testWidgets('Shartflix app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ShartflixApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
