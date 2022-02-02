import 'package:app_digtec/app/modules/precadastro/precadastro_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/precadastro/precadastro_page.dart';

class PrecadastroModule extends ModuleWidget {
  final String url;
  final String tipo; 
  PrecadastroModule(this.url,this.tipo);
  
  @override
  List<Bloc> get blocs => [
        Bloc((i) => PrecadastroBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => PrecadastroPage(url: url,tipo: tipo,);

  static Inject get to => Inject<PrecadastroModule>.of();
}
