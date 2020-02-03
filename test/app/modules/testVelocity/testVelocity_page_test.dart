import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/testVelocity/testVelocity_page.dart';

main() {
  testWidgets('TestVelocityPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestableWidget(TestVelocityPage(title: 'TestVelocity')));
    final titleFinder = find.text('TestVelocity');
    expect(titleFinder, findsOneWidget);
  });
}
