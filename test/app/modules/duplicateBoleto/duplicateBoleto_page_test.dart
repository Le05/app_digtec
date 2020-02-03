import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/duplicateBoleto/duplicateBoleto_page.dart';

main() {
  testWidgets('DuplicateBoletoPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestableWidget(DuplicateBoletoPage(title: 'DuplicateBoleto')));
    final titleFinder = find.text('DuplicateBoleto');
    expect(titleFinder, findsOneWidget);
  });
}
