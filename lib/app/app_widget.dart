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
    appBloc.initOneSignal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Franet',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: FutureBuilder(
            future: initHive(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green,
                );
              }
              return LoginModule();
            }));
  }
}

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;