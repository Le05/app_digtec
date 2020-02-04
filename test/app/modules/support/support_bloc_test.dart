import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/support/support_bloc.dart';
import 'package:franet/app/modules/support/support_module.dart';

void main() {
  initModule(SupportModule());
  SupportBloc bloc;

  setUp(() {
    bloc = SupportModule.to.bloc<SupportBloc>();
  });

  group('SupportBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<SupportBloc>());
    });
  });
}
