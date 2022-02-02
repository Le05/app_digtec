import 'package:app_digtec/app/modules/duplicateBoleto/repository/duplicate_repository.dart';
import 'package:app_digtec/app/modules/duplicateBoleto/duplicateBoleto_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/duplicateBoleto/duplicateBoleto_page.dart';

class DuplicateBoletoModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => DuplicateBoletoBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => DuplicateRepository()),
      ];

  @override
  Widget get view => DuplicateBoletoPage();

  static Inject get to => Inject<DuplicateBoletoModule>.of();
}
