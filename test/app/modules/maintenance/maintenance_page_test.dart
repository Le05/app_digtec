import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/maintenance/maintenance_page.dart';

main() {
  testWidgets('MaintenancePage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(MaintenancePage(title: 'Maintenance')));
    final titleFinder = find.text('Maintenance');
    expect(titleFinder, findsOneWidget);
  });
}
