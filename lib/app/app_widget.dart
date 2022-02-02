import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:app_digtec/app/BDHive/initHive.dart';
import 'package:app_digtec/app/app_bloc.dart';
import 'package:app_digtec/app/modules/login/login_module.dart';
import 'package:app_digtec/app/modules/maintenance/maintenance_module.dart';

AppBloc appBloc = AppBloc();

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initHive(context: context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: Image.asset("images/loadinfo.gif"),
              color: Color(0xFF024428),
            );
          }
          if (snapshot.hasError) {
            return Container(
                child: Text("Ocorreu um erro ao iniciar os parametros no app"));
          }
          if (snapshot.data["error"] == "param_status") {
            return MaterialApp(title: 'Franet', home: MaintenanceModule());
          }
          return MaterialApp(
              title: 'Franet',
              theme: ThemeData(
                  primarySwatch: snapshot.data["color"],
                  textTheme: TextTheme(
                      headline4: TextStyle(color: snapshot.data["fontColor"]),
                      headline3: TextStyle(color: snapshot.data["fontColor"]),
                      headline2: TextStyle(color: snapshot.data["fontColor"]),
                      headline1: TextStyle(color: snapshot.data["fontColor"]),
                      headline6: TextStyle(
                          color: snapshot.data["fontColor"],
                          fontWeight: FontWeight.bold))),
              home: LoginModule());
        });
  }
}
