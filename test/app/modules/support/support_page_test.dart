import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/support/support_page.dart';

main() {
  testWidgets('SupportPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(SupportPage(title: 'Support')));
    final titleFinder = find.text('Support');
    expect(titleFinder, findsOneWidget);
  });
}
