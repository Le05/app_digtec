import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/duplicateBoleto/duplicateBoleto_bloc.dart';
import 'package:franet/app/modules/duplicateBoleto/duplicateBoleto_module.dart';

void main() {
  initModule(DuplicateBoletoModule());
  DuplicateBoletoBloc bloc;

  setUp(() {
    bloc = DuplicateBoletoModule.to.bloc<DuplicateBoletoBloc>();
  });

  group('DuplicateBoletoBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<DuplicateBoletoBloc>());
    });
  });
}
