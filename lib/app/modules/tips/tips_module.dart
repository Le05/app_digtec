import 'package:app_digtec/app/modules/tips/widgets/moreTips/moreTips_bloc.dart';
import 'package:app_digtec/app/modules/tips/tips_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/tips/tips_page.dart';

class TipsModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => MoreTipsBloc()),
        Bloc((i) => TipsBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => TipsPage();

  static Inject get to => Inject<TipsModule>.of();
}
