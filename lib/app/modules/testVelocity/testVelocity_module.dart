import 'package:franet/app/modules/testVelocity/testVelocity_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/modules/testVelocity/testVelocity_page.dart';

class TestVelocityModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => TestVelocityBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => TestVelocityPage();

  static Inject get to => Inject<TestVelocityModule>.of();
}
