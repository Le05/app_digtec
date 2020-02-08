import 'package:franet/app/modules/support/repository/support_repository.dart';
import 'package:franet/app/modules/support/support_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/modules/support/support_page.dart';

class SupportModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SupportBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => SupportRepository()),
      ];

  @override
  Widget get view => SupportPage();

  static Inject get to => Inject<SupportModule>.of();
}
