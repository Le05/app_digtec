import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/extractConsumption/extractConsumption_bloc.dart';
import 'package:franet/app/modules/extractConsumption/extractConsumption_module.dart';

void main() {
  initModule(ExtractConsumptionModule());
  ExtractConsumptionBloc bloc;

  // setUp(() {
  //     bloc = ExtractConsumptionModule.to.bloc<ExtractConsumptionBloc>();
  // });

  // group('ExtractConsumptionBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<ExtractConsumptionBloc>());
  //   });
  // });
}
