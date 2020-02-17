import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/home/widgets/propaganda/propaganda_bloc.dart';
import 'package:franet/app/modules/home/home_module.dart';

void main() {
  initModule(HomeModule());
  PropagandaBloc bloc;

  setUp(() {
    bloc = HomeModule.to.bloc<PropagandaBloc>();
  });

  group('PropagandaBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<PropagandaBloc>());
    });
  });
}
