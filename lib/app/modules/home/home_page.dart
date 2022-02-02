import 'package:flutter/material.dart';
import 'package:app_digtec/app/models/ClassRunTimeVariables.dart';
import 'package:app_digtec/app/modules/home/home_bloc.dart';
import 'package:app_digtec/app/modules/home/widgets/homeCustomFirst/home_custom_first_widget.dart';
import 'package:app_digtec/app/modules/home/widgets/homeDefault/home_default_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Dashboard"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

HomeBloc homeBloc = HomeBloc();
bool exibiuMsgContrato = false;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  paramTemplate != 1 ? HomeCustomFirstWidget() : HomeDefaultWidget();
  }
}
