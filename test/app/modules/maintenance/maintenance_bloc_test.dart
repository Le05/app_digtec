import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:franet/app/modules/maintenance/maintenance_bloc.dart';
import 'package:franet/app/modules/maintenance/maintenance_module.dart';

void main() {
  initModule(MaintenanceModule());
  MaintenanceBloc bloc;

  setUp(() {
    bloc = MaintenanceModule.to.bloc<MaintenanceBloc>();
  });

  group('MaintenanceBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<MaintenanceBloc>());
    });
  });
}
