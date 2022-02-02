import 'package:app_digtec/app/models/ContractsModel.dart';
import 'package:app_digtec/app/modules/chooseContracts/chooseContracts_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/chooseContracts/chooseContracts_page.dart';

class ChooseContractsModule extends ModuleWidget {
  final List<Contracts> contracts;

  ChooseContractsModule(this.contracts);

  @override
  List<Bloc> get blocs => [
        Bloc((i) => ChooseContractsBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
      ];

  @override
  Widget get view => ChooseContractsPage(contracts: contracts,);

  static Inject get to => Inject<ChooseContractsModule>.of();
}
