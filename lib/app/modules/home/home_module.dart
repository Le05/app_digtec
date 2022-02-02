import 'package:app_digtec/app/modules/home/widgets/homeCustomFirst/widgets/IconsAcessRapid/icons_acess_rapid_bloc.dart';
import 'package:app_digtec/app/modules/home/widgets/homeCustomFirst/widgets/CardAcessoRapido/card_acesso_rapido_bloc.dart';
import 'package:app_digtec/app/modules/home/widgets/homeDefault/widgets/card/card_bloc.dart';
import 'package:app_digtec/app/modules/home/widgets/homeCustomFirst/home_custom_first_bloc.dart';
import 'package:app_digtec/app/modules/home/widgets/homeDefault/home_default_bloc.dart';
import 'package:app_digtec/app/modules/home/widgets/propaganda/propaganda_bloc.dart';
import 'package:app_digtec/app/modules/home/repository/home_repository.dart';
import 'package:app_digtec/app/modules/home/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/home/home_page.dart';
import 'package:app_digtec/app/modules/home/widgets/recommendation/recommendation_bloc.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => IconsAcessRapidBloc()),
        Bloc((i) => CardAcessoRapidoBloc()),
        Bloc((i) => CardBloc()),
        Bloc((i) => HomeCustomFirstBloc()),
        Bloc((i) => HomeDefaultBloc()),
        Bloc((i) => PropagandaBloc()),
        Bloc((i) => HomeBloc()),
        Bloc((i) => RecommendationBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => HomeRepository()),
      ];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
