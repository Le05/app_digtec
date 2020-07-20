import 'package:franet/app/modules/extractConsumption/extractConsumption_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/modules/extractConsumption/extractConsumption_page.dart';

class ExtractConsumptionModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ExtractConsumptionBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ExtractConsumptionPage();

  static Inject get to => Inject<ExtractConsumptionModule>.of();
}
