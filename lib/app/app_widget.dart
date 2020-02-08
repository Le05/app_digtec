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
    return StreamBuilder(
      initialData: alterColor(color:0xFF409d42),
      stream: appBloc.outputColor,
      builder: (context, snapshot) {
        return MaterialApp(
            title: 'Franet',
            theme: ThemeData(
              primarySwatch: snapshot.data,
            ),
            home: FutureBuilder(
                future: initHive(context: context),
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
    );
  }
}

alterColor({var color}) {
   int _cPrimaryValue = color;
  MaterialColor primary = MaterialColor(
    _cPrimaryValue,
    <int, Color>{
      50: Color(color),
      100: Color(color),
      200: Color(color),
      300: Color(color),
      400: Color(color),
      500: Color(_cPrimaryValue),
      600: Color(color),
      700: Color(color),
      800: Color(color),
      900: Color(color),
    },
  );
  return primary;
}
