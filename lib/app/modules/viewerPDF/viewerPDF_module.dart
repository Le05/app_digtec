import 'package:app_digtec/app/modules/viewerPDF/viewerPDF_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app_digtec/app/modules/viewerPDF/viewerPDF_page.dart';

class ViewerPDFModule extends ModuleWidget {
  final String url;

  ViewerPDFModule(this.url);
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ViewerPDFBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ViewerPDFPage(url: this.url);

  static Inject get to => Inject<ViewerPDFModule>.of();
}
