import 'package:app_digtec/app/modules/maintenance/maintenance_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/maintenance/maintenance_page.dart';

class MaintenanceModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => MaintenanceBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MaintenancePage();

  static Inject get to => Inject<MaintenanceModule>.of();
}
