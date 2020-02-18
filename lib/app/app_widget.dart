import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:franet/app/BDHive/initHive.dart';
import 'package:franet/app/app_bloc.dart';
import 'package:franet/app/modules/login/login_module.dart';

AppBloc appBloc = AppBloc();

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    //alterColor(color: 0xFF409d42);
    appBloc.initOneSignal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initHive(context: context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              color: Colors.green,
            );
          }
          if (snapshot.hasError) {
            return Container(
                child: Text("Ocorreu um erro ao iniciar os parametros no app"));
          }
          return MaterialApp(
              title: 'Franet',
              theme: ThemeData(
                primarySwatch: snapshot.data["color"],
              ),
              home: LoginModule());
        });
  }
}
