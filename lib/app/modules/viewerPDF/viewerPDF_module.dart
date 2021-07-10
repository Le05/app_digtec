import 'package:franet/app/modules/viewerPDF/viewerPDF_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:franet/app/modules/viewerPDF/viewerPDF_page.dart';

class ViewerPDFModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ViewerPDFBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ViewerPDFPage();

  static Inject get to => Inject<ViewerPDFModule>.of();
}
