import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/testVelocity/testVelocity_bloc.dart';
import 'package:franet/app/modules/testVelocity/testVelocity_module.dart';

void main() {
  initModule(TestVelocityModule());
  TestVelocityBloc bloc;

  setUp(() {
    bloc = TestVelocityModule.to.bloc<TestVelocityBloc>();
  });

  group('TestVelocityBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<TestVelocityBloc>());
    });
  });
}
