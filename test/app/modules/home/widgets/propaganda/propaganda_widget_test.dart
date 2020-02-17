import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/home/widgets/propaganda/propaganda_widget.dart';

main() {
  testWidgets('PropagandaWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(PropagandaWidget()));
    final textFinder = find.text('Propaganda');
    expect(textFinder, findsOneWidget);
  });
}
