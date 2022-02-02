import 'package:app_digtec/app/modules/extractConsumption/widgets/ConsumptioImages/ConsumptioImages_bloc.dart';
import 'package:app_digtec/app/modules/extractConsumption/widgets/Consumption/Consumption_bloc.dart';
import 'package:app_digtec/app/modules/extractConsumption/repository/extractConsumption_repository.dart';
import 'package:app_digtec/app/modules/extractConsumption/extractConsumption_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/extractConsumption/extractConsumption_page.dart';

class ExtractConsumptionModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ConsumptioImagesBloc()),
        Bloc((i) => ConsumptionBloc()),
        Bloc((i) => ExtractConsumptionBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => ExtractConsumptionRepository()),
      ];

  @override
  Widget get view => ExtractConsumptionPage();

  static Inject get to => Inject<ExtractConsumptionModule>.of();
}
